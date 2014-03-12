package haxe.ui.dialogs.files;

import haxe.ui.toolkit.controls.popups.Popup;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.core.RootManager;

class HaxeUIFileOpener {
	private var _fn:FileDetails->Void;
	
	public function new(options:Dynamic, fn:FileDetails->Void) {
		_fn = fn;

		if (options == null) {
			options = { };
		}
		options.title = (options.title != null) ? options.title : "Open File";
		options.styleName = (options.styleName != null) ? options.styleName : "file-selection-popup";
		options.width = (options.width != null) ? options.width : 600;
		
		var controller:FileSelectionController = new FileSelectionController(options);
		var config:Dynamic = { };
		config.buttons = [PopupButton.CONFIRM, PopupButton.CANCEL];
		config.styleName = options.styleName;
		config.width = options.width;
		var popup:Popup = PopupManager.instance.showCustom(controller.view, options.title, config, function (e) {
			if (e == PopupButton.CONFIRM) {
				var details = controller.selectedFile;
				if (_fn != null) {
					_fn(details);
				}
			}
		});
	}
}