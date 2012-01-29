package  
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.media.Sound;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class Ball extends Sprite
	{
		private var gameMain:GameMain;
		private var gra:Sprite;
		private var border:Sprite;
		private var color:uint;
		private var size:Number;
		private var velocity:Vector2D;
		
		private var r:Number;
		private var g:Number;
		private var b:Number;
		
		private static const DEATH_SPEED:Number = 0.95;
		private static const DEATH_LIMIT:Number = 0.05;
		
		// sound
		[Embed(source = "./sen_ka_katana_kosure01.mp3", mimeType = "audio/mpeg")]
		private var rmSound:Class;
		private var removeSound:Sound;
		
		public function Ball(x:Number, y:Number, color:uint, gameMain:GameMain)
		{
			this.x = x;
			this.y = y;
			this.gameMain = gameMain;
			size = 10;
			velocity = new Vector2D(Math.random() * 20,	Math.random() * 20);
			
			removeSound = new rmSound();
			
			r = color >> 16 & 0xFF;
			g = color >> 8 & 0xFF;
			b = color & 0xFF;
			
			color = r << 16 | g << 8 | b;
			gra = new Sprite();
			gra.graphics.beginFill(color);
			gra.graphics.drawCircle(0, 0, size);
			gra.graphics.endFill();
			addChild(gra);
			border = new Sprite();
			border.graphics.lineStyle(1, 0x0);
			border.graphics.drawCircle(0, 0, size);
			addChild(border);
			
			super();
		}
		
		public function update():void
		{
			move();
			if (this.r == 255 && this.g == 255 && this.b == 255)
			{
				if (this.x < 0 || stage.stageWidth <= this.x || this.y < 0 || stage.stageHeight <= this.y) 
				{
					collapse();
				}
			}
			else 
			{
				bounce();
			}

			velocity.multiply(DEATH_SPEED);
			if (velocity.length < DEATH_LIMIT)
			{
				gameMain.addScore(10);
				gameMain.getBalls().remove(this);
				gameMain.removeChild(this);
			}
			
		}
		
		public function collapse():void 
		{
			for (var i:int = 0; i < 7; i++) 
			{
				var c:uint = Math.random() * 0xFFFFFF;
				var ball:Ball = new Ball(x, y, c, gameMain);
				var vec:Vector2D = new Vector2D(Math.random() * 2 - 1, Math.random() * 2 -1);
				vec.length = 10;
				ball.addForce(vec);
				gameMain.getBalls().add(ball);
				gameMain.addChild(ball);
			}
			removeSound.play();
			var p:Passer = new Passer(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight, gameMain);
			gameMain.getPassers().add(p);
			gameMain.addChild(p);
			gameMain.getBalls().remove(this);
			gameMain.removeChild(this);
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
			this.r += r;
			if (this.r > 255) this.r = 255; 
			this.g += g;
			if (this.g > 255) this.g = 255; 
			this.b += b;
			if (this.b > 255) this.b = 255;
			
			if (this.r == 255 && this.g == 255 && this.b == 255) 
			{
				size = 13;
				border.graphics.clear();
				border.graphics.lineStyle(1, 0x0);
				border.graphics.drawCircle(0, 0, size);
			}

			color = this.r << 16 | this.g << 8 | this.b;
			gra.graphics.clear();
			gra.graphics.beginFill(color);
			gra.graphics.drawCircle(0,0,size);
			gra.graphics.endFill();			
			
		}
		
		public function getColor():uint
		{
			return color;
		}
		
		private function bounce():void
		{
			if (this.x < 0)
			{
				velocity.x = -velocity.x;
				this.x = 0;
			}
			else if (gameMain.fieldX <= this.x)
			{
				velocity.x = -velocity.x;
				this.x = gameMain.fieldX - 1;
			}
			if (this.y < 0)
			{
				velocity.y = -velocity.y;
				this.y = 0;
			}
			else if (gameMain.fieldY <= this.y)
			{
				velocity.y = -velocity.y;
				this.y = gameMain.fieldY - 1;
			}
		}

	}

}