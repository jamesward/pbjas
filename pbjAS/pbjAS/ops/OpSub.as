package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpSub implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpSub(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}