package mathpbj
{
  import flash.events.Event;

  public class MathEvent extends Event
  {
    public static const COMPLETE:String = "complete";
    public static const PROGRESS:String = "progress";

    public var results:Vector.<Number>;
    public var progress:Number;
    
    public function MathEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
    {
      super(type, bubbles, cancelable);
      
      progress = 0;
    }
    
  }
}