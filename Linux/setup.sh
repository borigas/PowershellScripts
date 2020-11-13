#!/bin/bash

# Map path for profile sharing
if [ ! -e ~/profile ]; then
    echo "Linking ~/profile"
    ln -s /mnt/c/workspaces/Settings/Linux/Profile/ ~/profile
else
    echo "~/profile already exists"
fi

# Map path for k8s config sharing
kubePath="$( wslpath $(wslvar USERPROFILE))/.kube/"
if [ ! -e ~/.kube ]; then
    echo "Linking $kubePath to ~/.kube"
    ln -s $kubePath ~/.kube
else
    echo "~/.kube already exists"
fi

# Map path for Azure config sharing
kubePath="$( wslpath $(wslvar USERPROFILE))/.azure/"
if [ ! -e ~/.azure ]; then
    echo "Linking $kubePath to ~/.azure"
    ln -s $kubePath ~/.azure
else
    echo "~/.azure already exists"
fi



# TODO Make sure profile.sh is included in .bashrc
syncedProfilePath="~/profile/profile.sh"
profilePath=~/.profile
if [ -z "$(grep "$syncedProfilePath" $profilePath)" ]; then
    echo "Appending $syncedProfilePath to $profilePath"
    
    echo -en "\n" >> $profilePath
    echo -en "\n" >> $profilePath
    echo "####   My Synced Profile   ####" >> $profilePath
    echo ". $syncedProfilePath" >> $profilePath
else
    echo "Profile already in $profilePath";
fi

echo "Done"