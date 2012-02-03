package  
{
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class Status 
	{
		static public const COMBO_TIME_MAX:Number = 10000; // コンボ時間（ms）
		private var _score:Number; // スコア
		private var _rate:Number; // 得点倍率
		private var _comboTime:Number; // コンボ残り時間
		
		public function Status() 
		{
			score = 0;
			rate = 1;
			comboTime = 0;
		}
		
		public function get score():Number 
		{
			return _score;
		}
		
		public function set score(value:Number):void 
		{
			_score = value;
		}
		
		public function get rate():Number 
		{
			return _rate;
		}
		
		public function set rate(value:Number):void 
		{
			_rate = value;
		}
		
		public function get comboTime():Number 
		{
			return _comboTime;
		}
		
		public function set comboTime(value:Number):void 
		{
			_comboTime = value;
		}
		
	}

}