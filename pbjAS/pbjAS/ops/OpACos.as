package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpACos implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpACos(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}