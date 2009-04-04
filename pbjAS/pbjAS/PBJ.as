package pbjAS
{
  public class PBJ
  {
    public var version:int;
    public var name:String;
    public var metadatas:Array; // <PBJMeta>
    public var parameters:Array; // <PBJParam>
    public var code:Array; // <PBJOpcode>
    
    public function PBJ()
    {
      metadatas = new Array();
      parameters = new Array();
      code = new Array();
    }
  }
}