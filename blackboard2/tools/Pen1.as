package tools {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	//import flash.events.Event;
	//import flash.events.FocusEvent;
	import flash.events.TouchEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import fl.controls.ColorPicker;
	import fl.controls.Button;
    import fl.events.ColorPickerEvent;
	import tools.*;
	
	
	    public class Pen1 extends Tools{
		private var panel_sp:Sprite;// 緑のパネル
		private var remove_btn:Sprite;// X ボタン
		private var size_btn:Button;
		private var alpha_btn:Button;
		private var oldButton:String = "";
		private var erase_btn:Button;
		private var ac_btn:Button;
		private var slider:SliderClass;
		private var slider1:SliderClass;
		private var slider2:SliderClass;
		private var slider3:SliderClass;
		public var cp1:ColorPicker;// カラーピッカ
		
		public function Pen1(mc:MovieClip, tool_mc:MovieClip) {
				tool_mc.name = "1";
			   super(mc,tool_mc);
		}
		
		
		
		override protected function exe(){
			super.exe();
	
			panel_sp = new Sprite();
			panel_sp.graphics.beginFill(0x55ff44, 1.0);
			panel_sp.graphics.drawRect(0,0,720,650);
			panel_sp.graphics.endFill();
			panel_sp.y = 950;
			
			remove_btn = new Sprite();
			remove_btn.graphics.lineStyle(5.0,0x333333,0.8);
			remove_btn.graphics.beginFill(0xff0000,1.0);
			remove_btn.graphics.drawRect(0,0,80,80);
			remove_btn.graphics.lineStyle(10.0, 0xffffff);
			remove_btn.graphics.moveTo(10,10);
			remove_btn.graphics.lineTo(70,70);
			remove_btn.graphics.moveTo(10,70);
			remove_btn.graphics.lineTo(70,10);
			remove_btn.graphics.endFill();
			
			
		// textformat
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "有澤楷書";
			textFormat.size = 20;
			textFormat.color = 0x555555;
			
		// button
			size_btn = new Button();
			size_btn.name = "size_btn";
			size_btn.x = 600;
			size_btn.y = 30;
			size_btn.width = 100;
			size_btn.height = 50;
		
			size_btn.label = "サイズ";
			size_btn.setStyle("textFormat", textFormat);
			
			
			// button
			alpha_btn = new Button();
			alpha_btn.name = "alpha_btn";
			alpha_btn.x = 600;
			alpha_btn.y = 100;
			alpha_btn.width = 100;
			alpha_btn.height = 50;
			alpha_btn.label = "透明度";
			alpha_btn.setStyle("textFormat", textFormat);
			
				// button
			erase_btn = new Button();
			erase_btn.name = "erase_btn";
			erase_btn.x = 600;
			erase_btn.y = 170;
			erase_btn.width = 100;
			erase_btn.height = 50;
			erase_btn.label = "消しゴム";
			erase_btn.setStyle("textFormat", textFormat);
			
				// button
			ac_btn = new Button();
			ac_btn.name = "ac_btn";
			ac_btn.x = 600;
			ac_btn.y = 240;
			ac_btn.width = 100;
			ac_btn.height = 50;
			ac_btn.label = "クリア";
			ac_btn.setStyle("textFormat", textFormat);
			
			
		
			
		// color picker
			cp1 = new ColorPicker();
			cp1.addEventListener(ColorPickerEvent.CHANGE, colorPicTest);
	
			var color_arr:Array =[0xFFFFFF,0xC0C0C0,0x808080,0xbbbbbb,0x000000,0xFF0000,0x800000,0xFFFF00,0x808000,0x00FF00,0x008000,0x00FFFF,0x008080,0x0000FF,0x000080,0xFF00FF,0x800080,0xFFA500,0xFFEFD5,0xFFFFF0];
				
			cp1.setStyle("swatchWidth", 72); 
			cp1.setStyle("swatchHeight", 65); 
			cp1.setStyle("columnCount", 5);
			cp1.showTextField = false;
			//cp1.setStyle("textPadding", 31);
			//cp1.setStyle("textPadding", 0);
			cp1.colors = color_arr;
			cp1.x = 30;
			cp1.y = 20;
			cp1.open();
			
		// リスナ
			mc.stage.addEventListener(MouseEvent.MOUSE_DOWN, keepColorPicker);// color picker を保つため
			panel_sp.addEventListener(MouseEvent.MOUSE_DOWN, keepColorPicker);// color picker を保つため
			size_btn.addEventListener(MouseEvent.MOUSE_DOWN, sliderFunc);// color picker を保つため
			alpha_btn.addEventListener(MouseEvent.MOUSE_DOWN, sliderFunc);// color picker を保つため
			erase_btn.addEventListener(MouseEvent.MOUSE_DOWN, sliderFunc);
			ac_btn.addEventListener(MouseEvent.MOUSE_DOWN, allErase);
			remove_btn.addEventListener(MouseEvent.MOUSE_DOWN, remove_btnFunc);
			
		//  addChild
			panel_sp.addChild(cp1);
			panel_sp.addChild(remove_btn);
			mc.addChild(panel_sp);
			panel_sp.addChild(size_btn);
			panel_sp.addChild(alpha_btn);
			panel_sp.addChild(erase_btn);
			panel_sp.addChild(ac_btn);
			
			mc.createFirst = false;
			mc.swtchMode("write");
			
		}
		
		
		
		
		// カラ―ピッカーからフォーカスを失ったとき、カラーピッカを表示するため
		public function keepColorPicker(e:MouseEvent):void{
			cp1.open();
			
		}		
		
		public function sliderFunc(e:MouseEvent):void{
			
			switch(oldButton){
				case "size_btn" : 	if(slider){
										slider.remove();
										slider = null;
									};
									break;
				case "alpha_btn":	if(slider1){
										slider1.remove();
										slider1 = null;
									}
									; break;
				case "erase_btn": if(slider2){
										slider2.remove();
										slider2 = null;
									}; break;
				
			}
			
			switch(e.target.name){
				case "size_btn" : 	if(!slider){
										slider = new SliderClass(mc, 1, mc.penColor);
										slider.add((mc.penWidth * 15)+ 200);
									}
									break;
				case "alpha_btn":	if(!slider1){
										slider1 = new SliderClass(mc, 2, mc.penColor);
										slider1.add((mc.penAlpha * 450) + 200);
									}
									; break;
				case "erase_btn": if(!slider2){
										slider2 = new SliderClass(mc, 2, mc.penColor);
										slider2.add((mc.penAlpha * 450) +100);
									}; break;
				
			}
			
			
			
			
			
			oldButton = e.target.name;
			
		}
		
		public function allErase(e:MouseEvent):void{
			mc.allErase();
		}
		
		
		
		
		
			//　×　ボタンをタップしたとき
		 public function remove_btnFunc(e:MouseEvent):void{
				cp1.close();
				cp1.removeEventListener(ColorPickerEvent.CHANGE, colorPicTest);
				remove_btn.removeEventListener(MouseEvent.MOUSE_DOWN, remove_btnFunc);
				mc.stage.removeEventListener(MouseEvent.MOUSE_DOWN, keepColorPicker);// color picker を保つため
				panel_sp.removeEventListener(MouseEvent.MOUSE_DOWN, keepColorPicker);// color picker を保つため
				size_btn.removeEventListener(MouseEvent.MOUSE_DOWN, sliderFunc);// color picker を保つため
			    alpha_btn.removeEventListener(MouseEvent.MOUSE_DOWN, sliderFunc);// color picker を保つため
				erase_btn.removeEventListener(MouseEvent.MOUSE_DOWN, sliderFunc);
				ac_btn.removeEventListener(MouseEvent.MOUSE_DOWN, allErase);
			 
			 
				panel_sp.addChild(size_btn);
				panel_sp.addChild(alpha_btn);
				panel_sp.addChild(erase_btn);
				panel_sp.addChild(ac_btn);
			
				panel_sp.removeChild(remove_btn);
				panel_sp.removeChild(cp1);
				mc.removeChild(panel_sp);
		
				panel_sp = null;
				remove_btn = null;
				cp1 = null;
			 	if(slider){
					slider.remove();
					slider = null;
				}
				if(slider1){
					slider1.remove();
					slider1 = null;
				}
				if(slider2){
					slider2.remove();
					slider2 = null;
				}
				if(slider3){
					slider3.remove();
					slider3 = null;
				}
			}
			
			
			
			
			
			// 色を選んだ時
		public function colorPicTest(event:ColorPickerEvent):void {
			mc.penColor = cp1.selectedColor;
			mc.swtchMode("write");
			cp1.open();
		
		}
		
		
		
		
		
	

	}
	
}

