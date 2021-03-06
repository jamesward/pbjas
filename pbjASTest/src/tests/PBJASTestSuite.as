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
      addTestCase(new TestShaderFilter());
      addTestCase(new TestShaderJob());
      
      addTestCase(new TestOpSampleNearest());
      addTestCase(new TestOpDiv());
      addTestCase(new TestOpIf());
      addTestCase(new TestOpElse());
      //etc.  we need 100% test coverage for the operations
    }
    
  }
}