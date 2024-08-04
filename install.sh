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
