# Keyd Configuration Sync

This repository contains a synced configuration for the keyd key remapping daemon, allowing for easy setup and synchronization across multiple Linux machines.

## Contents

- `default.conf`: The main keyd configuration file
- `install.sh`: A script to install the configuration and set up symlinks
- `README.md`: This file, containing setup and usage instructions

## Setup Instructions

### Initial Setup (on your main machine)

1. Create a directory for your keyd configuration:

   ```bash
   mkdir ~/keyd-config
   cd ~/keyd-config
   ```

2. Initialize a Git repository:

   ```bash
   git init
   ```

3. Copy your current keyd configuration into this directory:

   ```bash
   sudo cp /etc/keyd/default.conf ~/keyd-config/
   ```

4. Create the install script (`install.sh`) with the following content:

   ```bash
   #!/bin/bash

   # Check if running as root
   if [ "$EUID" -ne 0 ]
     then echo "Please run as root"
     exit
   fi

   # Remove existing default.conf if it exists
   rm -f /etc/keyd/default.conf

   # Create symlink
   ln -s $(pwd)/default.conf /etc/keyd/default.conf

   # Reload keyd
   keyd reload

   echo "Keyd configuration installed and reloaded!"
   ```

5. Make the script executable:

   ```bash
   chmod +x install.sh
   ```

6. Add your files to the Git repository:

   ```bash
   git add default.conf install.sh README.md
   git commit -m "Initial keyd configuration"
   ```

7. Create a GitHub repository (or use another Git hosting service) and push your local repository to it:

   ```bash
   git remote add origin https://github.com/yourusername/keyd-config.git
   git branch -M main
   git push -u origin main
   ```

### Setting Up on Additional Machines

1. Install keyd if it's not already installed (follow keyd installation instructions for your distribution)

2. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/keyd-config.git ~/keyd-config
   ```

3. Run the install script:

   ```bash
   cd ~/keyd-config
   sudo ./install.sh
   ```

## Updating Configuration

When you want to update your configuration:

1. Make changes to `~/keyd-config/default.conf` on any machine

2. Commit and push your changes:

   ```bash
   git commit -am "Updated configuration"
   git push
   ```

3. On other machines, pull the changes and run the install script:

   ```bash
   git pull
   sudo ./install.sh
   ```

## Important Notes

- Always review changes before running the install script, especially when pulling updates from a shared repository.
- The install script will overwrite the existing keyd configuration. Make sure to backup any important configurations before running it.
- This setup allows you to track changes to your configuration over time and easily roll back to previous versions if needed.

