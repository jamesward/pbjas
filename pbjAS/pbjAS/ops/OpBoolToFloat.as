package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpBoolToFloat implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpBoolToFloat(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}