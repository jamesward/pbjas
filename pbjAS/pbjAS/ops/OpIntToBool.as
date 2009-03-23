package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpIntToBool implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpIntToBool(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}