package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpSampleNearest implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     public var srcTexture:int;
     
     public function OpSampleNearest(dst:PBJReg, src: PBJReg, srcTexture:int)
     {
       this.dst = dst;
       this.src = src;
       this.srcTexture = srcTexture;
     }
  }
}