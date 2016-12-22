package tools {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class EX extends Tools{
		private var panel_sp:Sprite;
		private var add_btn:MovieClip;
		private var remove_btn:MovieClip; 
		public function EX(mc:MovieClip, tool_mc:MovieClip) {
			
			tool_mc.name = "8";
			super(mc,tool_mc);
				
			
		
		}
		
		override protected  function exe(){
			super.exe();
			
			
			mc.swtchMode("else");			
			panel();
			
		
			// panel_spのインスタンスの存在確認
		}
		
		
		public function panel():void{
			
		   if(!Boolean(mc.getChildByName('panel_sp'))){
				panel_sp = new Sprite();
				panel_sp.graphics.beginFill(0x55ff44, 1.0);
				panel_sp.graphics.drawRect(0,0,360,350);
				panel_sp.graphics.endFill();
				panel_sp.name = "panel_sp";
				panel_sp.y = 1090;
				panel_sp.x = 360;
				
				
				add_btn = new AddMovieClip();
				remove_btn = new RemoveMovieClip();
				
				add_btn.x  = 20;
				add_btn.y = 20;
				remove_btn.x = 120;
				remove_btn.y = 20;
				
				add_btn.addEventListener(MouseEvent.CLICK, addFunc);
				remove_btn.addEventListener(MouseEvent.CLICK, removeFunc);
				panel_sp.addChild(add_btn);
				panel_sp.addChild(remove_btn);
				mc.addChild(panel_sp);
			
			}
			
		}
		
		
		
		override public function remove():void{
			super.remove();
			if( Boolean(mc.getChildByName('panel_sp')) ){
				
				add_btn.removeEventListener(MouseEvent.CLICK, addFunc);
				remove_btn.removeEventListener(MouseEvent.CLICK, removeFunc);
				panel_sp.removeChild(add_btn);
				panel_sp.removeChild(remove_btn);
				mc.removeChild(panel_sp);
				add_btn = null;
				remove_btn = null;
				panel_sp = null;
			}
		}
		
		public function addFunc(e:MouseEvent):void{
			var sp:MovieClip  = new MovieClip();
			sp.graphics.beginFill(0x333333,1);
			sp.graphics.drawRect(30,30,130,130);
			sp.name = "sp";
		    //sp.name = "experiment";
			mc.createMovieClip(sp)
		}
		
		public function removeFunc(e:MouseEvent):void{
			// ツールが一致するかどうか確認後、削除
			if(String(mc.select_movieClip).substr(0,2) == "sp"){
				mc.removeMC(mc.select_movieClip);
				
			}
			
		}
	

	}
	
}