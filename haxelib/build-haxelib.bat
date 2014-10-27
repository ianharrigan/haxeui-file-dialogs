copy ..\haxelib.json .\
copy ..\include.xml .\
del haxeui-file-dialogs.zip
7za a haxeui-file-dialogs.zip haxelib.json include.xml ../assets/ ../haxe