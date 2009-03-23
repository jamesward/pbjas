package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLogicalAnd implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpLogicalAnd(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}