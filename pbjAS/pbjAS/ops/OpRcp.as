package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpRcp implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpRcp(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}