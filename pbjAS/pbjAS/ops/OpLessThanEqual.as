package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLessThanEqual implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpLessThanEqual(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}