package haxe.ui.dialogs.files;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.selection.ListSelector;
import haxe.ui.toolkit.controls.TextInput;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.UIEvent;

class FileSelectionController extends XMLController {
	private var _currentDir:String;
	private var _readContents:Bool = false;
	private var _filter:String = "All Files:*.*";
	
	private var contents:ListView;
	private var path:HBox;
	private var filename:TextInput;
	private var filter:ListSelector;

	public function new(options:Dynamic = null) {
		super("assets/ui/dialogs/files/file-selection.xml");
		
		if (options != null) {
			if (options.dir != null) {
				_currentDir = options.dir;
			}
			if (options.readContents != null) {
				_readContents = options.readContents;
			}
			if (options.filter != null) {
				_filter = options.filter;
			}
		}
		
		path = getComponentAs("path", HBox);
		contents = getComponentAs("contents", ListView);
		filename = getComponentAs("filename", TextInput);
		filter = getComponentAs("filter", ListSelector);
		
		contents.addEventListener(UIEvent.CHANGE, _onListChange);
		contents.addEventListener(UIEvent.DOUBLE_CLICK, _onListDblClick);
		filter.addEventListener(UIEvent.CHANGE, _onFilterChange);

		populateFilter(_filter);
		loadDirContents(_currentDir);
	}
	
	private function loadDirContents(path:String = null):Void {
		var pattern:String = getFilterPattern();
		
		contents.dataSource.removeAll();
		if (path == null || path.length == 0) {
			path = FileSystemHelper.getCwd();
		}
		
		path = FileSystemHelper.normalizePath(path);
		_currentDir = path;
		var items:Array<String> = FileSystemHelper.readDirectory(path);
		for (item in items) {
			if (FileSystemHelper.isDirectory(path + "/" + item) == true) {
				contents.dataSource.add( { text: item, icon: "assets/ui/dialogs/files/types/folder-horizontal.png" } );
			}
		}
		
		for (item in items) {
			if (FileSystemHelper.isDirectory(path + "/" + item) == false) {
				if (pattern != "*") {
					var ext:String = FileType.getExtension(item);
					if (pattern.indexOf(ext) == -1) {
						continue;
					}
				}
				contents.dataSource.add( { text: item, icon: getFileIcon(item) } );
			}
		}
		
		filename.text = "";
		refreshPathControls(_currentDir);
	}
	
	private function getFilterPattern():String {
		var pattern = "*.*";
		var text:String = filter.text;
		filter.dataSource.moveFirst();
		do {
			if (filter.dataSource.get().text == text) {
				pattern = filter.dataSource.get().pattern;
			}
		} while (filter.dataSource.moveNext());
		return pattern;
	}
	
	private function populateFilter(filterString:String):Void {
		filter.dataSource.removeAll();
		var items:Array<String> = filterString.split(";");
		for (item in items) {
			var keys:Array<String> = item.split(":");
			filter.dataSource.add( { text: keys[0], pattern: StringTools.replace(keys[1], "*.", "") } );
		}
	}
	
	private function refreshPathControls(pathString:String):Void {
		path.removeAllChildren();
		var arr:Array<String> = pathString.split("/");
		for (a in arr) {
			var button:Button = new Button();
			button.text = a;
			button.addEventListener(UIEvent.CLICK, _onPathControlClick);
			path.addChild(button);
		}
	}
	
	private function _onPathControlClick(event:UIEvent):Void {
		var newPath:String = "";
		for (child in path.children) {
			newPath += cast(child, Button).text + "/";
			if (child == event.component) {
				break;
			}
		}
		loadDirContents(newPath);
	}
	
	private function _onListChange(event:UIEvent):Void {
		var dir:String = _currentDir;
		if (StringTools.endsWith(dir, "/") == false && StringTools.endsWith(dir, "\\") == false) {
			dir += "/";
		}
		var newDir:String = FileSystemHelper.normalizePath(dir + contents.selectedItems[0].data.text);
		if (FileSystemHelper.isDirectory(newDir) == false) {
			filename.text =  contents.selectedItems[0].data.text;
		}
	}
	
	private function _onListDblClick(event:UIEvent):Void {
		var dir:String = _currentDir;
		if (StringTools.endsWith(dir, "/") == false && StringTools.endsWith(dir, "\\") == false) {
			dir += "/";
		}

		var newDir:String = FileSystemHelper.normalizePath(dir + contents.selectedItems[0].data.text);
		if (FileSystemHelper.isDirectory(newDir) == true) {
			loadDirContents(newDir);
		} else {
			this.popup.clickButton(PopupButton.CONFIRM);
		}
	}
	
	private function _onFilterChange(event:UIEvent):Void {
		loadDirContents(_currentDir);
	}
	
	private function getFileIcon(fileName:String):String {
		return FileType.getIcon(fileName);
	}
	
	public var selectedFile(get, null):FileDetails;
	private function get_selectedFile():FileDetails {
		var details:FileDetails = null;
		var filePath:String = FileSystemHelper.normalizePath(_currentDir + "/" + filename.text);
		if (filePath != null) {
			details = FileSystemHelper.getFileDetails(filePath, _readContents);
		}
		return details;
	}
	
	public var currentDir(get, set):String;
	private function get_currentDir():String {
		return _currentDir;
	}
	private function set_currentDir(value:String):String {
		if (view.ready) {
			loadDirContents(value);
		}
		return value;
	}
}