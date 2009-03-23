package pbjAS.ops
{
  public class OpIf implements PBJOpcode
  {
     public var cond:Object;
     
     public function OpIf(cond:Object)
     {
       this.cond = cond;
     }
  }
}