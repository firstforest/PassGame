package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class ControlPanel extends Sprite
	{
		private var backGround:Sprite;
		private var scoreFiled:TextField;
		private var comboGauge:Sprite;
		private var rateField:TextField;
		private var stat:Status;
		
		public function ControlPanel(stat:Status) 
		{
			x = 600;
			y = 0;
			this.stat = stat;
			
			// 背景
			backGround = new Sprite();
			backGround.graphics.beginFill(0x333333);
			backGround.graphics.drawRect(0, 0, 200, 600);
			backGround.graphics.endFill();
			addChild(backGround);
			
			// スコア表示
			scoreFiled = new TextField();
			scoreFiled.background = true;
			scoreFiled.text = "score: 0";
			scoreFiled.x = 10;
			scoreFiled.y = 20;
			scoreFiled.width = 100;
			scoreFiled.height = 20;
			addChild(scoreFiled);
			
			// コンボゲージ
			comboGauge = new Sprite();
			comboGauge.graphics.lineStyle(3, 0x0);
			comboGauge.graphics.drawRect(10, 60, 160, 20);
			comboGauge.graphics.beginFill(0xFFFFFF);
			comboGauge.graphics.drawRect(10, 60, 160*(stat.comboTime/Status.COMBO_TIME_MAX), 20);
			comboGauge.graphics.endFill();
			addChild(comboGauge);
			
			// 倍率
			rateField = new TextField();
			rateField.background = true;
			rateField.text = "rate: 1";
			rateField.x = 10;
			rateField.y = 100;
			rateField.width = 100;
			rateField.height = 20;
			addChild(rateField);
			
		}
		
		public function update():void
		{
			scoreFiled.text = "score: " + stat.score;
			comboGauge.graphics.clear();
			comboGauge.graphics.lineStyle(3, 0x0);
			comboGauge.graphics.drawRect(10, 60, 160, 20);
			comboGauge.graphics.beginFill(0xFFFFFF);
			comboGauge.graphics.drawRect(10, 60, 160*(stat.comboTime/Status.COMBO_TIME_MAX), 20);
			comboGauge.graphics.endFill();
			rateField.text = "rate: " + stat.rate;
			
		}
		
	}

}