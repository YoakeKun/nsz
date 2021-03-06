#!/bin/bash
if [[ `id -u` != 0 ]]; then
    echo "This script must be run as root."
    exit
fi

if [ -n "`which apt`" ]
then
	apt install -y \
		build-essential \
		git \
		python3 \
		python3-dev \
		python3-pip \
		ffmpeg \
		libsdl2-dev \
		libsdl2-image-dev \
		libsdl2-mixer-dev \
		libsdl2-ttf-dev \
		libportmidi-dev \
		libswscale-dev \
		libavformat-dev \
		libavcodec-dev \
		zlib1g-dev
		
	# Install gstreamer for audio, video (optional)
	apt install -y \
		libgstreamer1.0 \
		gstreamer1.0-plugins-base \
		gstreamer1.0-plugins-good
elif [ -n "`which dnf`" ]
then
	dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	# Install necessary system packages
	dnf install -y python3-devel ffmpeg-libs SDL2-devel SDL2_image-devel SDL2_mixer-devel SDL2_ttf-devel portmidi-devel libavdevice libavc1394-devel zlibrary-devel ccache mesa-libGL mesa-libGL-devel
	# Install xclip in case you run a kivy app using your computer, and the app requires a CutBuffer provider:
	dnf install -y xclip
	
	# In case you get the following error preventing kivy install:
	#  annobin: _event.c: Error: plugin built for compiler version (8.0.1) but run with compiler version (8.1.1)
	#  cc1: error: fail to initialize plugin /usr/lib/gcc/86_64-redhat-linux/8/plugin/annobin.so
	# This has been resolved in later updates after the on-disk release of Fedora 28, so upgrade your packages:
	#  sudo dnf -y upgrade
	
	# avoid pip Cython conflict with packaged version:
	dnf remove python3-Cython
fi


# make sure pip, virtualenv and setuptools are updated
python3 -m pip install --upgrade --user pip virtualenv setuptools

# then create a virtualenv named "kivy_venv" in your home with:
#python3 -m virtualenv ~/kivy_venv

# load the virtualenv
#source ~/kivy_venv/bin/activate

# if you'd like to be able to use the x11 winodw backend do:
export USE_X11=1

# install the correct Cython version
python3 -m pip install Cython==0.29.10

# Install stable version of Kivy into the virtualenv
python3 -m pip install --no-binary :all kivy==1.11.1


python3 -m pip install pycryptodome>=3.9.0
python3 -m pip install zstandard
python3 -m pip install enlighten
