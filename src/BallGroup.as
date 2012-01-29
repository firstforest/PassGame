package  
{
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class BallGroup
	{
		private var balls:Vector.<Ball>;
	
		public function BallGroup()
		{
			balls = new Vector.<Ball>();
			super();
		}
		
		public function add(b:Ball):void
		{
			balls.push(b);
		}
		
		public function update():void
		{
			for each (var b:Ball in balls)
			{
				b.update();
			}
		}
		
		public function searchBall(pos:Vector2D, searchPower:Number):Vector.<Ball>
		{
			var res:Vector.<Ball> = new	Vector.<Ball>();
			for each (var b:Ball in balls)
			{
				if (pos.distance(b.position) < searchPower)
				{
					res.push(b);
				}
			}
			
			return res;
		}
		
		public function getBalls(pos:Vector2D, searchPower:Number):Vector.<Ball>
		{
			var res:Vector.<Ball> = new	Vector.<Ball>();
			var rest:Vector.<Ball> = new Vector.<Ball>();
			
			for each (var b:Ball in balls)
			{
				if (pos.distance(b.position) < searchPower)
				{
					res.push(b);
				}
				else
				{
					rest.push(b);	
				}
			}
			this.balls = rest;
			return res;
		}
		
		public function getBall(pos:Vector2D, searchPower:Number):Ball
		{
			var res:Vector.<Ball> = new	Vector.<Ball>();
			var rest:Vector.<Ball> = new Vector.<Ball>();
			
			for each (var b:Ball in balls)
			{
				if (pos.distance(b.position) < searchPower)
				{
					res.push(b);
				}
				else
				{
					rest.push(b);	
				}
			}
			if (res.length == 0) return null;
			var resBall:Ball = res.pop();
			this.balls = rest.concat(res);
			return resBall;
		}
		
		public function remove(ball:Ball):void 
		{
			balls.splice(balls.indexOf(ball), 1);
		}
		
	}

}