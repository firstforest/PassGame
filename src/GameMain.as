package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class GameMain extends Sprite
	{
		private var bGroup:BallGroup;
		private var pGroup:PasserGroup;
		private var keys:Array;
		private var _player:Player;
		
		private var conPane:ControlPanel;
		private var score:Number;
		
		
		public function GameMain()
		{
			bGroup = new BallGroup();
			pGroup = new PasserGroup();
			keys = [];
			
			conPane = new ControlPanel(this);
			addChild(conPane);

			_player = new Player(30, 15, this);
			addChild(_player);
			
			score = 0;

			addEventListener(Event.ENTER_FRAME, loop);
			addEventListener(Event.ADDED_TO_STAGE, addedStage);
			super();
		}
		
		private function addedStage(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			if (keys[71]) //G
			{
				var p:Passer = new Passer(mouseX, mouseY, this);
				addChild(p);
				pGroup.add(p);
			}	
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
			conPane.update();
			
			if (keys[70]) //F
			{
				var b:Ball = new Ball(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight, 0x0, this);
				addChild(b);
				bGroup.add(b);
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
		
		public function getScore():Number
		{
			return score;
		}
		
		public function addScore(score:Number):void
		{
			this.score += score;
		}
		
		public function get player():Player 
		{
			return _player;
		}
	
	}

}