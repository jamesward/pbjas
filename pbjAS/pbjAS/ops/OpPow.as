package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpPow implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpPow(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}