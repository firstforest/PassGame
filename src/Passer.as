package  
{
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class Passer extends Agent
	{
		
		private var sight:Number;
		
		public function Passer(x:Number, y:Number, gameMain:GameMain) 
		{
			super(x, y, gameMain);
			sight = 500;
		}

		// override
		override protected function receive():void
		{
			var bg:BallGroup = gameMain.getBalls();
			var balls:Vector.<Ball> = bg.getBall(position, defPower);
			for each (var tb:Ball in balls)
			{
				tb.addColor(red/5, green/5, blue/5);
			}
			haveBalls = haveBalls.concat(balls);
		}

		// override
		override protected function pass():void
		{
			var pg:PasserGroup = gameMain.getPassers();
			var passers:Vector.<Passer> = pg.searchPasser(position, sight);
			var vec:Vector2D;
			if (passers.length > 1)
			{
				vec = new Vector2D(1, 1);
				vec.length = sight;
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
				vec = new Vector2D(10,50);
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
			var bg:BallGroup = gameMain.getBalls();
			var balls:Vector.<Ball> = bg.searchBall(position, sight);
			var vec:Vector2D;
			if (balls.length < 0)
			{
				vec = balls.pop().position.subtract(position);
			}
			else
			{
				vec = new Vector2D(Math.random()*2-1, Math.random()*2-1);
			}
			vec.length = movePower;
			x += vec.x;
			y += vec.y;
		}
	}

}