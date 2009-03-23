package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpMod implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpMod(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}