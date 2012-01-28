package  
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class Player extends Agent
	{
		
		private var keys:Array;
		
		public function Player(x:Number, y:Number, gameMain:GameMain) 
		{
			super(x, y, gameMain);
			keys = [];

			this.addEventListener(Event.ADDED_TO_STAGE, adddedStage);
		}
		
		private function adddedStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			pass();
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true;
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
		
		
		override protected function move():void
		{
			if (keys[Keyboard.LEFT] || keys[65])
			{
				x -= movePower;
			}
			if (keys[Keyboard.RIGHT] || keys[68])
			{
				x += movePower;
			}
			if (keys[Keyboard.UP] || keys[87])
			{
				y -= movePower;
			}
			if (keys[Keyboard.DOWN] || keys[83])
			{
				y += movePower;
			}
		}
	}

}