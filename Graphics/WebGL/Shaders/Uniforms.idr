module Graphics.WebGL.Shaders.Shader

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType

----------------------------------------------------------------------

getActiveUniform : Context -> Program -> Int -> IO ActiveInfo
getActiveUniform (MkContext context) (MkProgram program) index = map MkActiveInfo $ mkForeign
    (FFun "%0.getActiveUniform(%1, %2)"
    [FPtr, FPtr, FInt] FPtr)
    context program index

----------------------------------------------------------------------

getUniformLocation : Context -> Program -> String -> IO UniformLocation
getUniformLocation (MkContext context) (MkProgram program) name = map MkUniformLocation $ mkForeign
    (FFun "%0.getUniformLocation(%1, %2)"
    [FPtr, FPtr, FString] FPtr)
    context program name

----------------------------------------------------------------------

{-

-- This should be done something like this

class UniformType a where
    uniform : Context -> UniformLocation -> a -> IO ()
    getUniform : Context -> UniformLocation -> IO (Maybe a)

instance UniformType (Vec 1 Float) where
instance UniformType (Vec 2 Float) where
instance UniformType (Vec 3 Float) where
instance UniformType (Vec 4 Float) where

instance UniformType (List (Vec 1 Float)) where
instance UniformType (List (Vec 2 Float)) where
instance UniformType (List (Vec 3 Float)) where
instance UniformType (List (Vec 4 Float)) where

instance UniformType (Vec 1 Int) where
instance UniformType (Vec 2 Int) where
instance UniformType (Vec 3 Int) where
instance UniformType (Vec 4 Int) where

instance UniformType (List (Vec 1 Int)) where
instance UniformType (List (Vec 2 Int)) where
instance UniformType (List (Vec 3 Int)) where
instance UniformType (List (Vec 4 Int)) where

instance UniformType (Mat 2 2 Float) where
instance UniformType (Mat 3 3 Float) where
instance UniformType (Mat 4 4 Float) where
-}

----------------------------------------------------------------------

{-
getUniform : Context -> Program -> UniformLocation -> IO (interpJType (toJType pname))
getUniform (MkContext context) (MkProgram program) (MkUniformLocation location) = map (unpackType (toJType pname)) $ mkForeign
    (FFun "%0.getUniform(%1, %2)"
    [FPtr, FPtr, FPtr] (toFType (toJType pname)))
    context program location
-}

----------------------------------------------------------------------

uniform1f : Context -> UniformLocation -> Float -> IO ()
uniform1f (MkContext context) (MkUniformLocation location) x = mkForeign
    (FFun "%0.uniform1f(%1, %2)"
    [FPtr, FPtr, FFloat] FUnit)
    context location x

----------------------------------------------------------------------

