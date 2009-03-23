package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpRSqrt implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpRSqrt(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}