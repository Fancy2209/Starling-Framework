package
{
    COMPILE::JS
    {
        import flash.display.Stage;
        import flash.utils.Assets;
        import flash.utils.AssetManifest;
        import flash.utils.AssetLibrary;

        public class Main
        {
            public function Main()
            {
                var manifest:AssetManifest = new AssetManifest();
                manifest.addFont("Ubuntu");
                manifest.addBitmapData("assets/textures/1x/background.jpg");

                AssetLibrary.loadFromManifest(manifest)
                    .onComplete(function(library:AssetLibrary):void  {
                            Assets.registerLibrary("default", library);
                            var stage:Stage = new Stage(320, 480, 0x222222, Demo_Royale);
                            document.body.appendChild(stage.element);
                        }).onError(function(e:Error):void {
                            trace(e);
                        });
            }
        }
    }

    COMPILE::SWF
    {
        import flash.display.Sprite;

        [SWF(width="320", height="480", frameRate="60", backgroundColor="#222222")]
        public class Main extends Sprite
        {
            public function Main()
            {
                this.addChild(new Demo_Royale());
            }
        }
    }
}
