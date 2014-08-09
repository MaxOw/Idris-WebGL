module Graphics.WebGL.Shaders.Attribs

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType

----------------------------------------------------------------------

data VertexAttribParameter
   = VertexAttribArrayBufferBinding
   | VertexAttribArrayEnabled
   | VertexAttribArraySize
   | VertexAttribArrayStride
   | VertexAttribArrayType
   | VertexAttribArrayNormalized
   | CurrentVertexAttrib

instance MarshallGLEnum VertexAttribParameter where
    toGLEnum VertexAttribArrayBufferBinding  = 0x889F
    toGLEnum VertexAttribArrayEnabled        = 0x8622
    toGLEnum VertexAttribArraySize           = 0x8623
    toGLEnum VertexAttribArrayStride         = 0x8624
    toGLEnum VertexAttribArrayType           = 0x8625
    toGLEnum VertexAttribArrayNormalized     = 0x886A
    toGLEnum CurrentVertexAttrib             = 0x8626

    fromGLEnum 0x889F = VertexAttribArrayBufferBinding
    fromGLEnum 0x8622 = VertexAttribArrayEnabled
    fromGLEnum 0x8623 = VertexAttribArraySize
    fromGLEnum 0x8624 = VertexAttribArrayStride
    fromGLEnum 0x8625 = VertexAttribArrayType
    fromGLEnum 0x886A = VertexAttribArrayNormalized
    fromGLEnum 0x8626 = CurrentVertexAttrib

instance MarshallToJType VertexAttribParameter where
    toJType VertexAttribArrayBufferBinding  = JBuffer
    toJType VertexAttribArrayEnabled        = JBool
    toJType VertexAttribArraySize           = JInt
    toJType VertexAttribArrayStride         = JInt
    toJType VertexAttribArrayType           = JInt -- JEnum t
    toJType VertexAttribArrayNormalized     = JBool
    toJType CurrentVertexAttrib             = JFloat32Array

----------------------------------------------------------------------

getVertexAttrib : Context -> Int -> (pname : VertexAttribParameter) -> IO (interpJType (toJType pname))
getVertexAttrib (MkContext context) index pname =
    map (unpackType (toJType pname)) $ mkForeign
    (FFun "%0.getVertexAttrib(%1, %2)"
    [FPtr, FInt, FEnum] (toFType (toJType pname)))
    context index (toGLEnum pname)

----------------------------------------------------------------------

disableVertexAttribArray : Context -> Int -> IO ()
disableVertexAttribArray (MkContext context) index = mkForeign
    (FFun "%0.disableVertexAttribArray(%1)"
    [FPtr, FInt] FUnit)
    context index

----------------------------------------------------------------------

enableVertexAttribArray : Context -> Int -> IO ()
enableVertexAttribArray (MkContext context) index = mkForeign
    (FFun "%0.enableVertexAttribArray(%1)"
    [FPtr, FInt] FUnit)
    context index

----------------------------------------------------------------------

getActiveAttrib : Context -> Program -> Int -> IO ActiveInfo
getActiveAttrib (MkContext context) (MkProgram program) index = map MkActiveInfo $ mkForeign
    (FFun "%0.getActiveAttrib(%1, %2)"
    [FPtr, FPtr, FInt] FPtr)
    context program index

----------------------------------------------------------------------

bindAttribLocation : Context -> Program -> Int -> String -> IO ()
bindAttribLocation (MkContext context) (MkProgram program) index name = mkForeign
    (FFun "%0.bindAttribLocation(%1, %2, %3)"
    [FPtr, FPtr, FInt, FString] FUnit)
    context program index name

----------------------------------------------------------------------

getAttribLocation : Context -> Program -> String -> IO Int
getAttribLocation (MkContext context) (MkProgram program) name = mkForeign
    (FFun "%0.getAttribLocation(%1, %2)"
    [FPtr, FPtr, FString] FInt)
    context program name

----------------------------------------------------------------------

{-
setVertexPosAttrib : Program -> Int -> IO ()
setVertexPosAttrib (MkProgram program) loc = mkForeign
    (FFun "%0.getVertexPosAttrib = %1"
    [FPtr, FInt] FUnit)
    program loc
-}

----------------------------------------------------------------------

data VertexAttribType
   = AttribByte
   | AttribUnsignedByte
   | AttribShort
   | AttribUnsignedShort
   | AttribFixed
   | AttribFloat

instance MarshallGLEnum VertexAttribType where
    toGLEnum AttribByte                           = 0x1400
    toGLEnum AttribUnsignedByte                   = 0x1401
    toGLEnum AttribShort                          = 0x1402
    toGLEnum AttribUnsignedShort                  = 0x1403

    toGLEnum AttribFloat                          = 0x1406

    fromGLEnum 0x1400 = AttribByte
    fromGLEnum 0x1401 = AttribUnsignedByte
    fromGLEnum 0x1402 = AttribShort
    fromGLEnum 0x1403 = AttribUnsignedShort

    fromGLEnum 0x1406 = AttribFloat

