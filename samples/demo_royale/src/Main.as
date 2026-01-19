package
{
    import flash.display.Stage;
    import flash.display.Sprite;

    public class Main
    {
        public function Main()
        {
                var stage:Stage = new Stage (320, 480, 0xFFFFFF, Demo_Royale);
                stage.frameRate = 60;
                var content:HTMLDivElement = document.getElementById ("openfl-content") as HTMLDivElement;
                content.appendChild (stage.element);
        }
    }
}