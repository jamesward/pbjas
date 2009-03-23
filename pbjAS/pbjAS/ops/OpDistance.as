package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpDistance implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpDistance(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}