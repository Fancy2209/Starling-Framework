package
{
    COMPILE::JS {
        import flash.display.Stage;

        public class Main
        {
            public function Main()
            {
                var stage:Stage = new Stage (320, 480, 0x222222, Demo_Royale);
                stage.frameRate = 60;
                var content:HTMLDivElement = document.getElementById ("openfl-content") as HTMLDivElement;
                content.appendChild (stage.element);
            }
        }
    }

    COMPILE::SWF {
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