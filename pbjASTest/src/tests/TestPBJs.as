package tests
{
  import flash.events.Event;
  import flash.utils.ByteArray;
  
  import net.digitalprimates.fluint.tests.TestCase;
  
  import pbjAS.PBJ;
  import pbjAS.PBJAssembler;
  import pbjAS.PBJDisassembler;
  import pbjAS.PBJTools;

  public class TestPBJs extends TestCase
  {
    
    [Embed(source="VerySimpleFilter.pbj", mimeType="application/octet-stream")]
    private var VerySimpleFilterPBJ:Class;
    
    private var reassembledPBJByteArray:ByteArray
    private var originalPBJByteArray:ByteArray;

    //
    // Test to make sure we can disassemble then reassemble a pbj
    //
    override protected function setUp():void
    {
      originalPBJByteArray = new VerySimpleFilterPBJ();
      var disassembledPBJ:PBJ = PBJDisassembler.disassemble(originalPBJByteArray);
      trace(PBJTools.dump(disassembledPBJ));
      reassembledPBJByteArray = PBJAssembler.assemble(disassembledPBJ);
    }
    
    public function testLength():void
    {
      trace(PBJTools.hexDump(originalPBJByteArray));
      trace(PBJTools.hexDump(reassembledPBJByteArray));
      assertEquals(originalPBJByteArray.length, reassembledPBJByteArray.length);
    }
    
    public function testEachByte():void
    {
      originalPBJByteArray.position = 0;
      reassembledPBJByteArray.position = 0;
      
      for (var i:int = 0; i < reassembledPBJByteArray.length; i++)
      {
        var b1:int = originalPBJByteArray.readByte();
        var b2:int = reassembledPBJByteArray.readByte();
        if (b1 != b2)
        {
          fail("byte number " + i + " was not the same.  original byte = " + b1 + " | assembled byte = " + b2);
        }
      }
    }
    
  }
}