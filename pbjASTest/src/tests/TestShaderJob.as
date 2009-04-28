package tests
{
  import __AS3__.vec.Vector;
  
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
  import pbjAS.PBJTools;
  import pbjAS.PBJType;
  import pbjAS.ops.OpMov;
  import pbjAS.ops.OpMul;
  import pbjAS.ops.OpSampleNearest;
  import pbjAS.params.Parameter;
  import pbjAS.params.Texture;
  import pbjAS.regs.RFloat;
  import pbjAS.regs.RInt;

  public class TestShaderJob extends TestCase
  {
    private var width:uint = 10;
    private var height:int = 1;
    private var result:Vector.<Number>;
    private var expectedResult:Vector.<Number>;

    public function testSingleMul():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "SingleMulFilter";
      myPBJ.parameters = [new PBJParam("num1", new Parameter(PBJType.TFloat, false, new RFloat(0, [PBJChannel.R]))),
        new PBJParam("num2", new Parameter(PBJType.TFloat, false, new RFloat(1, [PBJChannel.R]))),
        new PBJParam("product", new Parameter(PBJType.TFloat, true, new RFloat(2, [PBJChannel.R])))];
      myPBJ.code = [new OpMul(new RFloat(0, [PBJChannel.R]), new RFloat(1, [PBJChannel.R])),
        new OpMov(new RFloat(2, [PBJChannel.R]), new RFloat(0, [PBJChannel.R]))];

      var assembledPBJByteArray:ByteArray = PBJAssembler.assemble(myPBJ);

      var num1:Number = Math.round(Math.random() * 1000);
      var num2:Number = Math.round(Math.random() * 1000);

      var testShader:Shader = new Shader(assembledPBJByteArray);

      testShader.data.num1.value = [num1];
      testShader.data.num2.value = [num2];

      var result:Vector.<Number> = new Vector.<Number>();

      var shaderJob:ShaderJob = new ShaderJob(testShader, result, 1, 1);
      shaderJob.start(true);

      var realProduct:Number = num1 * num2;

      var calcProduct:Number = result[0];

      assertEquals(realProduct, calcProduct);
    }


    public function testMulMany():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "MulManyFilter";
      myPBJ.parameters = [new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G]))), // f0
        new PBJParam("tex", new Texture(1, 0)), // t0
        new PBJParam("num", new Parameter(PBJType.TFloat, false, new RFloat(1, [PBJChannel.R]))), // f1.r
        new PBJParam("product", new Parameter(PBJType.TFloat, true, new RFloat(2, [PBJChannel.R]))) // f2.r
        ];
      myPBJ.code = [new OpSampleNearest(new RFloat(2, [PBJChannel.R]), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f2.r, f0.rg, t0
        new OpMul(new RFloat(2, [PBJChannel.R]), new RFloat(1, [PBJChannel.R])), // mul f2.r, f1.r
        ];

      var assembledPBJByteArray:ByteArray = PBJAssembler.assemble(myPBJ);

      var tex:Vector.<Number> = new Vector.<Number>();
      var num:Number = Math.round(Math.random() * 1000);

      expectedResult = new Vector.<Number>();

      for (var i:int = 0; i < height; i++)
      {
        for (var j:int = 0; j < width; j++)
        {
          var n:Number = Math.round(Math.random() * 1000);
          tex.push(n);
          expectedResult.push(n * num);
        }
      }

      var testShader:Shader = new Shader(assembledPBJByteArray);

      testShader.data.tex.width = width;
      testShader.data.tex.height = height;
      testShader.data.tex.input = tex;

      testShader.data.num.value = [num];

      result = new Vector.<Number>();

      var shaderJob:ShaderJob = new ShaderJob(testShader, result, width, height);
      shaderJob.addEventListener(Event.COMPLETE, asyncHandler(onShaderJobComplete, 10000, null, handleTimeout), false, 0, true);
      shaderJob.start();
    }

    protected function onShaderJobComplete(event:Event, passThroughData:Object):void
    {
      trace(expectedResult);
      trace(result);

      for (var k:int = 0; k < height; k++)
      {
        for (var l:int = 0; l < width; l++)
        {
          var i:uint = (k * l) + l;
          var realProduct:Number = expectedResult[i];
          var calcProduct:Number = result[i];

          if (realProduct != calcProduct)
          {
            fail("On row number " + k + " and column number " + l + " the product was not correct. realProduct = " + realProduct + " | calcProduct = " + calcProduct); // + "\n" + Tools.hexDemp(expectedResult) + "\n" + Tools.hexDemp(result));
          }
        }
      }
    }

    private function handleTimeout(passThroughData:Object):void
    {
      fail("Timeout readed before event");
    }
  }
}