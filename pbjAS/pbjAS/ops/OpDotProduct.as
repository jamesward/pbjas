package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpDotProduct implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpDotProduct(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}