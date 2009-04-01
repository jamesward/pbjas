package pbjAS.params
{
  import pbjAS.regs.PBJReg;
  
  public class Parameter implements IParameter
  {
    public var type:String;
    public var out:Boolean;
    public var reg:PBJReg;
    
    public function Parameter(type: String, out:Boolean, reg:PBJReg)
    {
      this.type = type;
      this.out = out;
      this.reg = reg;
    }
  }
}