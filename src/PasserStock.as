package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ishime
	 */
	public class PasserStock extends Sprite
	{
		static public const SIZE:Number = 10;
		
		private var color:uint;
		private var selected:Boolean = false;
		private var gameMain:GameMain;
		private var _num:int;
		
		public function PasserStock(x:Number, y:Number, i:int, gameMain:GameMain) 
		{
			this.x = x;
			this.y = y;
			_num = i;
			this.gameMain = gameMain;
			
			color = 0xFF;
			
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, SIZE);
			graphics.endFill();
			
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(Event.ADDED_TO_STAGE, addedStage);
		}
		
		private function addedStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedStage);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			selected = false;
			gameMain.addPasser(this);
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (selected) 
			{
				x = e.stageX;
				y = e.stageY;	
			}
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			selected = true;
		}
		
		public function get num():int 
		{
			return _num;
		}
		
		
	}

}