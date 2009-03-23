package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpFract implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpFract(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}