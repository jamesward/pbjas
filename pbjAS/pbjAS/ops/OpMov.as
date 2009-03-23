package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpMov implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpMov(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}