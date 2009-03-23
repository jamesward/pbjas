package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpSign implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpSign(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}