#!/bin/bash
# Deploy cradmin, ARD and SSH access for cradmin, and the FileWave client.

# CRADMIN
###Install CR Administrator account
# Part 1: Download cradmin installer from AWS instance to /tmp.
/usr/bin/curl http://deploy.crtg.io/crtg_items/create_cradmin_kala-1.1.pkg > /tmp/create_cradmin_kala-1.1.pkg
# Part 2: Install then remove package
/usr/sbin/installer -target / -pkg /tmp/create_cradmin_kala-1.1.pkg
/bin/rm /tmp/create_cradmin_kala-1.1.pkg

###Enable ARD and SSH for CRADMIN user
#Enable ARD for Specific Users
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -specifiedUsers
#Enable ARD Agent for CRADMIN
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users cradmin -privs -all -restart -agent -menu
#Enable SSH
systemsetup -setremotelogin on
#Create SSH Group
dseditgroup -o create -q com.apple.access_ssh
#Add CRADMIN to SSH Group
dseditgroup -o edit -a cradmin -t user com.apple.access_ssh

###Install FileWave Custom Installer
# Part 1: Download FW installer from AWS instance to /tmp.
/usr/bin/curl http://deploy.crtg.io/FileWave/ClientInstaller/FileWaveClient10.1.1_fw.crtg.io.pkg > /tmp/FileWaveClient10.1.1_fw.crtg.io.pkg
# Part 2: Install then remove package.
/usr/sbin/installer -target / -pkg /tmp/FileWaveClient10.1.1_fw.crtg.io.pkg
/bin/rm /tmp/FileWaveClient10.1.1_fw.crtg.io.pkg