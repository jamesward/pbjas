package tests
{
  import flash.display.Shader;
  import flash.display.ShaderJob;
  import flash.events.Event;
  import flash.utils.ByteArray;
  import flash.utils.Endian;
  
  import net.digitalprimates.fluint.tests.TestCase;
  
  import pbjAS.PBJ;
  import pbjAS.PBJAssembler;
  import pbjAS.PBJChannel;
  import pbjAS.PBJDisassembler;
  import pbjAS.PBJType;
  import pbjAS.Tools;
  import pbjAS.ops.OpMov;
  import pbjAS.ops.OpMul;
  import pbjAS.ops.OpSampleNearest;
  import pbjAS.params.Parameter;
  import pbjAS.params.Texture;
  import pbjAS.regs.RFloat;
  import pbjAS.regs.RInt;

  public class TestOpSampleNearest extends TestCase
  {
    private var width:uint = 10;
    private var height:uint = 1;
    
    private var texture:Vector.<Number>;
    private var result:Vector.<Number>;

    public function testFloat():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "OpSampleNearest";
      myPBJ.metadatas = [];
      myPBJ.parameters = [{name:"_OutCoord", p:new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G])), metas:[]}, // f0.rg
        {name:"texture", p:new Texture(1, 0), metas:[]}, // t0
        {name:"result", p:new Parameter(PBJType.TFloat, true, new RFloat(1)), metas:[]} // f1
        ];
      myPBJ.code = [
        new OpSampleNearest(new RFloat(1), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f1, f0.rg, t0
        ];

      var assembledPBJByteArray:ByteArray = PBJAssembler.assemble(myPBJ);

      texture = new Vector.<Number>();

      for (var i:int = 0; i < height; i++)
      {
        for (var j:int = 0; j < width; j++)
        {
          var n:Number = Math.round(Math.random() * 1000);
          texture.push(j);
        }
      }

      var testShader:Shader = new Shader(assembledPBJByteArray);

      testShader.data.texture.width = width;
      testShader.data.texture.height = height;
      testShader.data.texture.input = texture;

      result = new Vector.<Number>;

      var shaderJob:ShaderJob = new ShaderJob(testShader, result, width, height);
      shaderJob.addEventListener(Event.COMPLETE, asyncHandler(onFloatShaderJobComplete, 10000, null, handleTimeout), false, 0, true);
      shaderJob.start();
    }
    
    protected function onFloatShaderJobComplete(event:Event, passThroughData:Object):void
    {
      if (texture.length != result.length)
      {
        fail("output lengths did not match! " + "\n" + texture + "\n" + result);
      }

      for (var i:int = 0; i < texture.length; i++)
      {
          var actual:Number = texture[i];
          var tested:Number = result[i];

          if (actual != tested)
          {
            fail("The tested value at " + i + " was not correct. actual = " + actual + " | tested = " + tested + "\n" + texture + "\n" + result);
          }
      }
    }
    
    public function testFloat2():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "TestOpSampleNearest";
      myPBJ.metadatas = [];
      myPBJ.parameters = [{name:"_OutCoord", p:new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G])), metas:[]}, // f0.rg
        {name:"texture", p:new Texture(2, 0), metas:[]}, // t0
        {name:"result", p:new Parameter(PBJType.TFloat2, true, new RFloat(1, [PBJChannel.R, PBJChannel.G])), metas:[]} // f1.rg
        ];
      myPBJ.code = [
        new OpSampleNearest(new RFloat(1, [PBJChannel.R, PBJChannel.G]), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f1.rg, f0.rg, t0
        ];

      var assembledPBJByteArray:ByteArray = PBJAssembler.assemble(myPBJ);

      texture = new Vector.<Number>();

      for (var i:int = 0; i < height; i++)
      {
        for (var j:int = 0; j < width; j++)
        {
          var n:Number = Math.round(Math.random() * 1000);
          texture.push(j);
          texture.push(i);
        }
      }

      var testShader:Shader = new Shader(assembledPBJByteArray);

      testShader.data.texture.width = width;
      testShader.data.texture.height = height;
      testShader.data.texture.input = texture;

      result = new Vector.<Number>;

      var shaderJob:ShaderJob = new ShaderJob(testShader, result, width, height);
      shaderJob.addEventListener(Event.COMPLETE, asyncHandler(onFloatShaderJobComplete, 10000, null, handleTimeout), false, 0, true);
      shaderJob.start();
    }

    private function handleTimeout(passThroughData:Object):void
    {
      fail("Timeout readed before event");
    }
  }
}