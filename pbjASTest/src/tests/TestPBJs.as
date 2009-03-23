package tests
{
  import flash.events.Event;
  import flash.utils.ByteArray;
  
  import net.digitalprimates.fluint.tests.TestCase;
  
  import pbjAS.PBJ;
  import pbjAS.PBJAssembler;
  import pbjAS.PBJDisassembler;

  public class TestPBJs extends TestCase
  {
    
    [Embed(source="VerySimpleFilter.pbj", mimeType="application/octet-stream")]
    private var VerySimpleFilterPBJ:Class;
    
    //
    // Test to make sure we can disassemble then reassemble a pbj
    //
    public function testVerySimpleFilter():void
    {
      var originalPBJByteArray:ByteArray = new VerySimpleFilterPBJ();
      var disassembledPBJ:PBJ = PBJDisassembler.disassemble(originalPBJByteArray);
      var reassembledPBJByteArray:ByteArray = PBJAssembler.assemble(disassembledPBJ);
      assertEquals(originalPBJByteArray, reassembledPBJByteArray);
    }
    
  }
}