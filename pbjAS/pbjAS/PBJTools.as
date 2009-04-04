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
  import flash.display.ShaderInput;
  import flash.utils.ByteArray;
  import flash.utils.getQualifiedClassName;
  
  import pbjAS.consts.*;
  import pbjAS.ops.*;
  import pbjAS.params.IParameter;
  import pbjAS.params.Parameter;
  import pbjAS.params.Texture;
  import pbjAS.regs.PBJReg;
  import pbjAS.regs.RFloat;
  import pbjAS.regs.RInt;


  public class PBJTools
  {

    public static function ext(e:Array)
    {
      if (e == null)
        return "";
      var str = ".";
      for each (var c in e)
      {
        switch (c)
        {
          case PBJChannel.R:
            str += "r";
            break;
          case PBJChannel.G:
            str += "g";
            break;
          case PBJChannel.B:
            str += "b";
            break;
          case PBJChannel.A:
            str += "a";
            break;
          case PBJChannel.M2x2:
            str += "2x2";
            break;
          case PBJChannel.M3x3:
            str += "3x3";
            break;
          case PBJChannel.M4x4:
            str += "4x4";
            break;
        }
      }
      return str;
    }

    public static function dumpReg(r:PBJReg):String
    {
      if (r is RInt)
          return "i" + r.value + ext(r.data);
      else if (r is RFloat)
          return "f" + r.value + ext(r.data);

      return null;
    }

    static function call(p:String, vl:Array):String
    {
      return p + "(" + vl.join(",") + ")";
    }

    public static function dumpValue(v):String
    {
      if (v is PFloat)
        return v.f;
      else if (v is PFloat2)
        return call("float2", [v.f1, v.f2]);
      else if (v is PFloat3)
        return call("float3", [v.f1, v.f2, v.f3]);
      else if (v is PFloat4)
        return call("float4", [v.f1, v.f2, v.f3, v.f4]);
      else if (v is PFloat2x2)
        return call("float2x2", v.f);
      else if (v is PFloat3x3)
        return call("float4x4", v.f);
      else if (v is PFloat4x4)
        return call("float4x4", v.f);
      else if (v is PInt)
        return new String(v.i);
      else if (v is PInt2)
        return call("int2", [v.i1, v.i2]);
      else if (v is PInt3)
        return call("int3", [v.i1, v.i2, v.i3]);
      else if (v is PInt4)
        return call("int4", [v.i1, v.i2, v.i3, v.i4]);
      else if (v is PString)
        return "'" + v.s + "'";

      return null;
    }

    public static function getValueType(v:PBJConst):String
    {
      if (v is PFloat)
        return PBJType.TFloat;
      else if (v is PFloat2)
        return PBJType.TFloat2;
      else if (v is PFloat3)
        return PBJType.TFloat3;
      else if (v is PFloat4)
        return PBJType.TFloat4;
      else if (v is PFloat2x2)
        return PBJType.TFloat2x2;
      else if (v is PFloat3x3)
        return PBJType.TFloat3x3;
      else if (v is PFloat4x4)
        return PBJType.TFloat4x4;
      else if (v is PInt)
        return PBJType.TInt;
      else if (v is PInt2)
        return PBJType.TInt2;
      else if (v is PInt3)
        return PBJType.TInt3;
      else if (v is PInt4)
        return PBJType.TInt4;
      else if (v is PString)
        return PBJType.TString;

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
      if (c is OpNop)
        return "nop";
      else if (c is OpSampleNearest)
        return "sampleNearest " + dumpReg(c.dst) + ", t" + c.srcTexture + "[" + dumpReg(c.src) + "]";
      else if (c is OpSampleLinear)
        return "sampleLinear " + dumpReg(c.dst) + ", t" + c.srcTexture + "[" + dumpReg(c.src) + "]";
      else if (c is OpLoadInt)
        return "loadint " + dumpReg(c.dst) + ", " + c.v;
      else if (c is OpLoadFloat)
        return "loadfloat " + dumpReg(c.dst) + ", " + c.v;
      else if (c is OpIf)
        return "if " + dumpReg(c.cond);
      else if (c is OpElse)
        return "else";
      else if (c is OpEndIf)
        return "endif";
      else
      {
        var op:String = getQualifiedClassName(c);

        // doesn't work
        /*
        var s:String = op;
        for (var p:String in (c as PBJOpcode))
        {
          s += " " + dumpReg(c[s]) + ", ";
        }
        return s;
        */
        return op + " " + dumpReg(c.dst) + ", " + dumpReg(c.src);
      }
      return null;
    }

    public static function dump(p:PBJ):String
    {
      var buf:String = new String();
      buf += "version : " + p.version + "\n";
      buf += "name : '" + p.name + "'" + "\n";
      for each (var m:PBJMeta in p.metadatas)
      {
        buf += "  meta " + m.key + " : " + dumpValue(m.value) + "\n";
      }
      for each (var pp:PBJParam in p.parameters)
      {
        if (pp.parameter is Parameter)
            buf += "  param " + ((pp.parameter as Parameter).out ? "out" : "in ") + " " + dumpReg((pp.parameter as Parameter).reg) + " " + dumpType((pp.parameter as Parameter).type) + "\t" + pp.name + "\n";
        else if(pp.parameter is Texture)
            buf += "  text" + (pp.parameter as Texture).index + " " + (pp.parameter as Texture).channels + "-channels" + "\t" + pp.name + "\n";
        
        for each (var mm:PBJMeta in pp.metadatas)
        {
          buf += "    meta " + mm.key + " : " + dumpValue(mm.value) + "\n";
        }
      }
      buf += "code :\n";
      for each (var o:PBJOpcode in p.code)
      {
        buf += "  " + dumpOpCode(o) + "\n";
      }
      return buf;
    }

    public static function hexDump(ba:ByteArray):String
    {
      var s:String = "";

      ba.position = 0;

      while (ba.bytesAvailable)
      {
        s += ba.readUnsignedByte().toString(16) + " ";
      }

      ba.position = 0;

      return s;
    }

    public static function splitShaderInputFloat4(shaderInput:ShaderInput, texture:Object, defaultValue:Number):void
    {
      if (texture.length > 16777216)
      {
        throw new Error("Texture length cannot exceed 16777216.");
      }

      // adjust the texture so that it is a float4
      while (texture.length % 4 != 0)
      {
        texture.push(1);
      }

      // split into slices (height > 1)
      var sl:Number = texture.length / 4;
      var d:Number = Math.sqrt(sl);
      var w:Number = Math.ceil(sl / Math.floor(d));
      var h:Number = Math.ceil(sl / w);

      if ((w > 8192) || (h > 8192))
      {
        throw new Error("Texture width or height cannot exceed 8192");
      }

      // adjust the texture so that it fits the dimensions
      while (texture.length < (w * h * 4))
      {
        texture.push(1);
        texture.push(1);
        texture.push(1);
        texture.push(1);
      }

      shaderInput.width = w
      shaderInput.height = h
      shaderInput.input = texture;
    }
  }
}