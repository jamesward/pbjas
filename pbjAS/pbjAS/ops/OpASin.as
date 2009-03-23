package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpASin implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpSin(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}