uniform1fv : Context -> UniformLocation -> JSArray Float -> IO ()
uniform1fv (MkContext context) (MkUniformLocation location) (MkJSArray v) = mkForeign
    (FFun "%0.uniform1fv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

uniform1fva : Context -> UniformLocation -> Float32Array -> IO ()
uniform1fva (MkContext context) (MkUniformLocation location) (MkFloat32Array v) = mkForeign
    (FFun "%0.uniform1fv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

----------------------------------------------------------------------

uniform1i : Context -> UniformLocation -> Int -> IO ()
uniform1i (MkContext context) (MkUniformLocation location) x = mkForeign
    (FFun "%0.uniform1i(%1, %2)"
    [FPtr, FPtr, FInt] FUnit)
    context location x

----------------------------------------------------------------------

uniform1iv : Context -> UniformLocation -> JSArray Int -> IO ()
uniform1iv (MkContext context) (MkUniformLocation location) (MkJSArray v) = mkForeign
    (FFun "%0.uniform1iv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

uniform1iva : Context -> UniformLocation -> Int32Array -> IO ()
uniform1iva (MkContext context) (MkUniformLocation location) (MkInt32Array v) = mkForeign
    (FFun "%0.uniform1iv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

----------------------------------------------------------------------

uniform2f : Context -> UniformLocation -> Float -> Float -> IO ()
uniform2f (MkContext context) (MkUniformLocation location) x y = mkForeign
    (FFun "%0.uniform2f(%1, %2, %3)"
    [FPtr, FPtr, FFloat, FFloat] FUnit)
    context location x y

----------------------------------------------------------------------

uniform2fv : Context -> UniformLocation -> JSArray Float -> IO ()
uniform2fv (MkContext context) (MkUniformLocation location) (MkJSArray v) = mkForeign
    (FFun "%0.uniform2fv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

uniform2fva : Context -> UniformLocation -> Float32Array -> IO ()
uniform2fva (MkContext context) (MkUniformLocation location) (MkFloat32Array v) = mkForeign
    (FFun "%0.uniform2fv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

----------------------------------------------------------------------

uniform2i : Context -> UniformLocation -> Int -> Int -> IO ()
uniform2i (MkContext context) (MkUniformLocation location) x y = mkForeign
    (FFun "%0.uniform2i(%1, %2, %3)"
    [FPtr, FPtr, FInt, FInt] FUnit)
    context location x y

----------------------------------------------------------------------

uniform2iv : Context -> UniformLocation -> JSArray Int -> IO ()
uniform2iv (MkContext context) (MkUniformLocation location) (MkJSArray v) = mkForeign
    (FFun "%0.uniform2iv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

uniform2iva : Context -> UniformLocation -> Int32Array -> IO ()
uniform2iva (MkContext context) (MkUniformLocation location) (MkInt32Array v) = mkForeign
    (FFun "%0.uniform2iv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

----------------------------------------------------------------------

uniform3f : Context -> UniformLocation -> Float -> Float -> Float -> IO ()
uniform3f (MkContext context) (MkUniformLocation location) x y z = mkForeign
    (FFun "%0.uniform3f(%1, %2, %3, %4)"
    [FPtr, FPtr, FFloat, FFloat, FFloat] FUnit)
    context location x y z

----------------------------------------------------------------------

uniform3fv : Context -> UniformLocation -> JSArray Float -> IO ()
uniform3fv (MkContext context) (MkUniformLocation location) (MkJSArray v) = mkForeign
    (FFun "%0.uniform3fv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

uniform3fva : Context -> UniformLocation -> Float32Array -> IO ()
uniform3fva (MkContext context) (MkUniformLocation location) (MkFloat32Array v) = mkForeign
    (FFun "%0.uniform3fv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

----------------------------------------------------------------------

uniform3i : Context -> UniformLocation -> Int -> Int -> Int -> IO ()
uniform3i (MkContext context) (MkUniformLocation location) x y z = mkForeign
    (FFun "%0.uniform3i(%1, %2, %3, %4)"
    [FPtr, FPtr, FInt, FInt, FInt] FUnit)
    context location x y z

----------------------------------------------------------------------

uniform3iv : Context -> UniformLocation -> JSArray Int -> IO ()
uniform3iv (MkContext context) (MkUniformLocation location) (MkJSArray v) = mkForeign
    (FFun "%0.uniform3iv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

uniform3iva : Context -> UniformLocation -> Int32Array -> IO ()
uniform3iva (MkContext context) (MkUniformLocation location) (MkInt32Array v) = mkForeign
    (FFun "%0.uniform3iv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

----------------------------------------------------------------------

uniform4f : Context -> UniformLocation -> Float -> Float -> Float -> Float -> IO ()
uniform4f (MkContext context) (MkUniformLocation location) x y z w = mkForeign
    (FFun "%0.uniform4f(%1, %2, %3, %4, %5)"
    [FPtr, FPtr, FFloat, FFloat, FFloat, FFloat] FUnit)
    context location x y z w

----------------------------------------------------------------------

uniform4fv : Context -> UniformLocation -> JSArray Float -> IO ()
uniform4fv (MkContext context) (MkUniformLocation location) (MkJSArray v) = mkForeign
    (FFun "%0.uniform4fv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

uniform4fva : Context -> UniformLocation -> Float32Array -> IO ()
uniform4fva (MkContext context) (MkUniformLocation location) (MkFloat32Array v) = mkForeign
    (FFun "%0.uniform4fv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

----------------------------------------------------------------------

uniform4i : Context -> UniformLocation -> Int -> Int -> Int -> Int -> IO ()
uniform4i (MkContext context) (MkUniformLocation location) x y z w = mkForeign
    (FFun "%0.uniform4i(%1, %2, %3, %4, %5)"
    [FPtr, FPtr, FInt, FInt, FInt, FInt] FUnit)
    context location x y z w

----------------------------------------------------------------------

uniform4iv : Context -> UniformLocation -> JSArray Int -> IO ()
uniform4iv (MkContext context) (MkUniformLocation location) (MkJSArray v) = mkForeign
    (FFun "%0.uniform4iv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

uniform4iva : Context -> UniformLocation -> Int32Array -> IO ()
uniform4iva (MkContext context) (MkUniformLocation location) (MkInt32Array v) = mkForeign
    (FFun "%0.uniform4iv(%1, %2)"
    [FPtr, FPtr, FPtr] FUnit)
    context location v

----------------------------------------------------------------------

uniformMatrix2fv : Context -> UniformLocation -> Bool -> JSArray Float -> IO ()
uniformMatrix2fv (MkContext context) (MkUniformLocation location) transpose (MkJSArray value) = mkForeign
    (FFun "%0.uniformMatrix2fv(%1, %2, %3)"
    [FPtr, FPtr, FBool, FPtr] FUnit)
    context location (toGLBool transpose) value

uniformMatrix2fva : Context -> UniformLocation -> Bool -> Float32Array -> IO ()
uniformMatrix2fva (MkContext context) (MkUniformLocation location) transpose (MkFloat32Array value) = mkForeign
    (FFun "%0.uniformMatrix2fv(%1, %2, %3)"
    [FPtr, FPtr, FBool, FPtr] FUnit)
    context location (toGLBool transpose) value

----------------------------------------------------------------------

uniformMatrix3fv : Context -> UniformLocation -> Bool -> JSArray Float -> IO ()
uniformMatrix3fv (MkContext context) (MkUniformLocation location) transpose (MkJSArray value) = mkForeign
    (FFun "%0.uniformMatrix3fv(%1, %2, %3)"
    [FPtr, FPtr, FBool, FPtr] FUnit)
    context location (toGLBool transpose) value

uniformMatrix3fva : Context -> UniformLocation -> Bool -> Float32Array -> IO ()
uniformMatrix3fva (MkContext context) (MkUniformLocation location) transpose (MkFloat32Array value) = mkForeign
    (FFun "%0.uniformMatrix3fv(%1, %2, %3)"
    [FPtr, FPtr, FBool, FPtr] FUnit)
    context location (toGLBool transpose) value

----------------------------------------------------------------------

uniformMatrix4fv : Context -> UniformLocation -> Bool -> JSArray Float -> IO ()
uniformMatrix4fv (MkContext context) (MkUniformLocation location) transpose (MkJSArray value) = mkForeign
    (FFun "%0.uniformMatrix4fv(%1, %2, %3)"
    [FPtr, FPtr, FBool, FPtr] FUnit)
    context location (toGLBool transpose) value

uniformMatrix4fva : Context -> UniformLocation -> Bool -> Float32Array -> IO ()
uniformMatrix4fva (MkContext context) (MkUniformLocation location) transpose (MkFloat32Array value) = mkForeign
    (FFun "%0.uniformMatrix4fv(%1, %2, %3)"
    [FPtr, FPtr, FBool, FPtr] FUnit)
    context location (toGLBool transpose) value
