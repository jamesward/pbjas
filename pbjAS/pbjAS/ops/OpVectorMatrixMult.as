package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpVectorMatrixMult implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpVectorMatrixMult(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}