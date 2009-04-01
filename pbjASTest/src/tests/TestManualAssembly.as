package tests
{
  import flash.events.Event;
  import flash.utils.ByteArray;
  
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

  public class TestManualAssembly extends TestCase
  {
    
    [Embed(source="VerySimpleFilter.pbj", mimeType="application/octet-stream")]
    private var VerySimpleFilterPBJ:Class;

    private var assembledPBJByteArray:ByteArray
    private var originalPBJByteArray:ByteArray;

    override protected function setUp():void
    {
      originalPBJByteArray = new VerySimpleFilterPBJ();
      
      var myPBJ:PBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "VerySimpleFilter";
      myPBJ.metadatas = [];
      myPBJ.parameters = [
        new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0,[PBJChannel.R,PBJChannel.G]))),  // parameter   "_OutCoord", float2, f0.rg, in
        new PBJParam("src", new Texture(4,0)),  // texture     "src", t0
        new PBJParam("dst", new Parameter(PBJType.TFloat4, true, new RFloat(1))),  // parameter   "dst", float4, f1, out
        new PBJParam("exposure", new Parameter(PBJType.TFloat, false, new RFloat(0, [PBJChannel.B])))  // parameter   "exposure", float, f0.b, in
      ];
      myPBJ.code = [
        new OpSampleNearest(new RFloat(2), new RFloat(0,[PBJChannel.R, PBJChannel.G]), 0),  // texn    f2, f0.rg, t0
        new OpMov(new RFloat(3), new RFloat(0, [PBJChannel.B,PBJChannel.B,PBJChannel.B,PBJChannel.B])),  // mov     f3, f0.bbbb
        new OpMul(new RFloat(3), new RFloat(2)),  // mul     f3, f2
        new OpMov(new RFloat(1), new RFloat(3))  // mov     f1, f3
      ];
      
      assembledPBJByteArray = PBJAssembler.assemble(myPBJ);
    }
    
    //
    // test to make sure that we can create the same pbj as PixelBender
    //
    public function testLength():void
    {
      assertEquals(originalPBJByteArray.length, assembledPBJByteArray.length);
    }
    
    public function testEachByte():void
    {
      originalPBJByteArray.position = 0;
      assembledPBJByteArray.position = 0;
      
      for (var i:int = 0; i < assembledPBJByteArray.length; i++)
      {
        //trace('reading byte ' + i);
        var b1:int = originalPBJByteArray.readByte();
        var b2:int = assembledPBJByteArray.readByte();
        if (b1 != b2)
        {
          fail("byte number " + i + " was not the same.  original byte = " + b1 + " | assembled byte = " + b2);
        }
      }
    }
  }
}