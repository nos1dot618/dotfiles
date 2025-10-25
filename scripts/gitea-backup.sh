#!/usr/bin/env bash

# Shell script for backing up Gitea-Data to G-Drive

export RCLONE_CONFIG=/home/ninthcircle/.config/rclone/rclone.conf

# Temp backup directory
BACKUP_DIR=/tmp/gitea-backup-$(date +%F)
mkdir -p $BACKUP_DIR

GITEA_DATA=/var/lib/gitea/data
GITEA_CONFIG=/etc/gitea/app.ini

# Backup repositories, DB, attachments, avatars, packages
tar -czf $BACKUP_DIR/gitea-repos.tar.gz -C $GITEA_DATA gitea-repositories
cp    $GITEA_DATA/gitea.db           $BACKUP_DIR/
cp -r $GITEA_DATA/actions_artifacts  $BACKUP_DIR/
cp -r $GITEA_DATA/attachments        $BACKUP_DIR/
cp -r $GITEA_DATA/avatars            $BACKUP_DIR/
cp -r $GITEA_DATA/packages           $BACKUP_DIR/
cp -r $GITEA_DATA/lfs                $BACKUP_DIR/
# Backup config
cp    $GITEA_CONFIG                  $BACKUP_DIR/

# Upload to G-Drive (encrypted)
rclone sync $BACKUP_DIR gitea-crypt: --progress

# Clean up
rm -rf $BACKUP_DIR
