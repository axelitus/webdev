# WebDev - Web Development Environment (Scaffold)

A scaffold to setup a web development project's environment automatically.

To install just run this on your terminal:

```
git clone --depth 1 https://github.com/axelitus/webdev.git && rm -rf ./webdev/.git
```

This will download all necessary files to the folder *webdev* and remove all git information to start clean.

After that, run this command inside your target folder (e.g. webdev) to set everything up:

```
./setup.sh <framework> <version>
```

`<framework>` and `<version>` are optional arguments to install a specific framework and version.