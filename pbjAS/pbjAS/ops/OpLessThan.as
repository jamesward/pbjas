package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLessThan implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpLessThan(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}