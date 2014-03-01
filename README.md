File dialogs for <a href="https://github.com/ianharrigan/haxeui">HaxeUI</a>
================================

<img src="https://raw.github.com/ianharrigan/haxeui-file-dialogs/master/docs/screen.jpg" />

Installation
-------------------------
First install haxeui & haxeui-file-dialogs via haxelib:

```
haxelib install haxeui
haxelib install haxeui-file-dialogs
```

Once installed add 
```
<haxelib name="haxeui" />
<haxelib name="haxeui-file-dialogs" />
```
to your openfl application.xml.

Usage
-------------------------
At present only two dialogs are included:
	
- File open dialog:
```haxe
FileDialogs.openFile({ dir: "C:/Temp", filter: "All Files:*.*;Text Files:*.txt;Images:*.png,*.jpg,*.bmp" }, function(f:FileDetails) {
	trace("Open file: " + f.filePath);
});
```

- File save dialog:
```haxe
var details:FileDetails = new FileDetails();
details.contents = "Some text";
FileDialogs.saveFileAs( { dir: "C:/Temp", filter: "All Files:*.*;Text Files:*.txt;Images:*.png,*.jpg,*.bmp" }, details, function(f:FileDetails) {
	trace("Saved file: " + f.filePath);
});
```
