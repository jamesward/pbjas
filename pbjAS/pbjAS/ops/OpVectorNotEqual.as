package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpVectorNotEqual implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpVectorNotEqual(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}