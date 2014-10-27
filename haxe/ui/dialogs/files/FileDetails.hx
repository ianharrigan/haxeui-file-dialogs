package haxe.ui.dialogs.files;
import openfl.events.IOErrorEvent;

class FileDetails {
	public function new() {
		
	}
	
	public var name(default, default):String;
	public var contents(default, default):String;
	public var type(default, default):String;
	public var size(default, default):Float;
	public var filePath(default, default):String;
	public var userData(default, default):Dynamic;
	#if flash
	/** Contains the error occured during file load/save */
	public var error(default, default):IOErrorEvent; 
	#end
}