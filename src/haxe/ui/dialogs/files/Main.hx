package haxe.ui.dialogs.files;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;

class Main {
	public static function main() {
		Macros.addStyleSheet("styles/gradient/gradient.css");
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			var hbox:HBox = new HBox();
			
			var button:Button = new Button();
			button.text = "Open";
			button.onClick = function(e) {
				FileDialogs.openFile({ dir: "C:/Temp" }, function(f:FileDetails) {
					trace("Open file: " + f.filePath);
				});
			}
			hbox.addChild(button);
			
			var button:Button = new Button();
			button.text = "Save";
			button.onClick = function(e) {
				var details:FileDetails = new FileDetails();
				details.contents = "Some text";
				FileDialogs.saveFileAs( { dir: "C:/Temp" }, details, function(f:FileDetails) {
					trace("Saved file: " + f.filePath);
				});
			}
			hbox.addChild(button);
			
			hbox.x = hbox.y = 100;
			root.addChild(hbox);
		});
	}
}
