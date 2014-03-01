package haxe.ui.dialogs.files;

import haxe.ui.toolkit.controls.popups.Popup;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.core.PopupManager.PopupConfig;
import haxe.ui.toolkit.core.RootManager;

class HaxeUIFileSaver {
	private var _fn:FileDetails->Void;
	
	public function new(options:Dynamic, details:FileDetails, fn:FileDetails->Void) {
		_fn = fn;

		if (options == null) {
			options = { };
		}
		options.title = (options.title != null) ? options.title : "Save File";
		options.styleName = (options.styleName != null) ? options.styleName : "file-selection-popup";
		
		var controller:FileSelectionController = new FileSelectionController(options);
		var config:PopupConfig = new PopupConfig();
		config.addButton(PopupButtonType.CONFIRM);
		config.addButton(PopupButtonType.CANCEL);
		config.styleName = options.styleName;

		var popup:Popup = PopupManager.instance.showCustom(RootManager.instance.roots[0], controller.view, options.title, config, function (e) {
			if (e == PopupButtonType.CONFIRM) {
				var selectedDetails = controller.selectedFile;
				if (FileSystemHelper.exists(selectedDetails.filePath)) {
					PopupManager.instance.showSimple(RootManager.instance.roots[0], "File exists, overwrite?", "Overwrite File", PopupButtonType.YES | PopupButtonType.NO, function(e) {
						if (e == PopupButtonType.YES) {
							FileSystemHelper.writeFile(selectedDetails.filePath, details.contents);
							details.name = selectedDetails.name;
							details.filePath = selectedDetails.filePath;
							if (_fn != null) {
								_fn(details);
							}
						}
					});
				} else {
					FileSystemHelper.writeFile(selectedDetails.filePath, details.contents);
					details.name = selectedDetails.name;
					details.filePath = selectedDetails.filePath;
					if (_fn != null) {
						_fn(details);
					}
				}
			}
		});
	}
}