package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpMul implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpMul(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}