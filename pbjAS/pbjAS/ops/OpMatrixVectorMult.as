package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpMatrixVectorMult implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpMatrixVectorMult(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}