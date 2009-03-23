package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpMin implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpMin(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}