package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class Ball extends Sprite
	{
		private var gra:Sprite;
		private var color:uint;
		private var size:Number;
		private var velocity:Vector2D;
		private var colorTransform:ColorTransform;
		
		public function Ball(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
			size = Math.random()*10;
			velocity = Vector2D.ZERO;
			color = 0x00ff00;
			gra = new Sprite();
			gra.graphics.beginFill(color);
			gra.graphics.drawCircle(0,0,size);
			gra.graphics.endFill();
			colorTransform = new ColorTransform();
			
			addChild(gra);
			super();
		}
		
		public function update():void
		{
			move();
	//		bounce();
			if (0) 
			{
				if (velocity.length > 1)
				{
					size += velocity.length*0.1;			
				}
				else if (size >= 5)
				{
					size -= 1;
				}
			}
			
			addColor(100,0,0);
			
			gra.graphics.clear();
			gra.graphics.beginfill(color);
			gra.graphics.drawcircle(0,0,size);
			gra.graphics.endfill();
			velocity.multiply(0.95);
		}
		
		private function move():void
		{
			this.x += velocity.x;
			this.y += velocity.y;
		}
		
		public function setPos(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			velocity = Vector2D.ZERO;
		}	

		
		public function addForce(force:Vector2D):void
		{
			velocity.add(force);
		}
		
		public function get position():Vector2D
		{
			return new Vector2D(x, y);
		}
		
		public function addColor(r:Number, g:Number, b:Number):void
		{
			colorTransform.redOffset = r;
			colorTransform.greenOffset = g;
			colorTransform.blueOffset = b;
			
			gra.graphics.colorTransform = colorTransform;
		}
		
		private function bounce():void
		{
			if (x < 0)
			{
				
			}
			
		}

	}

}