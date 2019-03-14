# Installing zec-qt-wallet
---

## Download and Install

ZecWallet runs on Windows, macOS and Linux and is [available to download](https://github.com/ZcashFoundation/zec-qt-wallet/releases) from the releases page of the project [GitHub repository](https://github.com/ZcashFoundation/zec-qt-wallet/). Follow the instructions below for the platform of your choice to install zec-qt-wallet. To compile from source see [this section](compile-from-source).

??? info "Windows instructions (click to expand)"

    [Download](https://github.com/ZcashFoundation/zec-qt-wallet/releases) and run the .msi installer (named `Windows-installer-zec-qt-wallet-v0.6.1.msi`) and follow the prompts. Alternately, you can [download](https://github.com/ZcashFoundation/zec-qt-wallet/releases) the release binary (named `Windows-binaries-zec-qt-wallet-v0.6.1.zip`), unzip it and double click on ZecWalletto start.

??? info "macOS instructions (click to expand)"

    [Download](https://github.com/ZcashFoundation/zec-qt-wallet/releases) the macOS release named `macOS-zec-qt-wallet-v0.6.1.dmg`
    and double-click on the .dmg file to open it, and drag ZecWalleton to the Applications link to install. You will need to give authorisation for the program to run.

??? info "Linux instructions (click to expand)"

    If you are on Debian/Ubuntu, download the `.deb` package and install it.
    
    `sudo dpkg -i linux-deb-zec-qt-wallet-v0.6.1.deb`
    
    `sudo apt install -f`

    Or you can download and run the binaries directly.
    
    `tar -xvf zec-qt-wallet-v0.6.1.tar.gz`
    
    `./zec-qt-wallet-v0.6.1/zec-qt-wallet` 

## Verifying the download

Starting from v0.5.10 all [ZecWallet releases](https://github.com/ZcashFoundation/zec-qt-wallet/releases) are signed and contain checksums that may be validated to ensure the integrity of the downloaded software. The current signatures and checksums are available to download via the signatures-v0.6.1.tar.gz file on the [releases page](https://github.com/ZcashFoundation/zec-qt-wallet/releases).

### Signatures

#### Import public key

The public key is available to download from [the GitHub repository](https://raw.githubusercontent.com/ZcashFoundation/zec-qt-wallet/master/public_key.asc). Save the file and import via: 

`gpg --import public_key.asc`

!!! tip ""
	The public key fingerprint is C231 72D0 C956 9591 ECEC  8ECB 0E1E 9027 9521 EBB4

Alternatively, you can import from a keyserver using the following command:

`gpg --keyserver pool.sks-keyservers.net --recv-keys 0E1E90279521EBB4`

#### Verifying signatures

Once the key has been imported, you can run the following command to verify the signature:

`gpg --verify <filename.sig> <downloaded-filename-to-verify>`

Assuming a good signature, you will see a similar output to the below.

```
gpg --verify macOS-zec-qt-wallet-v0.6.1.dmg.sig macOS-zec-qt-wallet-v0.6.1.dmg
gpg: Signature made Wed 20 Feb 11:06:04 2019 PST
gpg:                using RSA key C23172D0C9569591ECEC8ECB0E1E90279521EBB4
gpg: Good signature from "adityapk00 (PGP Key for zec-qt-wallet) <zcash@adityapk.com>" [full]
```

### Checksums

The file `sha256sum-v0.6.1.txt` contains the SHA256 checksums for each download. You can verify that the file you downloaded matches this checksum via the following command:

```
sha256sum macOS-zec-qt-wallet-v0.6.1.dmg
c133bf79162891b379ce5aacb0a7194be85c7fa6749bda24708d673686f51de5  macOS-zec-qt-wallet-v0.6.1.dmg
```

## zcashd

ZecWallet needs a [Zcash node](https://zcash.readthedocs.io/en/latest/rtd_pages/user_guide.html#installation) running `zcashd`. If you already have a `zcashd` node running, ZecWalletwill connect to it. 

If you don't have one running, ZecWalletwill start its embedded `zcashd` node. 

Additionally, if this is the first time you're running ZecWalletor a `zcashd` daemon, ZecWalletwill download the Zcash params (~1.7 GB) and configure `zcash.conf` for you. 

!!! tip "Disable embedded `zcashd`"
    To force disabling the embedded `zcashd` and only connect to a remote node pass `--no-embedded` to the startup command.

### System requirements

If using the embedded `zcashd` the [recommended system requirements](https://zcash.readthedocs.io/en/latest/rtd_pages/user_guide.html#getting-started) are 5GB of free RAM and 25GB of free disk (the size of the blockchain increases over time).

## Compiling from source
ZecWallet is written in C++ 14, and can be compiled with g++/clang++/visual c++. It also depends on Qt5, which you can get from [here](https://www.qt.io/download). Note that if you are compiling from source, you won't get the embedded `zcashd` by default. You can either run an external `zcashd`, or [compile `zcashd`](/setting-up-build-env/#compiling-zcashd-for-embedded-zcashd) as well. 

See the instructions for [setting up a build environment](/setting-up-build-env) and detailed build instructions for each platform [here](/compile-from-source).

## Upgrading

It is important to keep your version of ZecWalletup to date as new features are regularly added and bugs fixed. To download follow the [instructions to install](/installation/#download-and-install) as your data directory and wallet will be untouched throughout. 

!!! warning "`zcashd` reaches end of service halt after 16 weeks"
    If you are using the embedded `zcashd` then after 16 weeks from release `zcashd` will reach an end of service halt and will shut down. Simply update your version of `zec-qt-wallet` to continue as it will contain updated releases of `zcashd`.

ZecWallet also has an update notifier that will notify you if there's a new release of ZecWalletavailable.
