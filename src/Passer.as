package  
{
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class Passer extends Agent
	{
		
		public function Passer(x:Number, y:Number, gameMain:GameMain) 
		{
			super(x, y, gameMain);
		}

		// override
		override protected function receive():void
		{
			var bg:BallGroup = gameMain.getBalls();
			var balls:Vector.<Ball> = bg.getBall(position, defPower);
			haveBalls = haveBalls.concat(balls);
		}

		// override
		override protected function pass():void
		{
			var pg:PasserGroup = gameMain.getPassers();
			var passers:Vector.<Passer> = pg.searchPasser(position, sight);
			var vec:Vector2D;
			if (passers.length > 0)
			{
				vec = passers.pop().position.subtract(position);
			}
			else
			{
				vec = new Vector2D(Math.random()*2-1,Math.random()*2-1);
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
			if (balls.length > 0)
			{
				vec = balls.pop().position.subtract(position);
			}
			else
			{
				vec = new Vector2D(mouseX, mouseY);
			}
			vec.length = movePower;
			x += vec.x;
			y += vec.y;
		}
	}

}