package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpVectorEqual implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpVectorEqual(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}