package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLog2 implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpLog2(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}