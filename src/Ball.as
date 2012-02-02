package  
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class Ball extends Sprite
	{
		private var gameMain:GameMain;
		private var gra:Sprite;
		private var border:Sprite;
		private	var borderLine:Number;
		private var color:uint;
		private var size:Number;
		private var velocity:Vector2D;
		
		private var r:Number;
		private var g:Number;
		private var b:Number;
		
		private static const DEATH_SPEED:Number = 0.95;
		private static const DEATH_LIMIT:Number = 0.05;
		
		// sound
		[Embed(source = "./b_070.mp3", mimeType = "audio/mpeg")]
		private var rmSound:Class;
		private var removeSound:Sound;
		[Embed(source = "./b_065.mp3", mimeType = "audio/mpeg")]
		private var vnSound:Class;
		private var vanishSound:Sound;
		
		
		public function Ball(x:Number, y:Number, color:uint, gameMain:GameMain)
		{
			this.x = x;
			this.y = y;
			this.gameMain = gameMain;
			size = 10;
			velocity = new Vector2D(Math.random() * 20,	Math.random() * 20);
			
			removeSound = new rmSound();
			vanishSound = new vnSound();
			
			r = color >> 16 & 0xFF;
			g = color >> 8 & 0xFF;
			b = color & 0xFF;
			
			this.color = color;
			gra = new Sprite();
			gra.graphics.beginFill(color);
			gra.graphics.drawCircle(0, 0, size);
			gra.graphics.endFill();
			addChild(gra);
			border = new Sprite();
			borderLine = 1;
			border.graphics.lineStyle(borderLine, 0x0);
			border.graphics.drawCircle(0, 0, size);
			addChild(border);
			
			super();
		}
		
		public function update():void
		{
			move();
			if (this.r == 255 && this.g == 255 && this.b == 255) //ボールが白くなったとき
			{
				if (this.x-size < 0 || gameMain.fieldX <= this.x+size || this.y-size < 0 || gameMain.fieldY <= this.y+size) 
				{
					collapse(); //崩壊
				}
			}
			else 
			{
				bounce(); //跳ね返り処理
			}

			// ボール減速処理
			velocity.multiply(DEATH_SPEED);
			// ボール消失処理
			if (velocity.length < DEATH_LIMIT)
			{
				vanish();
			}
			
		}
		
		private function vanish():void 
		{
			gameMain.addScore(10);
			gameMain.getBalls().remove(this);
			
			removeChild(gra);
			vanishSound.play();

			var timer:Timer = new Timer(1, 40);
			size /= 10;
			borderLine = 5;
			timer.addEventListener(TimerEvent.TIMER, vanishAnime);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerHandler);
			timer.start();
			
			//gameMain.removeChild(this);
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			gameMain.removeChild(this);
		}
		
		private function vanishAnime(e:TimerEvent):void 
		{
			border.graphics.clear();
			border.graphics.lineStyle(borderLine, color);
			border.graphics.drawCircle(0, 0, size);
			size *= 1.1;
			borderLine *= 0.95;
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
			gameMain.addScore(100);
			var p:Passer = new Passer(Math.random() * gameMain.fieldX, Math.random() * gameMain.fieldY, gameMain);
			gameMain.getPassers().add(p);
			gameMain.addChild(p);
			gameMain.getBalls().remove(this);
			gameMain.removeChild(this);
			gameMain.gainCombo();
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
			
			// 崩壊可能グラフィック
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
			if (this.x-size < 0)
			{
				velocity.x = -velocity.x;
				this.x = size;
			}
			else if (gameMain.fieldX <= this.x+size)
			{
				velocity.x = -velocity.x;
				this.x = gameMain.fieldX - size;
			}
			if (this.y-size< 0)
			{
				velocity.y = -velocity.y;
				this.y = size;
			}
			else if (gameMain.fieldY <= this.y+size)
			{
				velocity.y = -velocity.y;
				this.y = gameMain.fieldY - size;
			}
		}

	}

}