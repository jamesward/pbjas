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
  import pbjAS.ops.OpMov;
  import pbjAS.ops.OpMul;
  import pbjAS.ops.OpSampleNearest;
  import pbjAS.params.Parameter;
  import pbjAS.params.Texture;
  import pbjAS.regs.RFloat;
  import pbjAS.regs.RInt;

  public class TestOpSampleNearest extends TestCase
  {
    private var width:uint = 12; // a multiple of 1, 2, 3, and 4 so that we don't run into weirdness
    private var height:uint = 1;

    public function testFloat():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "OpSampleNearest";
      myPBJ.metadatas = [];
      myPBJ.parameters = [new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G]))), // f0.rg
        new PBJParam("texture", new Texture(1, 0)), // t0
        new PBJParam("result", new Parameter(PBJType.TFloat, true, new RFloat(1, [PBJChannel.R]))) // f1.r
        ];
      myPBJ.code = [new OpSampleNearest(new RFloat(1), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f1, f0.rg, t0
        ];

      runTest(myPBJ, 1);
    }

    public function testFloat2():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "TestOpSampleNearest";
      myPBJ.metadatas = [];
      myPBJ.parameters = [new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G]))), // f0.rg
        new PBJParam("texture", new Texture(2, 0)), // t0
        new PBJParam("result", new Parameter(PBJType.TFloat2, true, new RFloat(1, [PBJChannel.R, PBJChannel.G]))) // f1.rg
        ];
      myPBJ.code = [new OpSampleNearest(new RFloat(1), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f1, f0.rg, t0
        ];

      runTest(myPBJ, 2);
    }

    public function testFloat3():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "TestOpSampleNearest";
      myPBJ.metadatas = [];
      myPBJ.parameters = [new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G]))), // f0.rg
        new PBJParam("texture", new Texture(3, 0)), // t0
        new PBJParam("result", new Parameter(PBJType.TFloat3, true, new RFloat(1, [PBJChannel.R, PBJChannel.G, PBJChannel.B]))) // f1.rgb
        ];
      myPBJ.code = [new OpSampleNearest(new RFloat(1), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f1, f0.rg, t0
        ];

      runTest(myPBJ, 3);
    }

    public function testFloat4():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "TestOpSampleNearest";
      myPBJ.metadatas = [];
      myPBJ.parameters = [new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G]))), // f0.rg
        new PBJParam("texture", new Texture(4, 0)), // t0
        new PBJParam("result", new Parameter(PBJType.TFloat4, true, new RFloat(1, [PBJChannel.R, PBJChannel.G, PBJChannel.B, PBJChannel.A]))) // f1.rgba
        ];
      myPBJ.code = [new OpSampleNearest(new RFloat(1), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f1, f0.rg, t0
        ];

      runTest(myPBJ, 4);
    }

    private function runTest(myPBJ:PBJ, innerWidth:uint):void
    {
      var assembledPBJByteArray:ByteArray = PBJAssembler.assemble(myPBJ);

      var texture:Vector.<Number> = new Vector.<Number>();

      for (var i:int = 0; i < height; i++)
      {
        for (var j:int = 0; j < width; j++)
        {
          var n:Number = Math.round(Math.random() * 1000);
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
        var actual:Number = texture[k];
        var tested:Number = result[k];

        if (actual != tested)
        {
          fail("The tested value at " + k + " was not correct. actual = " + actual + " | tested = " + tested + "\n" + texture + "\n" + result);
        }
      }
    }
  }
}