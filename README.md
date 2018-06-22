# BDMER3Tools

BDMER3Tools is an application which convert data from holothurias fishers forms done with open data kit as part of project seacusey. These data will be convert then sent to bdmer3 application used for the holothurias fisheries management.

#### Build Setup

## Install dependencies

``` bash
npm install
```

## Serve with hot reload at localhost:9080

``` bash
npm run dev
```

## Build electron application for linux

``` bash
npm run build
```

## Build electron application for windows on ubuntu

### You need [whineHQ](https://wiki.winehq.org/Ubuntu)

``` bash
sudo dpkg --add-architecture i386 
wget -nc https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
sudo apt-get update
```

### Then you can build your app

``` bash
npm run pack-win
```

## Execute application
```
If you have problem to execute the application, check that you are alow to execute it. 
Right click on .appImage file --> Properties --> Permissions --> Check "Allow executing file as program"
```

---

This project was generated with [electron-vue](https://github.com/SimulatedGREG/electron-vue)@[4c6ee7b](https://github.com/SimulatedGREG/electron-vue/tree/4c6ee7bf4f9b4aa647a22ec1c1ca29c2e59c3645) using [vue-cli](https://github.com/vuejs/vue-cli). Documentation about the original structure can be found [here](https://simulatedgreg.gitbooks.io/electron-vue/content/index.html).
