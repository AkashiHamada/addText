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
	
	// pc の場合
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	
	public class LoaderClass extends MovieClip {
		private var mc:MovieClip;
		private var camera_roll:CameraRoll;
		private var info:LoaderInfo;
		public	var loader:Loader; // （start画面)　画像のロード
		
		private var mFileReference:FileReference;// pc
		public function LoaderClass(mc:MovieClip) {
				this.mc = mc;
				// ローダーオブジェクトを作成
				loader = new Loader(); // pc, スマホ
			if(CameraRoll.supportsBrowseForImage){
				 info = loader.contentLoaderInfo;
				info.addEventListener(Event.COMPLETE, infoComplete);
				info.addEventListener(IOErrorEvent.IO_ERROR, infoError);
			}

		}
		
		
		
		
		
		
		// カメラロール
		 public function  cameraRoll_click(e:MouseEvent):void{
			
			if(CameraRoll.supportsBrowseForImage){
						// カメラロールオブジェクトを作成
						 camera_roll = new CameraRoll();
				
						// 画像選択ダイアログを表示する
						camera_roll.browseForImage();
						// ユーザーが画像を選択すると実行されるイベント
						camera_roll.addEventListener(MediaEvent.SELECT, cemera_roll_event);		
			}else{
				// pcパソコンの場合
				
				mFileReference=new FileReference();
				mFileReference.addEventListener(Event.SELECT, onFileSelected);
				var swfTypeFilter:FileFilter = new FileFilter("SWF/JPG/PNG Files","*.jpeg; *.jpg;*.gif;*.png");
				var allTypeFilter:FileFilter = new FileFilter("All Files (*.*)","*.*");
				mFileReference.browse([swfTypeFilter, allTypeFilter]);
				
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
		
		
		
		
		
		
		// pc
		function onFileSelected(event:Event):void
{
    trace("onFileSelected");
    // This callback will be called when the file is uploaded and ready to use
    mFileReference.addEventListener(Event.COMPLETE, onFileLoaded);
 
    // This callback will be called if there's error during uploading
    mFileReference.addEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
 
    // Optional callback to track progress of uploading
    mFileReference.addEventListener(ProgressEvent.PROGRESS, onProgress);
 
    // Tells the FileReference to load the file
    mFileReference.load();
 
  
 
 
}
 
// This function is called to notify us of the uploading progress
function onProgress(event:ProgressEvent):void
{
    var percentLoaded:Number=event.bytesLoaded/event.bytesTotal*100;
    trace("loaded: "+percentLoaded+"%");
  
}
 
// This function is called after the file has been uploaded.
function onFileLoaded(event:Event):void
{
    var fileReference:FileReference=event.target as FileReference;
 
    // These steps below are to pass the data as DisplayObject
    // These steps below are specific to this example.
    var data:ByteArray=fileReference["data"];
    trace("File loaded");
 
    mFileReference.removeEventListener(Event.COMPLETE, onFileLoaded);
    mFileReference.removeEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
    mFileReference.removeEventListener(ProgressEvent.PROGRESS, onProgress);
    
 
 //   var movieClipLoader:Loader=new Loader();
    loader.loadBytes(data);
    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onMovieClipLoaderComplete);
 
}
 
function onFileLoadError(event:Event):void
{
    // Hide progress bar

    
    mFileReference.removeEventListener(Event.COMPLETE, onFileLoaded);
    mFileReference.removeEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
    mFileReference.removeEventListener(ProgressEvent.PROGRESS, onProgress);
    trace("File load error");
}
 
// This function below is specific to this example.
// It does the processing required to display the swf/png/jpeg file that we have just loaded.
function onMovieClipLoaderComplete(event:Event):void
{
   mc.removeScreen();
   
}


	}
	
}
