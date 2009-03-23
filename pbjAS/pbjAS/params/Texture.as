package pbjAS.params
{
  public class Texture implements PBJParam
  {
    public var channels:int;
    public var index:int;
    
    public function Texture(channels:int, index:int)
    {
      this.channels = channels;
      this.index = index;
    }
  }
}