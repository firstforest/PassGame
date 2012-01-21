package 
{

public class Vector2D
	{

		public var x:Number;
		public var y:Number;

		public function Vector2D(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
			super();
		}

		// (0, 0)を返すgetter
		public static function get ZERO():Vector2D
		{
			return new Vector2D(0, 0);
		}

		// ベクトル同士の加算
		public function add(vec:Vector2D):Vector2D
		{
			this.x += vec.x;
			this.y += vec.y;

			return this;
		}

		// ベクトル同士の減算
		public function subtract(vec:Vector2D):Vector2D
		{
			this.x -= vec.x;
			this.y -= vec.y;

			return this;
		}

		// ベクトルの各成分にvalue値を掛ける
		public function multiply(value:Number):Vector2D
		{
			this.x *= value;
			this.y *= value;

			return this;
		}

		// ベクトルの各成分からvalueを割る
		public function divide(value:Number):Vector2D
		{
			this.x /= value;
			this.y /= value;

			return this;
		}

		// ベクトルの大きさ - (0, 0)から(x, y)までの二点間距離
		public function get length():Number
		{
			return Math.sqrt(x * x + y * y);
		}

		// ベクトルの大きさをセットする
		public function set length(value:Number):void
		{
			var a:Number = angle;
			x = Math.cos(a) * value;
			y = Math.sin(a) * value;
		}

		// ベクトル同士の内積を求める
		public function dot(vec:Vector2D):Number
		{
			return this.x * vec.x + this.y * vec.y;
		}

		// ベクトルの正規化 - ベクトルの長さをthickness値にするためのxとyの長さを調整する
		public function normalize(thickness:Number = 1.0):Vector2D
		{
			if (length == 0)
			{
				this.x = 1.0;
				return this;
			}

			var scale:Number = thickness / length;
			this.x *= scale;
			this.y *= scale;

			return this;
		}

		// 自分の(x, y)から引数vecの(x, y)までの二点間距離を求める
		public function distance(vec:Vector2D):Number
		{
			return Math.sqrt(distanceSquared(vec));
		}

		// ２つのベクトル間の直交距離を求める
		public function distanceSquared(vec:Vector2D):Number
		{
			var tx:Number = this.x - vec.x;
			var ty:Number = this.y - vec.y;

			return tx * tx + ty * ty;
		}

		// ベクトルの大きさがmaxより大きいならmaxまで縮める
		public function truncate(max:Number):Vector2D
		{
			length = Math.min(length, max);

			return this;
		}

		// ベクトルのクローンを返す
		public function clone():Vector2D
		{
			return new Vector2D(x, y);
		}

		// ベクトルの値から求めた方向をラジアン値として返す
		public function get angle():Number
		{
			return Math.atan2(y, x);
		}

		// ラジアン値で指定された方向をもとにxyを計算する
		public function set angle(radian:Number):void
		{
			var len:Number = length;
			x = Math.cos(radian) * len;
			y = Math.sin(radian) * len;
		}

	}


}

