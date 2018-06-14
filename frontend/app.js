var url = require("url");
const path = require("path");
const { app, BrowserWindow } = require("electron");

let win = null;

app.on("ready", function() {
  // Initialize the window to our specified dimensions
  win = new BrowserWindow({ width: 1200, width: 600, minWidth: 992, minHeight: 600 });

  // Specify entry point to default entry point of vue.js
  win.loadURL(
    url.format({
      pathname: path.join(__dirname, "dist/index.html"),
      protocol: "file:",
      slashes: true
    })
  );

  // Remove window once app is closed
  win.on("closed", function() {
    win = null;
  });
});
//create the application window if the window variable is null
app.on("activate", () => {
  if (win === null) {
    createWindow();
  }
});
//quit the app once closed
app.on("window-all-closed", function() {
  if (process.platform != "darwin") {
    app.quit();
  }
});
