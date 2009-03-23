package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLogicalNot implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpLogicalNot(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}