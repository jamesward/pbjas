package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpSqrt implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpSqrt(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}