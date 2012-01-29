package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class ControlPanel extends Sprite
	{
		private var backGround:Sprite;
		private var scoreFiled:TextField;
		private var gameMain:GameMain;
		
		public function ControlPanel(gameMain:GameMain) 
		{
			x = 600;
			y = 0;
			this.gameMain = gameMain;
			
			backGround = new Sprite();
			backGround.graphics.beginFill(0x333333);
			backGround.graphics.drawRect(0, 0, 200, 600);
			backGround.graphics.endFill();
			addChild(backGround);
			
			scoreFiled = new TextField();
			scoreFiled.background = true;
			scoreFiled.text = "score: 0";
			scoreFiled.x = 10;
			scoreFiled.y = 20;
			scoreFiled.width = 100;
			scoreFiled.height = 20;
			addChild(scoreFiled);
			
		}
		
		public function update():void
		{
			scoreFiled.text = "score: " + gameMain.getScore();
		}
		
	}

}