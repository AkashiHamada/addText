﻿package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen3 extends Tools{

		public function Pen3(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "3";
			super(mc,tool_mc);
			
		
			

		
		}
		
		override protected  function exe(){
			super.exe();
			trace("pen3");
			
		}
	

	}
	
}
