module Graphics.WebGL.Shaders.Program

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType

public
data ProgramParameter
   = DeleteStatus
   | LinkStatus
   | ValidateStatus
   | AttachedShaders
   | ActiveAttributes
   | ActiveUniforms

instance MarshallGLEnum ProgramParameter where
    toGLEnum DeleteStatus     = 0x8B80
    toGLEnum LinkStatus       = 0x8B82
    toGLEnum ValidateStatus   = 0x8B83
    toGLEnum AttachedShaders  = 0x8B85
    toGLEnum ActiveAttributes = 0x8B89
    toGLEnum ActiveUniforms   = 0x8B86

    fromGLEnum 0x8B80 = DeleteStatus
    fromGLEnum 0x8B82 = LinkStatus
    fromGLEnum 0x8B83 = ValidateStatus
    fromGLEnum 0x8B85 = AttachedShaders
    fromGLEnum 0x8B89 = ActiveAttributes
    fromGLEnum 0x8B86 = ActiveUniforms

instance MarshallToJType ProgramParameter where
    toJType DeleteStatus     = JBool
    toJType LinkStatus       = JBool
    toJType ValidateStatus   = JBool
    toJType AttachedShaders  = JInt
    toJType ActiveAttributes = JInt
    toJType ActiveUniforms   = JInt

----------------------------------------------------------------------

public
getProgramParameter : Context -> Program -> (pname : ProgramParameter) -> IO (interpJType (toJType pname))
getProgramParameter (MkContext context) (MkProgram program) pname = map (unpackType (toJType pname)) $ mkForeign
    (FFun "%0.getProgramParameter(%1, %2)"
    [FPtr, FPtr, FEnum] (toFType (toJType pname)))
    context program (toGLEnum pname)

----------------------------------------------------------------------

public
createProgram : Context -> IO Program
createProgram (MkContext context) = map MkProgram $ mkForeign
    (FFun "%0.createProgram()"
    [FPtr] FPtr)
    context

----------------------------------------------------------------------

public
deleteProgram : Context -> Program -> IO ()
deleteProgram (MkContext context) (MkProgram program) = mkForeign
    (FFun "%0.deleteProgram(%1)"
    [FPtr, FPtr] FUnit)
    context program

----------------------------------------------------------------------

public
attachShader : Context -> Program -> Shader -> IO ()
attachShader (MkContext context) (MkProgram program) (MkShader shader) = mkForeign
    (FFun "%0.attachShader(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context program shader

----------------------------------------------------------------------

public
detachShader : Context -> Program -> Shader -> IO ()
detachShader (MkContext context) (MkProgram program) (MkShader shader) = mkForeign
    (FFun "%0.detachShader(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context program shader

----------------------------------------------------------------------

public
getAttachedShaders : Context -> Program -> IO (JSArray Shader)
getAttachedShaders (MkContext context) (MkProgram program) = map MkJSArray $ mkForeign
    (FFun "%0.getAttachedShaders(%1)"
    [FPtr, FPtr] FPtr)
    context program

----------------------------------------------------------------------

public
getProgramInfoLog : Context -> Program -> IO String
getProgramInfoLog (MkContext context) (MkProgram program) = mkForeign
    (FFun "%0.getProgramInfoLog(%1)"
    [FPtr, FPtr] FString)
    context program

----------------------------------------------------------------------

public
isProgram : Context -> Program -> IO Bool
isProgram (MkContext context) (MkProgram program) = map fromGLBool $ mkForeign
    (FFun "%0.isProgram(%1)"
    [FPtr, FPtr] FBool)
    context program

----------------------------------------------------------------------

public
linkProgram : Context -> Program -> IO ()
linkProgram (MkContext context) (MkProgram program) = mkForeign
    (FFun "%0.linkProgram(%1)"
    [FPtr, FPtr] FUnit)
    context program

----------------------------------------------------------------------

public
useProgram : Context -> Program -> IO ()
useProgram (MkContext context) (MkProgram program) = mkForeign
    (FFun "%0.useProgram(%1)"
    [FPtr, FPtr] FUnit)
    context program

----------------------------------------------------------------------

public
validateProgram : Context -> Program -> IO ()
validateProgram (MkContext context) (MkProgram program) = mkForeign
    (FFun "%0.validateProgram(%1)"
    [FPtr, FPtr] FUnit)
    context program

----------------------------------------------------------------------
