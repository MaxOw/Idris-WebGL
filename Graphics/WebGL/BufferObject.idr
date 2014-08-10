module Graphics.WebGL.BufferObject

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType

----------------------------------------------------------------------

data BufferTarget
   = ArrayBufferTarget
   | ElementArrayBufferTarget
instance MarshallGLEnum BufferTarget where
    toGLEnum ArrayBufferTarget              = 0x8892
    toGLEnum ElementArrayBufferTarget       = 0x8893
    fromGLEnum 0x8892 = ArrayBufferTarget
    fromGLEnum 0x8893 = ElementArrayBufferTarget

----------------------------------------------------------------------

data BufferUsage
   = StreamDraw
   | StaticDraw
   | DynamicDraw

instance MarshallGLEnum BufferUsage where
    toGLEnum StreamDraw                     = 0x88E0
    toGLEnum StaticDraw                     = 0x88E4
    toGLEnum DynamicDraw                    = 0x88E8

    fromGLEnum 0x88E0 = StreamDraw
    fromGLEnum 0x88E4 = StaticDraw
    fromGLEnum 0x88E8 = DynamicDraw

----------------------------------------------------------------------

bindBuffer : Context -> BufferTarget -> Buffer -> IO ()
bindBuffer (MkContext context) target (MkBuffer buffer) = mkForeign
    (FFun "%0.bindBuffer(%1, %2)"
    [FPtr, FEnum, FPtr] FUnit)
    context (toGLEnum target) buffer

----------------------------------------------------------------------

bufferDataSize : Context -> BufferTarget -> Int -> BufferUsage -> IO ()
bufferDataSize (MkContext context) target size usage = mkForeign
    (FFun "%0.bufferData(%1, %2, %3)"
    [FPtr, FEnum, FInt, FEnum] FUnit)
    context (toGLEnum target) size (toGLEnum usage)

----------------------------------------------------------------------

class ArrayBufferData a where
    unpackToPtr : a -> Ptr
instance ArrayBufferData ArrayBuffer where
    unpackToPtr (MkArrayBuffer dat) = dat
instance ArrayBufferData ArrayBufferView where
    unpackToPtr (MkArrayBufferView dat) = dat
instance ArrayBufferData Float32Array where
    unpackToPtr (MkFloat32Array dat) = dat

bufferData : ArrayBufferData a => Context -> BufferTarget -> a -> BufferUsage -> IO ()
bufferData (MkContext context) target dat usage = mkForeign
    (FFun "%0.bufferData(%1, %2, %3)"
    [FPtr, FEnum, FPtr, FEnum] FUnit)
    context (toGLEnum target) (unpackToPtr dat) (toGLEnum usage)

----------------------------------------------------------------------

bufferSubData : ArrayBufferData a => Context -> BufferTarget -> Int -> a -> IO ()
bufferSubData (MkContext context) target offset dat = mkForeign
    (FFun "%0.bufferSubData(%1, %2, %3)"
    [FPtr, FEnum, FInt, FPtr] FUnit)
    context (toGLEnum target) offset (unpackToPtr dat)

----------------------------------------------------------------------

createBuffer : Context -> IO Buffer
createBuffer (MkContext context) = map MkBuffer $ mkForeign
    (FFun "%0.createBuffer()"
    [FPtr] FPtr)
    context

----------------------------------------------------------------------

deleteBuffer : Context -> Buffer -> IO ()
deleteBuffer (MkContext context) (MkBuffer buffer) = mkForeign
    (FFun "%0.deleteBuffer(%1)"
    [FPtr, FPtr] FUnit)
    context buffer

----------------------------------------------------------------------

data BufferParameter
   = BufferSize
   | BufferUsage'

instance MarshallGLEnum BufferParameter where
    toGLEnum BufferSize                     = 0x8764
    toGLEnum BufferUsage'                   = 0x8765

    fromGLEnum 0x8764 = BufferSize
    fromGLEnum 0x8765 = BufferUsage'

instance MarshallToJType BufferParameter where
    toJType BufferSize   = JInt
    toJType BufferUsage' = JEnum BufferUsage fromGLEnum

getBufferParameter : Context -> BufferTarget -> (pname : BufferParameter) -> IO (interpJType (toJType pname))
getBufferParameter (MkContext context) target pname = 
    map (unpackType (toJType pname)) $ mkForeign
    (FFun "%0.getBufferParameter(%1, %2)"
    [FPtr, FEnum, FEnum] (toFType (toJType pname)))
    context (toGLEnum target) (toGLEnum pname)

----------------------------------------------------------------------

isBuffer : Context -> Buffer -> IO Bool
isBuffer (MkContext context) (MkBuffer buffer) = map fromGLBool $ mkForeign
    (FFun "%0.isBuffer(%1)"
    [FPtr, FPtr] FBool)
    context buffer

----------------------------------------------------------------------