vertexAttribPointer : Context -> Int -> Int -> VertexAttribType -> Bool -> Int -> Int -> IO ()
vertexAttribPointer (MkContext context) indx size type normalized stride offset = mkForeign
    (FFun "%0.vertexAttribPointer(%1, %2, %3, %4, %5, %6)"
    [FPtr, FInt, FInt, FEnum, FBool, FInt, FInt] FUnit)
    context indx size (toGLEnum type) (toGLBool normalized) stride offset

----------------------------------------------------------------------

{-
getVertexAttribOffset : Context -> Int -> GLEnum#pname -> IO Int
getVertexAttribOffset (MkContext context) index pname = mkForeign
    (FFun "%0.getVertexAttribOffset(%1, %2)"
    [FPtr, FInt, FEnum] FInt)
    context index (toGLEnum pname)

----------------------------------------------------------------------

vertexAttrib1f : Context -> Int -> Float -> IO ()
vertexAttrib1f (MkContext context) indx x = mkForeign
    (FFun "%0.vertexAttrib1f(%1, %2)"
    [FPtr, FInt, FFloat] FUnit)
    context indx x

----------------------------------------------------------------------

vertexAttrib1fv : Context -> Int -> JSArray Float -> IO ()
vertexAttrib1fv (MkContext context) indx (MkJSArray values) = mkForeign
    (FFun "%0.vertexAttrib1fv(%1, %2)"
    [FPtr, FInt, FPtr] FUnit)
    context indx values

----------------------------------------------------------------------

vertexAttrib2f : Context -> Int -> Float -> Float -> IO ()
vertexAttrib2f (MkContext context) indx x y = mkForeign
    (FFun "%0.vertexAttrib2f(%1, %2, %3)"
    [FPtr, FInt, FFloat, FFloat] FUnit)
    context indx x y

----------------------------------------------------------------------

vertexAttrib2fv : Context -> Int -> JSArray Float -> IO ()
vertexAttrib2fv (MkContext context) indx (MkJSArray values) = mkForeign
    (FFun "%0.vertexAttrib2fv(%1, %2)"
    [FPtr, FInt, FPtr] FUnit)
    context indx values

----------------------------------------------------------------------

vertexAttrib3f : Context -> Int -> Float -> Float -> Float -> IO ()
vertexAttrib3f (MkContext context) indx x y z = mkForeign
    (FFun "%0.vertexAttrib3f(%1, %2, %3, %4)"
    [FPtr, FInt, FFloat, FFloat, FFloat] FUnit)
    context indx x y z

----------------------------------------------------------------------

vertexAttrib3fv : Context -> Int -> JSArray Float -> IO ()
vertexAttrib3fv (MkContext context) indx (MkJSArray values) = mkForeign
    (FFun "%0.vertexAttrib3fv(%1, %2)"
    [FPtr, FInt, FPtr] FUnit)
    context indx values

----------------------------------------------------------------------

vertexAttrib4f : Context -> Int -> Float -> Float -> Float -> Float -> IO ()
vertexAttrib4f (MkContext context) indx x y z w = mkForeign
    (FFun "%0.vertexAttrib4f(%1, %2, %3, %4, %5)"
    [FPtr, FInt, FFloat, FFloat, FFloat, FFloat] FUnit)
    context indx x y z w

----------------------------------------------------------------------

vertexAttrib4fv : Context -> Int -> JSArray Float -> IO ()
vertexAttrib4fv (MkContext context) indx (MkJSArray values) = mkForeign
    (FFun "%0.vertexAttrib4fv(%1, %2)"
    [FPtr, FInt, FPtr] FUnit)
    context indx values

----------------------------------------------------------------------

vertexAttrib1fv : Context -> Int -> Float32Array -> IO ()
vertexAttrib1fv (MkContext context) indx (MkFloat32Array values) = mkForeign
    (FFun "%0.vertexAttrib1fv(%1, %2)"
    [FPtr, FInt, FPtr] FUnit)
    context indx values

----------------------------------------------------------------------

vertexAttrib2fv : Context -> Int -> Float32Array -> IO ()
vertexAttrib2fv (MkContext context) indx (MkFloat32Array values) = mkForeign
    (FFun "%0.vertexAttrib2fv(%1, %2)"
    [FPtr, FInt, FPtr] FUnit)
    context indx values

----------------------------------------------------------------------

vertexAttrib3fv : Context -> Int -> Float32Array -> IO ()
vertexAttrib3fv (MkContext context) indx (MkFloat32Array values) = mkForeign
    (FFun "%0.vertexAttrib3fv(%1, %2)"
    [FPtr, FInt, FPtr] FUnit)
    context indx values

----------------------------------------------------------------------

vertexAttrib4fv : Context -> Int -> Float32Array -> IO ()
vertexAttrib4fv (MkContext context) indx (MkFloat32Array values) = mkForeign
    (FFun "%0.vertexAttrib4fv(%1, %2)"
    [FPtr, FInt, FPtr] FUnit)
    context indx values
-}
