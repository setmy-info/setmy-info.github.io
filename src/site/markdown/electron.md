# Electron Framework

## Information

## Installation

```shell
npm init --yes
npm install --save-dev electron
# Or for Windows services
npm install --save-dev electron node-windows winston
```

Chck and add to **package.json**:

```json
{
    "main": "main",
    "scripts": {
        "start": "electron ."
    }
}
```

**main.js**

```sh
nano main.js
```

```js
const {app, BrowserWindow} = require('electron')
const path = require('node:path')

let tray = null;

const createWindow = () => {
    const mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        show: false,
        webPreferences: {
            nodeIntegration: true,
            //preload: path.join(__dirname, 'preload.js')
        }
    })

    mainWindow.loadFile('index.html')

    tray = new Tray(path.join(__dirname, 'tray-icon.png'));

    const contextMenu = Menu.buildFromTemplate([
        {
            label: 'Open window',
            click: () => {
                mainWindow.show();
            },
        },
        {
            label: 'Exit',
            click: () => {
                app.quit();
            },
        },
    ]);

    tray.setToolTip('Hello World!');
    tray.setContextMenu(contextMenu);

    tray.on('click', () => {
        mainWindow.isVisible() ? mainWindow.hide() : mainWindow.show();
    });
}

/*
app.whenReady().then(() => {
    createWindow()

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow()
    })
})
*/

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit()
})
```

**index.html**

```sh
nano index.html
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self'">
    <title>Hello World!</title>
</head>
<body>
<h1>Hello World!</h1>
We are using Node.js <span id="node-version"></span>,
Chromium <span id="chrome-version"></span>,
and Electron <span id="electron-version"></span>.
</body>
</html>
```

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
