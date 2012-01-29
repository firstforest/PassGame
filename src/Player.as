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
			movePower = 8;
			atkPower = 30;
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
		
		override public function update():void
		{
			if (haveBalls.length == 0) receive();
			move();
			var vec:Vector2D = new Vector2D(mouseX, mouseY);
			vec.length = defPower;
			for each (var b:Ball in haveBalls)
			{
				b.setPos(x+vec.x, y+vec.y);			
			}
						
		}
	
		// override
		override protected function receive():void
		{
			var bg:BallGroup = gameMain.getBalls();
			var tb:Ball = bg.getBall(position, defPower);
			if (tb != null) 
			{
				tb.addColor(red/5, green/5, blue/5);
				haveBalls.push(tb);				
			}
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
		
		override protected function pass():void
		{
			var vec:Vector2D = new Vector2D(mouseX, mouseY);
			vec.length = atkPower;
			var bg:BallGroup = gameMain.getBalls();
			while (haveBalls.length > 0)
			{
				var b:Ball = haveBalls.pop();
				b.addForce(vec);
				bg.add(b);
				
			}
		}
	}

}