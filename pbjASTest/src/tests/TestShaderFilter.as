package tests
{
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Shader;
  import flash.display.ShaderJob;
  import flash.events.Event;
  import flash.filters.ShaderFilter;
  import flash.geom.ColorTransform;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.utils.ByteArray;
  
  import mx.controls.Image;
  import mx.events.FlexEvent;
  
  import net.digitalprimates.fluint.tests.TestCase;
  
  import pbjAS.PBJ;
  import pbjAS.PBJAssembler;
  import pbjAS.PBJChannel;
  import pbjAS.PBJDisassembler;
  import pbjAS.PBJParam;
  import pbjAS.PBJTools;
  import pbjAS.PBJType;
  import pbjAS.ops.OpDiv;
  import pbjAS.ops.OpMov;
  import pbjAS.ops.OpMul;
  import pbjAS.ops.OpSampleNearest;
  import pbjAS.params.Parameter;
  import pbjAS.params.Texture;
  import pbjAS.regs.RFloat;
  import pbjAS.regs.RInt;

  public class TestShaderFilter extends TestCase
  {
    [Embed(source="air-logo.jpg")]
    public var imgCls:Class;
    
    // account for slight differences in rounding
    private static const max_delta:uint = 1;

    public function testRunShaderFilter():void
    {
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "OpSampleNearest";
      myPBJ.metadatas = [];
      myPBJ.parameters = [new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G]))), // f0.rg
        new PBJParam("src", new Texture(4, 0)), // t0
        new PBJParam("mul", new Parameter(PBJType.TFloat, false, new RFloat(1, [PBJChannel.R]))), // f1.r
        new PBJParam("result", new Parameter(PBJType.TFloat4, true, new RFloat(2))) // f2
        ];
      myPBJ.code = [
        new OpSampleNearest(new RFloat(2), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f2, f0.rg, t0
        new OpMul(new RFloat(2, [PBJChannel.R, PBJChannel.G, PBJChannel.B]), new RFloat(1, [PBJChannel.R, PBJChannel.R, PBJChannel.R]))  // mul f2, f1.rrrr
        ];

      var assembledPBJByteArray:ByteArray = PBJAssembler.assemble(myPBJ);
      
      var testShader:Shader = new Shader(assembledPBJByteArray);
    
      testShader.data.mul.value = [0.5];

      var image:Image = new Image();
      var srcImage:Object = new imgCls();
      image.source = srcImage;
      image.width = srcImage.width;
      image.height = srcImage.height;
      image.cacheAsBitmap = false;
      addChild(image);
      
      var origBitmapData:BitmapData = new BitmapData(image.width, image.height);
      origBitmapData.draw(image, new Matrix());
      
      var shaderFilter:ShaderFilter = new ShaderFilter(testShader);
      
      var filteredBitmapData:BitmapData = new BitmapData(image.width, image.height);
      filteredBitmapData.draw(image, new Matrix());
      filteredBitmapData.applyFilter(filteredBitmapData, filteredBitmapData.rect, new Point(0,0), shaderFilter);
      
      var expectedBitmapData:BitmapData = new BitmapData(image.width, image.height);
      expectedBitmapData.draw(image, new Matrix());
      expectedBitmapData.colorTransform(expectedBitmapData.rect, new ColorTransform(0.5, 0.5, 0.5));
      
      // check each pixel
      for (var i:int = 0; i < origBitmapData.width; i++)
      {
        for (var j:int = 0; j < origBitmapData.height; j++)
        {
          
          var expected:uint = expectedBitmapData.getPixel32(i, j);
          
          var tested:uint = filteredBitmapData.getPixel32(i, j);
  
          var eRGB:Array = getRGB(expected);
          var tRGB:Array = getRGB(tested);
          
          if ((tRGB[0] < eRGB[0] - max_delta) || (tRGB[0] > eRGB[0] + max_delta) ||
              (tRGB[1] < eRGB[1] - max_delta) || (tRGB[1] > eRGB[1] + max_delta) ||
              (tRGB[2] < eRGB[2] - max_delta) || (tRGB[2] > eRGB[2] + max_delta))
          {
            fail("The tested pixel at x = " + i + " and y = " + j + " was not correct. expected = " + eRGB + " | tested = " + tRGB + "\n");
          }
        }
      }
    }
    
    private function getRGB(n:uint):Array
    {
      return [(n >> 16) & 0xFF, (n >> 8) & 0xFF, n & 0xFF];
    }
  }
}