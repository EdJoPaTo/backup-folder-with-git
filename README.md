# Backup Folder with Git

Backup up data in text files with git is my way to go as git is a known tool for
many, offers versions in the history and works well for my use case.

## Usage

This container is meant to be used by someone understanding the logic within
[`main.sh`](main.sh).

You have to specify an SSH key in the folder `/root/.ssh/` (for example
`/root/.ssh/id_ed25519`). This is best done via container secret files. Use a
separate ssh key for the backup repo and only to this repo. GitHub has a "Deploy
keys" section in the repo settings to do this.

When using your own git server you also need to specify
`/root/.ssh/known_hosts`. The predefined one is only for GitHub as an example.

You have to set the following environment variables:

- `REPO=git@github.com:EdJoPaTo/secret-backup.git`

Additionally, there are a few ways to configure the process with more
environment variables:

- `INTERVAL_MINUTES` should be a number of minutes to wait between two backups.
  Defaults to `300` = 5 hours.
  Set to `0` to stop after first run.
- `DATAPATH` can be used to back up only a path within the `/data` mount.
- `BACKUPPATH` is the same for a path within the backup repository.
