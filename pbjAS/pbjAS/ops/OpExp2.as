package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpExp2 implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpExp2(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}