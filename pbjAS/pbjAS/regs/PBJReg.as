package pbjAS.regs
{
  public class PBJReg
  {
    public var value:int;
    public var data:Array; // <PBJChannel>
    
    public function PBJReg(value:int, data:Array)
    {
      this.value = value;
      this.data = data;
    }
  }
}