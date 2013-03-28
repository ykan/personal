package  
{
	import fl.controls.Button;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import fl.controls.UIScrollBar;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author YuKan
	 */
	public class TestGenerate extends Sprite 
	{
		////////静态常量////////////
		private const SRC_DEFAULT:String = "src";
		private const TEST_DEFAULT:String = "tests";
		//////////////////
		
		private var generateBtn:Button;
		private var browseBtn:Button;
		
		private var proInput:TextInput;
		private var srcInput:TextInput;
		private var testInput:TextInput;
		
		private var message:TextArea;
		
		//////////Model/////////////
		private var _proPath:String;
		private var _srcPath:String;
		private var _testPath:String;
		
		//data 包数组 按包分成数组
		private var pg:Array;
		
		//////文件系统/////////
		private var file:File;
		private var infile:File;
		private var outfile:File;
		
		private var filestream:FileStream;
		
		public function TestGenerate() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			generateBtn = generate_btn;
			browseBtn = browse_btn;
			
			proInput = project_input;
			srcInput = src_input;
			testInput = test_input;
			
			message = message_box;
			
			
			//设定默认目录
			srcInput.text = SRC_DEFAULT;
			testInput.text = TEST_DEFAULT;
			
			_srcPath = SRC_DEFAULT;
			_testPath = TEST_DEFAULT;
			
			//创建包数组
			pg = new Array();
			
			//浏览项目目录
			browseBtn.addEventListener(MouseEvent.CLICK, browseForPro);
			generateBtn.addEventListener(MouseEvent.CLICK, generate);
		}
		
		private function browseForPro(e:MouseEvent):void 
		{
			file = new File();
			file.addEventListener(Event.SELECT, selectPro);
			file.browseForDirectory("选择一个项目目录");
		}
		private function selectPro(e:Event):void 
		{
			proPath = file.nativePath;
		}
		
		private function generate(e:MouseEvent):void 
		{
			if (!proPath) 
				alert("请选择一个项目！");
			else
			{
				file = new File(proPath + "\\" + srcPath);
				trace("src path:",file.nativePath);
				analysis(file);
				startGenerate();
			}
		}
		///////////////////分析src目录///////////////////////
		private function analysis(f:File):void 
		{
			if (f.isDirectory) 
			{
				var temp:Array = f.getDirectoryListing();
				
				//获取包名
				var packagename:String = f.nativePath.replace(proPath, "");
				packagename = packagename.replace("\\" + srcPath, "");
				packagename = packagename.replace(/^\\/, "");
				//trace("当前包名：", packagename);
				
				var length:int = temp.length;
				for (var i:int = 0; i < length; i++) 
				{
					if (temp[i].isDirectory)
						analysis(temp[i]);
					else 
					{
						//整理类信息
						pg[packagename] ||= new Array();
						if (temp[i].extension == 'as') 
							pg[packagename].push(analysisClass(temp[i]));
					}
				}
			}
		}
		
		private function analysisClass(f:File):String
		{
			//获取类名
			var cn:String = f.name.replace("."+f.extension, "");
			//trace("Class Name:", cn);
			return cn;
		}
		
		///////////////////生成测试//////////////////////////
		private function startGenerate():void
		{
			filestream = new FileStream();
			for (var i:String in pg) 
				for (var j:int = 0; j < pg[i].length; j++) 
					generateTest(i, pg[i][j]);
			
			generateSuite();
		}
		
		/**
		 * 产生测试类
		 * @param	pg 包名
		 * @param	classname 类名
		 */
		private function generateTest(pg:String,classname:String):void 
		{
			var f:File = new File(proPath + "\\" + testPath + "\\" + pg + "\\" + classname + "Test.as");
			
			var pgname:String = pg.replace(/\\/g, ".");
			var content:String = "package " + pgname + "\n{\n"
								+"\timport flexunit.framework.Assert;\n"
								+"\timport " + pgname + "." + classname + ";\n\n"
								+"\tpublic class " + classname + "Test" + "\n\t{\n"
								+"\t\t[Before]\n"
								+"\t\tpublic function setUp():void\n"
								+"\t\t{\n\t\t}\n\n"
								+"\t\t[After]\n"
								+"\t\tpublic function tearDown():void\n"
								+"\t\t{\n\t\t}\n\n"
								+"\t\t[BeforeClass]\n"
								+"\t\tpublic static function setUpBeforeClass():void\n"
								+"\t\t{\n\t\t}\n\n"
								+"\t\t[AfterClass]\n"
								+"\t\tpublic static function tearDownAfterClass():void\n"
								+"\t\t{\n\t\t}\n"
								+"\t}\n"
								+"}";
			
			filestream.open(f, FileMode.WRITE);
			filestream.writeUTFBytes(content);
			filestream.close();
			
			alert("generate "+pgname+"."+classname+"Test.as Successful!");
		}
		
		private function generateSuite():void 
		{
			var f:File = new File(proPath + "\\" + testPath + "\\" + "MainTestSuite.as");
			
			var content:String = "package \n{\n";
			
			//添加导入
			for (var i:String in pg) 
				for (var j:int = 0; j < pg[i].length; j++) 
					content += "\timport " + i.replace(/\\/g, ".") + "." + pg[i][j] + "Test;\n";
			
			content += "\n\t[Suite]\n\t[RunWith(\"org.flexunit.runners.Suite\")]\n\tpublic class MainTestSuite\n\t{\n";
			
			//添加实例
			for (i in pg) 
				for (j = 0; j < pg[i].length; j++) 
					content += "\t\tprivate var _" + pg[i][j].toLowerCase() +":"+pg[i][j]+ "Test;\n";
			
			content += "\t}\n}";
								
			filestream.open(f, FileMode.WRITE);
			filestream.writeUTFBytes(content);
			filestream.close();
			alert("generate MainTestSuite.as Successful!");
		}
		
		////////////////////////////
		private function alert(msg:String):void 
		{
			message.appendText(msg);
			message.appendText("\n");
		}
		
		
		//////////////////////////////Getter and Setter/////////////////////
		public function get proPath():String 
		{
			return _proPath;
		}
		
		public function set proPath(value:String):void 
		{
			_proPath = value;
			proInput.text = _proPath;
		}
		
		public function get srcPath():String 
		{
			return _srcPath;
		}
		
		public function set srcPath(value:String):void 
		{
			_srcPath = value;
			srcInput.text = _srcPath;
		}
		
		public function get testPath():String 
		{
			return _testPath;
		}
		
		public function set testPath(value:String):void 
		{
			_testPath = value;
			testInput.text = _testPath;
		}
		
	}

}