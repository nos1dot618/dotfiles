Add the following line in "sudoers", so that `brightnessctl` work with root priviledges without prompting for password. Launch "sudoers" file in default editor using `sudo visudo`:
```bash
nosferatu ALL=(ALL) NOPASSWD: /usr/bin/brightnessctl
```