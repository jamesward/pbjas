package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpSampleLinear implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     public var srcTexture:int;
     
     public function OpSampleLinear(dst:PBJReg, src: PBJReg, srcTexture:int)
     {
       this.dst = dst;
       this.src = src;
       this.srcTexture = srcTexture;
     }
  }
}