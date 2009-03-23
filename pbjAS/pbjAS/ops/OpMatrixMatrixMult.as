package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpMatrixMatrixMult implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpMatrixMatrixMult(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}