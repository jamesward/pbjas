package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLogicalXor implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpLogicalXor(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}