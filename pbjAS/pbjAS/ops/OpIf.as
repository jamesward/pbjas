package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpIf implements PBJOpcode
  {
     public var cond:PBJReg;
     
     public function OpIf(cond:PBJReg)
     {
       this.cond = cond;
     }
  }
}