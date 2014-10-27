package haxe.ui.dialogs.files;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.themes.GradientTheme;

class Main {
	public static function main() {
		//Macros.addStyleSheet("styles/gradient/gradient.css");
		Toolkit.theme = new GradientTheme();
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			var hbox:HBox = new HBox();
			
			var button:Button = new Button();
			button.text = "Open";
			button.onClick = function(e) {
				FileDialogs.openFile({ dir: "C:/Temp/_files", filter: "All Files:*.*;Text Files:*.txt;Images:*.png,*.jpg,*.bmp" }, function(f:FileDetails) {
					trace("Open file: " + f);
				});
			}
			hbox.addChild(button);
			
			var button:Button = new Button();
			button.text = "Save";
			button.onClick = function(e) {
				var details:FileDetails = new FileDetails();
				details.contents = "Some text";
				FileDialogs.saveFileAs( { dir: "C:/Temp/_files", filter: "All Files:*.*;Text Files:*.txt;Images:*.png,*.jpg,*.bmp" }, details, function(f:FileDetails) {
					trace("Saved file: " + f);
				});
			}
			hbox.addChild(button);
			
			hbox.x = hbox.y = 100;
			root.addChild(hbox);
		});
	}
}
