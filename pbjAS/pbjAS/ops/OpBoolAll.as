package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpBoolAll implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpBoolAll(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}