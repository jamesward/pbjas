package pbjAS.ops
{
  import pbjAS.regs.PBJReg;
  
  public class OpLoadInt implements PBJOpcode
  {
     public var reg:PBJReg;
     public var v:Number;
     
     public function OpLoadInt(reg:PBJReg, v:Number)
     {
       this.reg = reg;
       this.v = v;
     }
  }
}