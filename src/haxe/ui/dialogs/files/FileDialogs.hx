package haxe.ui.dialogs.files;

class FileDialogs {
	public static function openFile(options:Dynamic, fn:FileDetails->Void):Void {
		#if flash
			#if air
				new HaxeUIFileOpener(options, fn);
			#else
				new FlashFileOpener(fn);
			#end
		#else
			new HaxeUIFileOpener(options, fn);
		#end
	}
	
	public static function saveFileAs(options:Dynamic, details:FileDetails, fn:FileDetails->Void):Void {
		#if flash
			#if air
				new HaxeUIFileSaver(options, details, fn);
			#else
				new FlashFileSaver(details, fn);
			#end
		#else
			new HaxeUIFileSaver(options, details, fn);
		#end
	}
}