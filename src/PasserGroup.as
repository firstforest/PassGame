package
{
	
	/**
	 * ...
	 * @author Kazuhiro
	 */
	public class PasserGroup
	{
		private var passers:Vector.<Passer>;
		
		public function PasserGroup()
		{
			passers = new Vector.<Passer>();
			super();
		}
		
		public function add(p:Passer):void 
		{
			passers.push(p);
		}
		
		public function update():void 
		{
			for each (var p:Passer in passers) 
			{
				p.update();
			}
		}
		
		public function searchPasser(pos:Vector2D, searchPower:Number):Vector.<Passer>
		{
			var res:Vector.<Passer> = new Vector.<Passer>();
			for each (var p:Passer in passers)
			{
				if (pos.distance(p.position) < searchPower)
				{
					res.push(p);
				}
			}
			
			return res;
		}
	
	}

}