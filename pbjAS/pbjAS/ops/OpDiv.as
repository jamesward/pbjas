package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpDiv implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpDiv(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}