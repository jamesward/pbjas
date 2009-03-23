package pbjAS
{
  public class PBJ
  {
    public var version:int;
    public var name:String;
    public var metadatas:Array; // <PBJMeta>
    public var parameters:Array; // <{ name : String, metas : Array<PBJMeta>, p : PBJParam }>
    public var code:Array; // <PBJOpcode>
  }
}