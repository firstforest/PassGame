package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class GameMain extends Sprite
	{
		static public const P_Stock_MAX:Number = 5;
		private var bGroup:BallGroup;
		private var pGroup:PasserGroup;
		private var keys:Array;
		private var _player:Player;
		
		private var _fieldX:Number;
		private var _fieldY:Number;
		
		private var stat:Status;
		private var conPane:ControlPanel;
		
		private var timer:Timer;
		
		// BGM
		[Embed(source = "./lo_044.mp3", mimeType = "audio/mpeg")]
		private var BGM:Class;
		private var bgm:Sound;
		
		[Embed(source = "./b_091.mp3", mimeType = "audio/mpeg")]
		private var GainComboSound:Class;
		private var gainCombSound:Sound;
		private var pStock:Vector.<Boolean>;
		
		public function GameMain()
		{
			bGroup = new BallGroup();
			pGroup = new PasserGroup();
			keys = [];
			
			stat = new Status();
			conPane = new ControlPanel(stat);
			addChild(conPane);

			_player = new Player(30, 15, this);
			addChild(_player);
			
			timer = new Timer(1);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();

			addEventListener(Event.ENTER_FRAME, loop);
			addEventListener(Event.ADDED_TO_STAGE, addedStage);
			
			bgm = new BGM();
			var soundChannel:SoundChannel = bgm.play(0,int.MAX_VALUE);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundEnd);
			
			gainCombSound = new GainComboSound();
			
			pStock = new Vector.<Boolean>;
			for (var i:int = 0; i < P_Stock_MAX; i++) 
			{
				pStock[i] = false;
			}
			
			super();
		}
		
		private function onSoundEnd(e:Event):void 
		{
			bgm.play();
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			stat.comboTime -= 10;
			if (stat.comboTime <= 0)
			{
				stat.rate = 1;
				stat.comboTime = 0;
			}
		}
		
		private function addedStage(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			_fieldX = 600;
			_fieldY = stage.stageHeight;
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			if (keys[71]) //G
			{
				var p:Passer = new Passer(mouseX, mouseY, this);
				addChild(p);
				pGroup.add(p);
			}
			
			if (keys[72]) 
			{
				addPasserStock();
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
		
		public function gainCombo():void
		{
			stat.comboTime += Status.COMBO_TIME_MAX / 10;
			if (stat.comboTime > Status.COMBO_TIME_MAX) 
			{
				stat.comboTime = Status.COMBO_TIME_MAX;
				stat.rate++;
				gainCombSound.play();
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
		
		public function addScore(score:Number):void
		{
			stat.score += score*stat.rate;
		}
		
		public function addPasserStock():void 
		{
			for (var i:int = 0; i < P_Stock_MAX; i++) 
			{
				if (pStock[i]) 
				{
					continue;
				}
				else 
				{
					pStock[i] = true;
					var p:PasserStock = new PasserStock(fieldX+20 + i*(PasserStock.SIZE*3), 400, i, this);
					addChild(p);
					break;
				}
			}
		}
		
		public function addPasser(ps:PasserStock):void
		{
			removeChild(ps);
			pStock[ps.num] = false;
			var p:Passer = new Passer(ps.x, ps.y, this);
			pGroup.add(p);
			addChild(p);
		}
		
		
		public function get player():Player 
		{
			return _player;
		}
		
		public function get fieldX(): Number
		{
			return _fieldX;
		}
		
		public function get fieldY():Number 
		{
			return _fieldY;
		}
	
	}

}