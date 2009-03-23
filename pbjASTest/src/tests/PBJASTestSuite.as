package tests
{
  import net.digitalprimates.fluint.tests.TestSuite;

  public class PBJASTestSuite extends TestSuite
  {
    public function PBJASTestSuite()
    {
      super();
      
      addTestCase(new TestManualAssembly());
      addTestCase(new TestPBJs());
      addTestCase(new TestShaderJob());
      addTestCase(new TestShaderFilter());
      addTestCase(new TestOpSampleNearest());
      //addTestCase(new TestOpAbs());
      //etc.  we need 100% test coverage for the operations
    }
    
  }
}