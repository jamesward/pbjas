package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpATan implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpATan(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}