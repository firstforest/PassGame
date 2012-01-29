package  
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class Passer extends Agent
	{
		static public const DELAY_TIME:uint = 1000;
		
		private var sight:Number;
		private var timer:Timer;
		private var passable:Boolean = true;
		private var direction:Vector2D;
		
		public function Passer(x:Number, y:Number, gameMain:GameMain) 
		{
			super(x, y, gameMain);
			sight = 500;
			direction = Vector2D.ZERO;
			timer = new Timer(DELAY_TIME, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timeHandler);
			
		}
		
		private function timeHandler(e:TimerEvent):void 
		{
			timer.stop();
			passable = true;
			changeDirection();
		}
		
		private function changeDirection():void 
		{
			direction = new Vector2D(Math.random() * 2 - 1, Math.random() * 2 - 1);	
		}

		override public function update():void
		{
			if (haveBalls.length == 0) receive();
			move();
			if (haveBalls.length > 0 && passable) 
			{
				pass();
				passable = false;
				timer.start();
			}
			
			// ballの位置調整
			var pg:PasserGroup = gameMain.getPassers();
			var passers:Vector.<Passer> = pg.searchPasser(position, sight);
			var vec:Vector2D = gameMain.player.position.subtract(position);
			if (passers.length > 1)
			{
				for each (var p:Passer in passers)
				{
					if (p == this) continue;
					if (p.position.subtract(position).length < vec.length) 
					{
						vec = p.position.subtract(position);
					} 
				}
			}
			else
			{
				if(vec.length > sight)vec = new Vector2D(Math.random()*2-1,Math.random()*2-1);
			}
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

		// override
		override protected function pass():void
		{
			var pg:PasserGroup = gameMain.getPassers();
			var passers:Vector.<Passer> = pg.searchPasser(position, sight);
			var vec:Vector2D = gameMain.player.position.subtract(position);
			if (passers.length > 1)
			{
				for each (var p:Passer in passers)
				{
					if (p == this) continue;
					if (p.position.subtract(position).length < vec.length) 
					{
						vec = p.position.subtract(position);
					} 
				}
			}
			else
			{
				if(vec.length > sight)vec = new Vector2D(Math.random()*2-1,Math.random()*2-1);
			}
			var bg:BallGroup = gameMain.getBalls();
			
			while (haveBalls.length > 0)
			{
				var b:Ball = haveBalls.pop();
				vec.length = defPower;
				b.setPos(vec.x + x,vec.y + y);
				vec.length = atkPower;
				b.addForce(vec);
				bg.add(b);
			}
		}

		// override
		override protected function move():void
		{
			direction.length = movePower;
			x += direction.x;
			y += direction.y;
		}
	}

}