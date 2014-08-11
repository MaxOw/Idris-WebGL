module Graphics.WebGL.Shaders.Shader

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType

----------------------------------------------------------------------

data ShaderParameter
   = ShaderType
   | DeleteStatus'
   | CompileStatus

instance MarshallGLEnum ShaderParameter where
    toGLEnum ShaderType    = 0x8B4F
    toGLEnum DeleteStatus' = 0x8B80
    toGLEnum CompileStatus = 0x8B81

    fromGLEnum 0x8B4F = ShaderType
    fromGLEnum 0x8B80 = DeleteStatus'
    fromGLEnum 0x8B81 = CompileStatus

instance MarshallToJType ShaderParameter where
    toJType ShaderType    = JEnum ShaderType fromGLEnum toGLEnum
    toJType DeleteStatus' = JBool
    toJType CompileStatus = JBool

----------------------------------------------------------------------

getShaderParameter : Context -> Shader -> (pname : ShaderParameter) -> IO (interpJType (toJType pname))
getShaderParameter (MkContext context) (MkShader shader) pname =
    map (unpackType (toJType pname)) $ mkForeign
    (FFun "%0.getShaderParameter(%1, %2)"
    [FPtr, FPtr, FEnum] (toFType (toJType pname)))
    context shader (toGLEnum pname)

----------------------------------------------------------------------

compileShader : Context -> Shader -> IO ()
compileShader (MkContext context) (MkShader shader) = mkForeign
    (FFun "%0.compileShader(%1)"
    [FPtr, FPtr] FUnit)
    context shader

----------------------------------------------------------------------

createShader : Context -> ShaderType -> IO Shader
createShader (MkContext context) typ = map MkShader $ mkForeign
    (FFun "%0.createShader(%1)"
    [FPtr, FEnum] FPtr)
    context (toGLEnum typ)

----------------------------------------------------------------------

deleteShader : Context -> Shader -> IO ()
deleteShader (MkContext context) (MkShader shader) = mkForeign
    (FFun "%0.deleteShader(%1)"
    [FPtr, FPtr] FUnit)
    context shader

----------------------------------------------------------------------

getShaderInfoLog : Context -> Shader -> IO String
getShaderInfoLog (MkContext context) (MkShader shader) = mkForeign
    (FFun "%0.getShaderInfoLog(%1)"
    [FPtr, FPtr] FString)
    context shader

----------------------------------------------------------------------

getShaderSource : Context -> Shader -> IO String
getShaderSource (MkContext context) (MkShader shader) = mkForeign
    (FFun "%0.getShaderSource(%1)"
    [FPtr, FPtr] FString)
    context shader

----------------------------------------------------------------------

isShader : Context -> Shader -> IO Bool
isShader (MkContext context) (MkShader shader) = map fromGLBool $ mkForeign
    (FFun "%0.isShader(%1)"
    [FPtr, FPtr] FBool)
    context shader

----------------------------------------------------------------------

shaderSource : Context -> Shader -> String -> IO ()
shaderSource (MkContext context) (MkShader shader) source = mkForeign
    (FFun "%0.shaderSource(%1, %2)"
    [FPtr, FPtr, FString] FUnit)
    context shader source

----------------------------------------------------------------------
