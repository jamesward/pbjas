package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpATan2 implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpATan2(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}