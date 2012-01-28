package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class GameMain extends Sprite
	{
		private var bGroup:BallGroup;
		private var pGroup:PasserGroup;
		private var keys:Array;
		private var player:Player;
		
		public function GameMain()
		{
			bGroup = new BallGroup();
			pGroup = new PasserGroup();
			keys = [];
			var b:Ball = new Ball(10, 29);
			addChild(b);
			player = new Player(30, 15, this);
			addChild(player);

			addEventListener(Event.ENTER_FRAME, loop);
			addEventListener(Event.ADDED_TO_STAGE, addedStage);
			super();
		}
		
		private function addedStage(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true;
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
		
		private function loop(e:Event):void
		{
			pGroup.update();
			bGroup.update();
			player.update();
			
			if (keys[70]) //F
			{
				var b:Ball = new Ball(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
				addChild(b);
				bGroup.add(b);
			}
			
			if (keys[71]) //G
			{
				var p:Passer = new Passer(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight, this);
				addChild(p);
				pGroup.add(p);
			}
		
		}
		
		public function getBalls():BallGroup
		{
			return bGroup;
		}
		
		public function getPassers():PasserGroup
		{
			return pGroup;
		}
	
	}

}