package
{
    import flash.net.URLRequest;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import flash.system.System;
    import flash.utils.setTimeout;

    import starling.assets.AssetManager;
    import starling.core.Starling;
    import starling.events.Event;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.StringUtil;
    import starling.utils.SystemUtil;

    import utils.ProgressBar;

    [SWF(width="320", height="480", frameRate="30", backgroundColor="#000000")]
    public class Demo extends Sprite
    {
        private const StageWidth:int  = 320;
        private const StageHeight:int = 480;

        private var _starling:Starling;
        private var _background:Loader;
        private var _progressBar:ProgressBar;

        public function Demo()
        {
            // This demo still uses a fixed coordinate sytem of 320x480, just like the original
            // iPhone and iPhone 4/4S. The contents is then centered on the screen. Nowadays,
            // you'd use a different approach, of course. See the "Scaffold" project for a sample.

            var iOS:Boolean = SystemUtil.platform == "IOS";
            var stageSize:Rectangle  = new Rectangle(0, 0, StageWidth, StageHeight);
            var screenSize:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
            var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL, iOS);
            var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640

            Starling.multitouchEnabled = true; // useful on mobile devices

            _starling = new Starling(Game, stage, viewPort);
            _starling.stage.stageWidth    = StageWidth;  // <- same size on all devices!
            _starling.stage.stageHeight   = StageHeight; // <- same size on all devices!
            _starling.enableErrorChecking = Capabilities.isDebugger;
            _starling.skipUnchangedFrames = true;
            _starling.simulateMultitouch  = true;
            _starling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
            {
                loadAssets(scaleFactor, startGame);
            });

            _starling.start();
            initElements(scaleFactor);
        }

        private function loadAssets(scaleFactor:int, onComplete:Function):void
        {
            // Our assets are loaded and managed by the 'AssetManager'. To use that class,
            // we first have to enqueue pointers to all assets we want it to load.

            var assets:AssetManager = new AssetManager(scaleFactor);

            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(
                    new URLRequest("assets/audio"),
                    new URLRequest(StringUtil.format("assets/fonts/{0}x",    scaleFactor)),
                    new URLRequest(StringUtil.format("assets/textures/{0}x", scaleFactor))
            );

            // Now, while the AssetManager now contains pointers to all the assets, it actually
            // has not loaded them yet. This happens in the "loadQueue" method; and since this
            // will take a while, we'll update the progress bar accordingly.

            assets.loadQueue(onLoadComplete, onLoadError, onLoadProgress);

            function onLoadComplete():void
            {
                // now would be a good time for a clean-up
                System.gc();

                onComplete(assets);
            }

            function onLoadError(error:String):void
            {
                trace("Error while loading assets: " + error);
            }

            function onLoadProgress(ratio:Number):void
            {
                _progressBar.ratio = ratio;
            }
        }

        private function startGame(assets:AssetManager):void
        {
            var game:Game = _starling.root as Game;
            game.start(assets);
            setTimeout(removeElements, 150); // delay to make 100% sure there's no flickering.
        }

        private function initElements(scaleFactor:int):void
        {
            // Add background image. By using "loadBytes", we can avoid any flickering.

            var bgPath:String = StringUtil.format("assets/textures/{0}x/background.jpg", scaleFactor);

            _background = new Loader();
            _background.load(new URLRequest(bgPath));
            _background.scaleX = 1.0 / scaleFactor;
            _background.scaleY = 1.0 / scaleFactor;
            _starling.nativeOverlay.addChild(_background);

            _background.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,
                function(e:Object):void
                {
                    (_background.content as Bitmap).smoothing = true;
                });

            // While the assets are loaded, we will display a progress bar.

            _progressBar = new ProgressBar(175, 20);
            _progressBar.x = (StageWidth - _progressBar.width) / 2;
            _progressBar.y =  StageHeight * 0.7;
            _starling.nativeOverlay.addChild(_progressBar);
        }

        private function removeElements():void
        {
            if (_background)
            {
                _starling.nativeOverlay.removeChild(_background);
                _background = null;
            }

            if (_progressBar)
            {
                _starling.nativeOverlay.removeChild(_progressBar);
                _progressBar = null;
            }
        }
    }
}