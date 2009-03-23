package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpTan implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpTan(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}