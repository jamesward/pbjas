package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpFloatToBool implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpFloatToBool(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}