package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpCeil implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpCeil(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}