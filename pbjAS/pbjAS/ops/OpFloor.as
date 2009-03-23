package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpFloor implements PBJOpcode
  {
     public var dst:PBJReg;
     public var src:PBJReg;
     
     public function OpFloor(dst:PBJReg, src:PBJReg)
     {
       this.dst = dst;
       this.src = src;
     }
  }
}