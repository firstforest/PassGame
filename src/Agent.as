package 
{

import flash.display.Sprite;

public class Agent extends Sprite
{
	protected var gra:Sprite; // graphic
	protected var hojosen:Sprite; // hojosen
	protected var defPower:Number; // 受取り力
	protected var risePower:Number; // uwanose
	protected var atkPower:Number; // utidasiryoku
	protected var movePower:Number;
	protected var haveBalls:Vector.<Ball>;
	protected var gameMain:GameMain;
	
	private var color:uint;
	protected var red:Number;
	protected var green:Number;
	protected var blue:Number;
	
	public function Agent(x:Number, y:Number, gameMain:GameMain)
	{
		this.x = x;
		this.y = y;
		this.gameMain = gameMain;

		this.defPower = 50;
		this.risePower = 10; 
		this.atkPower = 20;
		this.movePower = 1;
		haveBalls = new Vector.<Ball>();
		
		// graphic
		red = int(Math.random() * 255);
		green = int(Math.random() * 255);
		blue = int(Math.random() * 255);
		color = red << 16 | green << 8 | blue;
		gra = new Sprite();
		gra.graphics.beginFill(color);
		gra.graphics.drawCircle(0, 0, 10);
		gra.graphics.endFill();
		
		addChild(gra);
				
		hojosen = new Sprite();		
		hojosen.graphics.lineStyle(1, 0xff0000);
		hojosen.graphics.drawCircle(0, 0, defPower);
		
		addChild(hojosen);
		super();
	}
	
	public function update():void
	{
		if (haveBalls.length == 0) receive();
		move();
		pass();
	}
	
	protected function receive():void
	{
		
	}
	
	protected function move():void
	{
		
	}
	
	protected function pass():void
	{
		
	}
	
	public function get position():Vector2D
	{
		return new Vector2D(x, y);
	}
	
}

}

