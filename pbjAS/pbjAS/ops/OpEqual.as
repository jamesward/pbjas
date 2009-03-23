package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpEqual implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpEqual(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}