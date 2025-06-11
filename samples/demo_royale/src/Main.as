package {
	import openfl.display.Stage;
	
	public class Main {	
		public function Main () {
			var stage:Stage = new Stage (0, 0, null, Demo, {allowHighDPI:true});
			document.body.appendChild(stage.element);	
        }
	}
}
