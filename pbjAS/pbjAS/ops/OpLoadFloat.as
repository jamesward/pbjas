package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLoadFloat implements PBJOpcode
  {
     public var reg:PBJReg;
     public var v:Number;
     
     public function OpLoadFloat(reg:PBJReg, v:Number)
     {
       this.reg = reg;
       this.v = v;
     }
  }
}