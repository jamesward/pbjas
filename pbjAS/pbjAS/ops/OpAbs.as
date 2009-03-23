package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpAbs implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpAbs(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}