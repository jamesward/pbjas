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
  import pbjAS.PBJParam;
  import pbjAS.PBJType;
  import pbjAS.ops.OpDiv;
  import pbjAS.ops.OpElse;
  import pbjAS.ops.OpEndIf;
  import pbjAS.ops.OpFloatToInt;
  import pbjAS.ops.OpIf;
  import pbjAS.ops.OpLoadFloat;
  import pbjAS.ops.OpMov;
  import pbjAS.ops.OpMul;
  import pbjAS.ops.OpSampleNearest;
  import pbjAS.params.Parameter;
  import pbjAS.params.Texture;
  import pbjAS.regs.RFloat;
  import pbjAS.regs.RInt;

  public class TestOpElse extends TestCase
  {
    private var width:uint = 12; // a multiple of 1, 2, 3, and 4 so that we don't run into weirdness
    private var height:uint = 12;

    public function testFloat():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "OpIf";
      myPBJ.metadatas = [];
      myPBJ.parameters = [new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G]))), // f0.rg
        new PBJParam("texture", new Texture(1, 0)), // t0
        new PBJParam("result", new Parameter(PBJType.TFloat, true, new RFloat(1, [PBJChannel.R]))) // f1.r
        ];
      myPBJ.code = [
        new OpSampleNearest(new RFloat(2, [PBJChannel.R]), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f2.r, f0.rg, t0
        new OpFloatToInt(new RInt(0, [PBJChannel.R]), new RFloat(2, [PBJChannel.R])), // cast the float to an int
        new OpIf(new RInt(0, [PBJChannel.R])),
        new OpLoadFloat(new RFloat(1, [PBJChannel.R]), 0),
        new OpElse(),
        new OpLoadFloat(new RFloat(1, [PBJChannel.R]), 1),
        new OpEndIf()
        ];

      runTest(myPBJ, 1);
    }

    private function runTest(myPBJ:PBJ, innerWidth:uint):void
    {
      var assembledPBJByteArray:ByteArray = PBJAssembler.assemble(myPBJ);

      var texture:Vector.<Number> = new Vector.<Number>();

      for (var i:int = 0; i < height; i++)
      {
        for (var j:int = 0; j < width; j++)
        {
          var n:Number = j;
          texture.push(n);
        }
      }
      
      var testShader:Shader = new Shader(assembledPBJByteArray);

      testShader.data.texture.width = width / innerWidth;
      testShader.data.texture.height = height;
      testShader.data.texture.input = texture;

      var result:Vector.<Number> = new Vector.<Number>;

      var shaderJob:ShaderJob = new ShaderJob(testShader, result, width / innerWidth, height);
      shaderJob.start(true);

      if (texture.length != result.length)
      {
        fail("output lengths did not match! " + "\n" + texture + "\n" + result);
      }

      for (var k:int = 0; k < texture.length; k++)
      {
        if ((texture[k] == 0) && (result[k] != 1))
        {
          fail("item at " + k + " was supposed to be 1");
        }
      }
    }
  }
}