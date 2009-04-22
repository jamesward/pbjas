package mathpbj
{
  public class JobData
  {
    public var startingMarker:uint;
    public var width:uint;
    public var height:uint;
    public var complete:Boolean;
    public var results:Vector.<Number>;
    
    public function JobData(startingMarker:uint, width:uint, height:uint)
    {
      this.startingMarker = startingMarker;
      this.width = width;
      this.height = height;
      
      complete = false;
      results = new Vector.<Number>();
    }
  }
}