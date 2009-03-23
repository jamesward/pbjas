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

  public class TestShaderFilter extends TestCase
  {

    public function testRunShaderFilter():void
    {
      fail("not implemented");
    }
  }
}