# Backup Folder with Git

Backup up data in text files with git is my way to go as git is a known tool for many, offers versions in the history and works well for my use case.

## Usage

This container is meant to be used by someone understanding the logic within [`main.sh`](main.sh).

You have to specify an SSH key in the folder `/root/.ssh/` (for example `/root/.ssh/id_ed25519`).
This is best done via container secret files.
Add the ssh public key to the backup repo and only to this repo.
GitHub has a "Deploy keys" section in the repo settings.

You have to set the following environment variables:

- `REPO=git@github.com:EdJoPaTo/secret-backup.git`

Additionally, there are a few ways to configure the process with more environment variables:

- `INTERVAL_MINUTES` should be a number of minutes to wait between two backups. Defaults to `300` = 5 hours.
- `DATAPATH` can be used to back up only a path within the `/data` mount.
- `BACKUPPATH` is the same for a path. It backs up into a given path within the backup repository.
