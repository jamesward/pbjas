package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpCos implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpCos(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}