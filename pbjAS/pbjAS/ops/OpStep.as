package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpStep implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpStep(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}