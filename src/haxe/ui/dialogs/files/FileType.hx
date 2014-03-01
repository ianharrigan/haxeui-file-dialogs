package haxe.ui.dialogs.files;

class FileType {
	private static var _icons:Map<String, String> = [
		".exe" => "assets/ui/dialogs/files/types/application-blue.png",
		".png" => "assets/ui/dialogs/files/types/image.png",
		".jpg" => "assets/ui/dialogs/files/types/image.png",
		".jpeg" => "assets/ui/dialogs/files/types/image.png",
		".bmp" => "assets/ui/dialogs/files/types/image.png",
		".ico" => "assets/ui/dialogs/files/types/document-image.png",
		".css" => "assets/ui/dialogs/files/types/document-block.png",
		".txt" => "assets/ui/dialogs/files/types/document-text.png",
		".pdf" => "assets/ui/dialogs/files/types/document-pdf.png",
		".xls" => "assets/ui/dialogs/files/types/document-excel.png",
		".html" => "assets/ui/dialogs/files/types/document-code.png",
		".htm" => "assets/ui/dialogs/files/types/document-code.png",
		".xml" => "assets/ui/dialogs/files/types/document-code.png",
	];
	
	public function new() {
	}
	
	public static function getIcon(fileName:String):String {
		var s:String = "assets/ui/dialogs/files/types/document.png";
		var ext:String = getExtension(fileName);
		if (ext != null) {
			var t:String = _icons.get(ext);
			if (t != null) {
				s = t;
			}
		}
		return s;
	}
	
	public static function getExtension(fileName:String):String {
		var ext:String = null;
		var n:Int = fileName.lastIndexOf(".");
		if (n != -1) {
			ext = fileName.substring(n, fileName.length);
		}
		return ext;
	}
}