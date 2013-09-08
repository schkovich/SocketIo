#!/bin/bash -e

# See http://serverfault.com/questions/500764/dpkg-reconfigure-unable-to-re-open-stdin-no-file-or-directory
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
sudo locale-gen en_GB.UTF-8
sudo dpkg-reconfigure locales
sudo apt-get install --yes lsb-release
DISTRIB_CODENAME=$(lsb_release --codename --short)
# Puppet 3.0+ is not yet available in Raring repository
# See http://projects.puppetlabs.com/issues/20608
if [ "raring" = $DISTRIB_CODENAME ]
then
    DISTRIB_CODENAME="quantal"
fi
DEB="puppetlabs-release-${DISTRIB_CODENAME}.deb"
DEB_PROVIDES="/etc/apt/sources.list.d/puppetlabs.list"

# Assume that this file's existence means we have the Puppet Labs repo added
if [ ! -e $DEB_PROVIDES ]
then
    # Print statement useful for debugging, but automated runs of this will interpret any output as an error
    # print "Could not find $DEB_PROVIDES - fetching and installing $DEB"
    wget -q http://apt.puppetlabs.com/$DEB
    sudo dpkg -i $DEB
fi

sudo apt-get purge puppet --yes
sudo apt-get autoremove --yes
sudo apt-get update
sudo apt-get install --yes puppet
