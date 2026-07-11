#!/usr/bin/env python3
import sys
import subprocess

from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import (
    QApplication,
    QWidget,
    QVBoxLayout,
    QLabel,
    QTextEdit,
    QCheckBox,
)

class ControlPanel(QWidget):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Control Panel")
        self.resize(500, 300)

        self.layout = QVBoxLayout()

        self.add_cloudflare_warp_controls()

        self.output = QTextEdit()
        self.output.setReadOnly(True)
        self.layout.addWidget(self.output)

        self.setLayout(self.layout)

    def add_cloudflare_warp_controls(self):
        title = QLabel("Cloudflare Warp Controls")
        title.setStyleSheet("font-size: 20px;")
        self.layout.addWidget(title)

        self.vpn_toggle = QCheckBox("VPN Enabled")
        self.vpn_toggle.stateChanged.connect(self.toggle_vpn_handler)
        self.layout.addWidget(self.vpn_toggle)

        self.vpn_status_label = QLabel("Checking status...")
        self.layout.addWidget(self.vpn_status_label)

        self.refresh_status()

    def get_cloudflare_warp_status(self):
        stdout, _ = self.run_command(["warp-cli", "status"])
        return "Status: Connected" in stdout, stdout.split("\n")[0]

    def refresh_status(self):
        connected, status = self.get_cloudflare_warp_status()
        self.vpn_toggle.blockSignals(True)
        self.vpn_toggle.setChecked(connected)
        self.vpn_toggle.blockSignals(False)
        self.vpn_status_label.setText(status)

    def toggle_vpn_handler(self, state):
        enabled = state == Qt.Checked

        self.output.append("---")
        if enabled:
            self.output.append("Enabling Warp...")
            mode_out, _ = self.run_command(["warp-cli", "settings"])
            if "Mode: warp+doh" not in mode_out: self.run_command(["warp-cli", "mode", "warp+doh"])
            stdout, stderr = self.run_command(["warp-cli", "connect"])
        else:
            self.output.append("Disabling Warp...")
            stdout, stderr = self.run_command(["warp-cli", "disconnect"])

        if stdout: self.output.append(stdout)
        if stderr: self.output.append(stderr)

        self.refresh_status()

    def run_command(self, command):
        result = subprocess.run(command, capture_output=True, text=True)
        return result.stdout.strip(), result.stderr.strip()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = ControlPanel()
    window.show()
    sys.exit(app.exec_())
