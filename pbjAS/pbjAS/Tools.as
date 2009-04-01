/*
 * Original code is from the haXe formats library with the following license:
 *
 * Copyright (c) 2008, The haXe Project Contributors
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HAXE PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HAXE PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 *
 */
package pbjAS
{
  import flash.utils.ByteArray;
  
  import pbjAS.consts.*;
  import pbjAS.ops.*;
  import pbjAS.params.IParameter;
  import pbjAS.params.Parameter;
  import pbjAS.params.Texture;
  import pbjAS.regs.PBJReg;
  import pbjAS.regs.RFloat;
  

  public class Tools
  {

    public static function ext(e:Array)
    {
      if (e == null)
        return "";
      var str=".";
      for each (var c in e)
      {
        switch (c)
        {
          case PBJChannel.R:
            str+="r";
            break;
          case PBJChannel.G:
            str+="g";
            break;
          case PBJChannel.B:
            str+="b";
            break;
          case PBJChannel.A:
            str+="a";
            break;
          case PBJChannel.M2x2:
            str+="2x2";
            break;
          case PBJChannel.M3x3:
            str+="3x3";
            break;
          case PBJChannel.M4x4:
            str+="4x4";
            break;
        }
      }
      return str;
    }

    public static function dumpReg(r:PBJReg):String
    {
      switch (r)
      {
        case r is PBJReg:
          return "i" + r.value + ext(r.data);
        case r is RFloat:
          return "f" + r.value + ext(r.data);
      }

      return null;
    }

    static function call(p:String, vl:Array):String
    {
      return p + "(" + vl.join(",") + ")";
    }

    public static function dumpValue(v):String
    {
      switch (v)
      {
        case v is PFloat:
          return v.f;
        case v is PFloat2:
          return call("float2", [v.f1, v.f2]);
        case v is PFloat3:
          return call("float3", [v.f1, v.f2, v.f3]);
        case v is PFloat4:
          return call("float4", [v.f1, v.f2, v.f3, v.f4]);
        case v is PFloat2x2:
          return call("float2x2", v.f);
        case v is PFloat3x3:
          return call("float4x4", v.f);
        case v is PFloat4x4:
          return call("float4x4", v.f);
        case v is PInt:
          return new String(v.i);
        case v is PInt2:
          return call("int2", [v.i1, v.i2]);
        case v is PInt3:
          return call("int3", [v.i1, v.i2, v.i3]);
        case v is PInt4:
          return call("int4", [v.i1, v.i2, v.i3, v.i4]);
        case v is PString:
          return "'" + v.s + "'";
      }

      return null;
    }

    public static function getValueType(v):String
    {
      switch (v)
      {
        case PFloat:
          return PBJType.TFloat;
        case PFloat2:
          return PBJType.TFloat2;
        case PFloat3:
          return PBJType.TFloat3;
        case PFloat4:
          return PBJType.TFloat4;
        case PFloat2x2:
          return PBJType.TFloat2x2;
        case PFloat3x3:
          return PBJType.TFloat3x3;
        case PFloat4x4:
          return PBJType.TFloat4x4;
        case PInt:
          return PBJType.TInt;
        case PInt2:
          return PBJType.TInt2;
        case PInt3:
          return PBJType.TInt3;
        case PInt4:
          return PBJType.TInt4;
        case PString:
          return PBJType.TString;
      }

      return null;
    }

    public static function getMatrixMaskBits(n:int):int
    {
      switch (n)
      {
        case 1:
          return 196;
        case 2:
          return 232;
        case 3:
          return 252;
        default:
          return -1;
      }
    }

    public static function dumpType(t:String):String
    {
      return t;
    }

    public static function dumpOpCode(c):String
    {
      switch (c)
      {
        case c is OpNop:
          return "nop";
        case c is OpSampleNearest:
          return "sampleNearest " + dumpReg(c.dst) + ", text" + c.srcTexture + "[" + dumpReg(c.src) + "]";
        case c is OpSampleLinear:
          return "sampleLinear " + dumpReg(c.dst) + ", text" + c.srcTexture + "[" + dumpReg(c.src) + "]";
        case c is OpLoadInt:
          return "loadint " + dumpReg(c.dst) + ", " + c.v;
        case c is OpLoadFloat:
          return "loadfloat " + dumpReg(c.dst) + ", " + c.v;
        case c is OpIf:
          return "if " + dumpReg(c.cond);
        case c is OpElse:
          return "else";
        case c is OpEndIf:
          return "endif";
      }

      /* ?????
         var op = Type.enumConstructor(c).substr(2).toLowerCase();
         var regs = Type.enumParameters(c);
         op+" "+dumpReg(regs[0])+", "+dumpReg(regs[1]);
       */
      return null;
    }

    public static function dump(p:PBJ):String
    {
      var buf=new String();
      buf.add("version : " + p.version + "\n");
      buf.add("name : '" + p.name + "'" + "\n");
      for each (var m:PBJMeta in p.metadatas)
      {
        buf.add("  meta " + m.key + " : " + dumpValue(m.value) + "\n");
      }
      for each (var pp:PBJParam in p.parameters)
      {
        switch (pp)
        {
          case pp is Parameter:
            buf+="  param " + ((pp as Parameter).out ? "out" : "in ") + " " + dumpReg((pp as Parameter).reg) + " " + dumpType((pp as Parameter).type) + "\t" + p.name + "\n";
            break;
          case pp is Texture:
            buf+="  text" + (pp as Texture).index + " " + (pp as Texture).channels + "-channels" + "\t" + p.name + "\n";
            break;
        }
        for each (var m:PBJMeta in p.metadatas)
        {
          buf.add("    meta " + m.key + " : " + dumpValue(m.value) + "\n");
        }
      }
      buf.add("code :\n");
      for each (var o:PBJOpcode in p.code)
      {
        buf.add("  " + dumpOpCode(o) + "\n");
      }
      return buf;
    }

    public static function hexDemp(ba:ByteArray):String
    {
      var s:String = "";
      
      ba.position = 0;
      
      while (ba.bytesAvailable)
      {
        s += ba.readByte().toString(16) + " ";
      }
      
      ba.position = 0;
      
      return s;
    }
  }
}