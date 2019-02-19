# Setting up a build environment
---

## Linux

### Pre-requisites

It is best to set up a build environment on Ubuntu 16.04. It brings the right versions of libc and libstdc++ that ensures maximum compatibility. You can build on newer versions of Linux distros, but binaries compiled on these platforms may not work on older versions.

``` bash
# build dependencies
sudo apt install clang g++ build-essential make mingw-w64 git pkg-config libc6-dev m4 g++-multilib autoconf libtool-bin ncurses-dev unzip python python-zmq zlib1g-dev wget curl bsdmainutils automake libgl1-mesa-dev libglu1-mesa-dev libfontconfig1-dev autopoint libssl-dev

# MXE dependencies
sudo apt install bash bison bzip2 flex  gettext git gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libltdl-dev  libtool-bin libxml-parser-perl make openssl p7zip-full patch perl pkg-config python ruby sed unzip wget xz-utils

```

### Compile OpenSSL

You need to compile a static version of OpenSSL, which is passed to the Qt5 configuration script.

``` bash
# Download openssl 1.0.2
./Configure linux-x86_64
make
```

### Static build of Qt5

Download Qt5 sources

``` bash
mkdir -p ~/Qt/5.11.2 && cd ~/Qt/5.11.2

wget https://download.qt.io/archive/qt/5.11/5.11.2/single/qt-everywhere-src-5.11.2.tar.xz
tar xvf qt-everywhere-src-5.11.2.tar.xz && cd qt-everywhere-src-5.11.2
```

Configure and build Qt5 statically.

``` bash
OPENSSL_LIBS='-L/path/to/openssl-1.0.2q -lssl -lcrypto' ./configure -static -prefix ~/Qt/5.11.2/static  -skip qtlocation -skip qtmacextras -skip qtpurchasing -skip qtscript -skip qtsensors -skip qtserialbus -skip qtserialport -skip qtspeech -skip qtdatavis3d -skip qtdoc -skip qtcharts -skip qtdeclarative -skip qt3d -skip qtwebengine -skip qtandroidextras -skip qtwebview -skip qtgamepad -skip qtquickcontrols -skip qtquickcontrols2 -skip qtremoteobjects -skip qtwebview -skip qtwebchannel -skip qtwebglplugin  -nomake examples -nomake tests -qt-zlib -qt-libpng -qt-xcb -qt-xkbcommon -feature-fontconfig -no-feature-getentropy  -release -openssl-linked -opensource

make -j$(nproc)
make -j$(nproc) install
```


### Build MXE (Cross-compiled Qt5 for Windows in Linux)

``` bash
mkdir ~/github && cd ~/github
git clone https://github.com/mxe/mxe.git
cd mxe

make -j$(nproc) MXE_TARGETS=x86_64-w64-mingw32.static qtbase qtwebsockets
```

### Build zec-qt-wallet

``` bash
git clone git@github.com:ZcashFoundation/zec-qt-wallet.git
~/Qt/5.11.2/static/bin/qmake zec-qt-wallet.pro CONFIG+=debug-spec linux-clang

make -j$(nproc)
```

### Compiling `zcashd` for embedded zcashd

!!! info "Compile embedded `zcashd` from adityapk00/zcashd"
    The zcashd compilation is specific to [adityapk00/zcashd](https://github.com/adityapk00/zcash) as there are some custom patches for new RPC calls that help with the embedding of zcashd that are not included in the upstream [zcash/zcash](https://github.com/zcash/zcash) repository.

``` bash
git clone git@github.com:adityapk00/zcash zcash-linux
git clone git@github.com:adityapk00/zcash zcash-win
mkdir -p ~/zcash/artifacts # Built zcashd goes here.
```

Note that we create two separate folders because we're going to compile `zcashd` for Windows and Linux. 

**Build `zcashd` windows**

``` bash
cd zcash-win
./mkreleasewin.sh
```

**Build `zcashd` Linux**

``` bash
cd zcash-linux
./mkreleaselinux.sh
```

### Setup Environment

Add the following paths to your `~/.bashrc`. Remember to add it at the very top, before the interactivity check, because we need these variables even in an ssh shell.

``` bash
export QT_STATIC=~/Qt/5.11.2/static/
export MXE_PATH=~/github/mxe/usr/bin/
export ZCASH_DIR=~/github/zcash
```

### Make release build

``` bash
PREV_VERSION=0.2.5 APP_VERSION=0.2.6 src/scripts/mkrelease.sh
```

This will put all the Windows and Linux compiled binaries into the `artifacts` folder

## macOS

Install Xcode or Xcode Command Line Tools, and then install Qt 5.11.

From a terminal:

``` bash
cd ~/github/zec-qt-wallet/
APP_VERSION=0.3.0 src/scripts/mkmacdmg.sh
```
This will build the app and package it into a dmg and place it in the `artifacts/` folder

### Building `zcashd`

``` bash
git clone git@github.com:adityapk00/zcash
cd zcash 
./zcutil/build.sh -j$(nproc)
```

## Windows

Even though zec-qt-wallet for Windows is cross-compiled on Linux, we still need a Windows machine to build the installer. The Windows installer is built using WiX toolset. Install WiX toolset 3.11.1 from [here](http://wixtoolset.org/releases/). After installation, add the directory to the system path (both `candle.exe` and `light.exe` are runnable)

To build the installer, in Powershell, run:

``` bash
APP_VERSION=0.3.0 src/scripts/mkwininstaller.ps1
```

## Running the unified build

After all these 3 machines have been set up, we can build all the release artifacts (Windows, Linux, macOS binaries and installers) with one command, triggered from the Windows machine.

(Replace `u1604 `and `macmini` with names of the Linux and macOS machines respectively)

``` bash
cd ~/github/zec-qt-wallet
.\src\scripts\dobuild.ps1 -version 0.4.1 -prev 0.4.0 -server u1604 -macserver macmini
```

This will build all three platforms and their installers, and place everything in the `artifacts` folder on the Windows machine.