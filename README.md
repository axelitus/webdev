# WebDev - Web Development Environment (Scaffold)

A scaffold to setup a web development project's environment automatically.

To install just run this on your terminal:

```
git clone --depth 1 https://github.com/axelitus/webdev.git && rm -rf ./webdev/.git
```

Modify your command accordingly. This will download all necessary files and remove all git information to start clean.

After that you have to run this command inside your target folder (e.g. webdev) to set everything up:

```
./setup.sh <framework> <version>
```

*<frmaework>* and *<version>* are optiona variables to install a specific framework and version.