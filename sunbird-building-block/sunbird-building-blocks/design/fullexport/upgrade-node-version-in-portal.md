# Upgrade-Node-version-in-portal

Preferred node version -

```
"node": "12.16.1",
"npm": "6.13.4"
```

Clear your node cache -

```
npm cache clean --force 
```

Delete node\_modules from client and app folder and have fresh npm i -

```
rm -rf node_modules/  // for client and app folders followed by 
npm install 
```

If you are upgrading from some previous version of node try to rebuild which will recompile all your C++ addons with the new binary -

```
npm rebuild 
```

If you still face issues make your system compatible with new c++ libraries hence have build-essentials in ur system (GCC/g++ compilers and libraries and some other utilities). To use C/C++ compiler, you just need to install build-essential package on your machine.

```
sudo apt-get install build-essential 
sudo apt-get install libssl-dev
```

If you face issues with node-gyp delete the previously version and install again -

```
rm -rf ~/.node-gyp
npm install
npm i -g node-gyp
node-gyp build
```

If you face issue with node-sass rebuild it with forcefully or you may chose to reinstall it -

```
npm rebuild node-sass --force
```

If you face issues with bindings delete the current version and install the latest version (hope you never use this).

```
npm install bindings
```

How to setup/upgrade node ?

[https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04)

[https://nodesource.com/blog/installing-node-js-tutorial-using-nvm-on-mac-os-x-and-ubuntu/](https://nodesource.com/blog/installing-node-js-tutorial-using-nvm-on-mac-os-x-and-ubuntu/)References -

Error - ReferenceError: primordials is not defined

[https://timonweb.com/posts/how-to-fix-referenceerror-primordials-is-not-defined-error/](https://timonweb.com/posts/how-to-fix-referenceerror-primordials-is-not-defined-error/)

Error - "Make Failed with Exit Code 2”

[https://codeforgeek.com/make-failed-with-exit-code-2/](https://codeforgeek.com/make-failed-with-exit-code-2/)

**Note**  - if you face any other issue apart from I shared below please document it

***

\[\[category.storage-team]] \[\[category.confluence]]
