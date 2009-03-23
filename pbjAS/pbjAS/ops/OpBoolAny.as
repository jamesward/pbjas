package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpBoolAny implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpBoolAny(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}