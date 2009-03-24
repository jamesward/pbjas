package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpAdd implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpAdd(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}