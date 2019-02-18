# Installing zec-qt-wallet
---

## Download and Install

zec-qt-wallet runs on Windows, macOS and Linux and is [available to download](https://github.com/ZcashFoundation/zec-qt-wallet/releases) from the releases page of the project [Github repository](https://github.com/ZcashFoundation/zec-qt-wallet/). Follow the instructions below for the platform of your choice to install zec-qt-wallet. To compile from source see [this section](compile-from-source).

??? info "Windows instructions (click to expand)"

    [Download](https://github.com/ZcashFoundation/zec-qt-wallet/releases) and run the .msi installer (named `Windows-installer-zec-qt-wallet-v0.5.9.msi`) and follow the prompts. Alternately, you can [download](https://github.com/ZcashFoundation/zec-qt-wallet/releases) the release binary (named `Windows-binaries-zec-qt-wallet-v0.5.9.zip`), unzip it and double click on zec-qt-wallet to start.

??? info "macOS instructions (click to expand)"

    [Download](https://github.com/ZcashFoundation/zec-qt-wallet/releases) the macOS release named `macOS-zec-qt-wallet-v0.5.9.dmg`
    and double-click on the .dmg file to open it, and drag zec-qt-wallet on to the Applications link to install. You will need to give authorisation for the program to run.

??? info "Linux instructions (click to expand)"

    If you are on Debian/Ubuntu, download the `.deb` package and install it.
    
    `sudo dpkg -i linux-deb-zec-qt-wallet-v0.5.9.deb`
    
    `sudo apt install -f`

    Or you can download and run the binaries directly.
    
    `tar -xvf zec-qt-wallet-v0.5.9.tar.gz`
    
    `./zec-qt-wallet-v0.5.9/zec-qt-wallet` 

## zcashd

zec-qt-wallet needs a [Zcash node](https://zcash.readthedocs.io/en/latest/rtd_pages/user_guide.html#installation) running `zcashd`. If you already have a `zcashd` node running, zec-qt-wallet will connect to it. 

If you don't have one running, zec-qt-wallet will start its embedded `zcashd` node. 

Additionally, if this is the first time you're running zec-qt-wallet or a `zcashd` daemon, zec-qt-wallet will download the Zcash params (~1.7 GB) and configure `zcash.conf` for you. 

!!! tip "Disable embedded `zcashd`"
    To force disabling the embedded `zcashd` and only connect to a remote node pass `--no-embedded` to the startup command.

### System requirements

If using the embedded `zcashd` the [recommended system requirements](https://zcash.readthedocs.io/en/latest/rtd_pages/user_guide.html#getting-started) are 5GB of free RAM and 25GB of free disk (the size of the blockchain increases over time).

## Compiling from source
zec-qt-wallet is written in C++ 14, and can be compiled with g++/clang++/visual c++. It also depends on Qt5, which you can get from [here](https://www.qt.io/download). Note that if you are compiling from source, you won't get the embedded `zcashd` by default. You can either run an external `zcashd`, or [compile `zcashd`](/setting-up-build-env/#compiling-zcashd-for-embedded-zcashd) as well. 

See the instructions for [setting up a build environment](/setting-up-build-env) and detailed build instructions for each platform [here](/compile-from-source).

## Upgrading

It is important to keep your version of zec-qt-wallet up to date as new features are regularly added and bugs fixed. To download follow the [instructions to install](/installation/#download-and-install) as your data directory and wallet will be untouched throughout. 

!!! warning "`zcashd` reaches end of service halt after 16 weeks"
    If you are using the embedded `zcashd` then after 16 weeks from release `zcashd` will reach an end of service halt and will shut down. Simply update your version of `zec-qt-wallet` to continue as it will contain updated releases of `zcashd`.

zec-qt-wallet also has an update notifier that will notify you if there's a new release of zec-qt-wallet available.