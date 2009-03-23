package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLength implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpLength(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}