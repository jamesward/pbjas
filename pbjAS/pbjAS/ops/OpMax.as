package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpMax implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpMax(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}