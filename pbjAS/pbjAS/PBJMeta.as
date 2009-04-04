package pbjAS
{
  import pbjAS.consts.PBJConst;
  
  public class PBJMeta
  {
    public var key:String;
    public var value:PBJConst;
    
    public function PBJMeta(key:String, value:PBJConst)
    {
      this.key = key;
      this.value = value;
    }
  }
}