# Backup2Mail - Automatic backups via e-mail

## Goal

This project aim to make it easy to backup directories instantly and save backups over email to specified address using SMTP of your choice.

Please note that this script allow transfer of backups less than 10MB in size. In future there will be option to backup to external server and send download link over email.

## Usage

```
Usage: backup2mail [-v|-h] -d <directory>
    -v             -- Verbose mode
    -h             -- Help page
    -d <directory> -- directory to take backup of
```

## To Do

 - [ ] Add SMTP integration
 - [ ] Create interactive mode using dialogs (for selecting files / directories)
 - [ ] Create configuration file support
 - [ ] Create custom argument parser for this script
 - [ ] Create `setup.sh` file for installing this tool globally

## Author

@MatthevDev 💻
