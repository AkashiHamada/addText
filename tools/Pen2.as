﻿package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen2 extends Tools{

		public function Pen2(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "2";
		
			super(mc,tool_mc);
			

		
		}
		
		override protected  function exe(){
			super.exe();
		trace("pen2");
			
		}
		
	

	}
	
}