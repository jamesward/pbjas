package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpCrossProduct implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpCrossProduct(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}