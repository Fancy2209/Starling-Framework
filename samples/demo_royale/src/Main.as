package
{
    import flash.display.Stage;
    import flash.display.Sprite;
    import starling.events.EventDispatcher;
    EventDispatcher;
    public class Main
    {
        public function Main()
        {
            COMPILE::JS {
                var stage:Stage = new Stage (320, 480, 0xFFFFFF, Demo_Royale);
                stage.frameRate = 60;
                document.body.appendChild (stage.element);
            }
        }
    }
}