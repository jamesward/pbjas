package mathpbj
{
  import __AS3__.vec.Vector;
  
  import flash.display.Shader;
  import flash.display.ShaderJob;
  import flash.events.EventDispatcher;
  import flash.events.ShaderEvent;
  import flash.events.TimerEvent;
  import flash.utils.ByteArray;
  import flash.utils.Timer;
  
  import mx.utils.UIDUtil;
  
  import pbjAS.PBJ;
  import pbjAS.PBJAssembler;
  import pbjAS.PBJChannel;
  import pbjAS.PBJParam;
  import pbjAS.PBJType;
  import pbjAS.ops.OpDiv;
  import pbjAS.ops.OpSampleNearest;
  import pbjAS.ops.OpSqrt;
  import pbjAS.params.Parameter;
  import pbjAS.params.Texture;
  import pbjAS.regs.RFloat;
  
  [Event(name="complete", type="flash.events.MathEvent")]
  [Event(name="progress", type="flash.events.MathEvent")]

  public class MathFunctionJob extends EventDispatcher
  {
    // this should have a whole sqrt
    private static const MAX_ITERATIONS_PER_JOB:uint = 2250000; // avoids random Flash Player crashes
    
    private var myPBJ:PBJ;
    private var shader:Shader;
    private var results:Vector.<Number>;
    private var jobs:Vector.<JobData>;
    private var currentJob:ShaderJob;
    private var timer:Timer;
    
    public var inputParams:Object;
    
    public var input:Vector.<Number>;
    
    public function MathFunctionJob()
    {
      inputParams = new Object();
      
      myPBJ = new PBJ();
      myPBJ.version = 1;
      myPBJ.name = "MathFunctionJob";
      myPBJ.metadatas = [];
      myPBJ.parameters = [
        new PBJParam("_OutCoord", new Parameter(PBJType.TFloat2, false, new RFloat(0, [PBJChannel.R, PBJChannel.G]))), // f0.rg
        new PBJParam("texture", new Texture(1, 0)), // t0
        new PBJParam("result", new Parameter(PBJType.TFloat, true, new RFloat(1, [PBJChannel.R]))) // f1.r
        ];
      myPBJ.code = [
        new OpSampleNearest(new RFloat(1, [PBJChannel.R]), new RFloat(0, [PBJChannel.R, PBJChannel.G]), 0), // texn    f1.r, f0.rg, t0
        ];
        
      timer = new Timer(100);
      timer.addEventListener(TimerEvent.TIMER, tick);
    }
    
    public function add(mathOperator:String):void
    {
      switch (mathOperator)
      {
        case "sqrt":
          myPBJ.code.push(new OpSqrt(new RFloat(1, [PBJChannel.R]), new RFloat(1, [PBJChannel.R]))); // sqrt f1.r, f1.r
          break;
        case "div":
          myPBJ.parameters.push(new PBJParam("divisor", new Parameter(PBJType.TFloat, false, new RFloat(2, [PBJChannel.R])))); // f2.r
          myPBJ.code.push(new OpDiv(new RFloat(1, [PBJChannel.R]), new RFloat(2, [PBJChannel.R]))); // sqrt f1.r, f2.r
          break;
      }
    }

    public function start():void
    {

      if (input == null)
      {
        throw new Error("input cannot be null");
      }
      
      var assembledPBJByteArray:ByteArray = PBJAssembler.assemble(myPBJ);
      shader = new Shader(assembledPBJByteArray);
      
      results = new Vector.<Number>();
      
      jobs = new Vector.<JobData>();
      
      var numJobs:Number = Math.ceil(input.length / MAX_ITERATIONS_PER_JOB);
      
      for (var i:uint = 0; i < numJobs; i++)
      {
        var startingMarker:Number = (i * MAX_ITERATIONS_PER_JOB);
        var itemsLeft:Number = input.length - startingMarker;
        
        if (itemsLeft > MAX_ITERATIONS_PER_JOB)
        {
          itemsLeft = MAX_ITERATIONS_PER_JOB;
        }
        
        var r:Object = getRectangleSize(itemsLeft);
        
        var w:Number = r.w;
        var h:Number = r.h;
        
        if (((w * h) != itemsLeft) && (i != numJobs - 1))
        {
          throw new Error("MAX_ITERATIONS_PER_JOB didn't have a whole sqrt");
        }
        
        jobs.push(new JobData(startingMarker, w, h));
      }
      
      // jobs must be rectangular so calculate if an extra job is needed
      var lastJobLength:Number = input.length % MAX_ITERATIONS_PER_JOB;
      if (lastJobLength != 0)
      {
        var lr:Object = getRectangleSize(lastJobLength);
        var lastJobRectSize:Number = (lr.w * lr.h);
        var lastPartialJobLength:Number = (lastJobLength - lastJobRectSize);
        
        if (lastPartialJobLength != 0)
        {
          // we will need another job
          jobs.push(new JobData((input.length - lastPartialJobLength), lastPartialJobLength, 1));
        }
      }

      // start the first job
      createJob(jobs[0]);
      timer.start();
    }
    
    private function getRectangleSize(length:Number):Object
    {
      var d:Number = Math.sqrt(length);
      var w:Number = Math.ceil(length / Math.floor(d));
      var h:Number = Math.floor(length / w);
      
      return {w: w, h: h};
    }

    private function createJob(jobData:JobData):void
    {
      if ((jobData.width > 8192) || (jobData.height > 8192))
      {
        throw new Error("Texture width or height cannot exceed 8192");
      }
      
      var texture:Vector.<Number> = input.slice(jobData.startingMarker, jobData.startingMarker + (jobData.width * jobData.height));
      
      currentJob = new ShaderJob(shader, jobData.results, jobData.width, jobData.height);
      currentJob.addEventListener(ShaderEvent.COMPLETE, onShaderJobComplete);
      
      for (var s:String in inputParams)
      {
        shader.data[s].value = [inputParams[s]];
      }
      
      shader.data.texture.width = jobData.width;
      shader.data.texture.height = jobData.height;
      shader.data.texture.input = texture;
      
      currentJob.start();
    }
    
    private function onShaderJobComplete(event:ShaderEvent):void
    {
      (event.currentTarget as ShaderJob).removeEventListener(ShaderEvent.COMPLETE, onShaderJobComplete);
      
      results = results.concat(event.vector);
      
      jobs.shift();
      
      if (jobs.length > 0)
      {
        createJob(jobs[0]);
      }
      else
      {
        timer.stop();
        tick();
        
        var s:MathEvent = new MathEvent(MathEvent.COMPLETE);
        s.results = results;
        dispatchEvent(s);
      }
    }
    
    private function tick(event:TimerEvent=null):void
    {
      var numJobs:Number = Math.ceil(input.length / MAX_ITERATIONS_PER_JOB);
      var numCompleteJobs:Number = numJobs - jobs.length;
      var percentComplete:Number = (numCompleteJobs / numJobs);
      var jobPercentComplete:Number = currentJob.progress / numJobs;
      if (numJobs > numCompleteJobs)
      {
        percentComplete += jobPercentComplete;
      }
      
      var s:MathEvent = new MathEvent(MathEvent.PROGRESS);
      s.progress = percentComplete;
      dispatchEvent(s);
    }
  }
}