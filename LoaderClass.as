package  {
	
	
					// 削除を呼ぶ
					//mc.removeScreen();
	
	
	import flash.display.MovieClip;
	import flash.media.CameraRoll;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.text.TextField;
	import flash.events.MediaEvent;
	import flash.media.MediaPromise;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
		import flash.display.Loader;
	
	public class LoaderClass extends MovieClip {
		private var mc:MovieClip;
		private var camera_roll:CameraRoll;
		private var info:LoaderInfo;
		public	var loader:Loader; // （start画面)　画像のロード
		public function LoaderClass(mc:MovieClip) {
				this.mc = mc;
			
				// ローダーオブジェクトを作成
				loader = new Loader();
				 info = loader.contentLoaderInfo;
				info.addEventListener(Event.COMPLETE, infoComplete);
				info.addEventListener(IOErrorEvent.IO_ERROR, infoError);

		}
		
		
		
		
		
		
		// カメラロール
		 public function  cameraRoll_click(e:MouseEvent):void{
				trace("cameraRoll");
				if(CameraRoll.supportsBrowseForImage){
						// カメラロールオブジェクトを作成
						 camera_roll = new CameraRoll();
				
						// 画像選択ダイアログを表示する
						camera_roll.browseForImage();
						// ユーザーが画像を選択すると実行されるイベント
						camera_roll.addEventListener(MediaEvent.SELECT, cemera_roll_event);
						

			}
		}
		 public function cemera_roll_event(e:MediaEvent):void{
						var media_promise:MediaPromise = e.data;
						loader.loadFilePromise(media_promise);
						
					
		}
		
		 public function infoComplete(e:Event):void{
				
					
					/*mc.addChild(loader);
					mc.setChildIndex(loader, 0);*/
					
					
					// 削除を呼ぶ
					mc.removeScreen();
					camera_roll.removeEventListener(MediaEvent.SELECT, cemera_roll_event);
					info.removeEventListener(Event.COMPLETE, infoComplete);
					info.removeEventListener(IOErrorEvent.IO_ERROR, infoError);
			 
					camera_roll = null;
					info = null;
		}
		
		 public function infoError(e:IOErrorEvent):void{
					mc.text_field.text = "入出力エラーが発生した (Loader)\n" ;
		}


	}
	
}
