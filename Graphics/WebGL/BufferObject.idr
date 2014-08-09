module Graphics.WebGL.BufferObject

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

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

{-
bufferData : Context -> BufferTarget -> Int -> BufferUsage -> IO ()
bufferData (MkContext context) target size usage = mkForeign
    (FFun "%0.bufferData(%1, %2, %3)"
    [FPtr, FEnum, FInt, FEnum] FUnit)
    context (toGLEnum target) size (toGLEnum usage)

----------------------------------------------------------------------

bufferData : Context -> BufferTarget -> ArrayBufferView -> BufferUsage -> IO ()
bufferData (MkContext context) target (MkArrayBufferView data) usage = mkForeign
    (FFun "%0.bufferData(%1, %2, %3)"
    [FPtr, FEnum, FPtr, FEnum] FUnit)
    context (toGLEnum target) data (toGLEnum usage)
-}
----------------------------------------------------------------------

-- bufferData : Context -> BufferTarget -> ArrayBuffer -> BufferUsage -> IO ()
-- bufferData (MkContext context) target (MkArrayBuffer dat) usage = mkForeign
-- bufferData : Context -> BufferTarget -> JSArray Float -> BufferUsage -> IO ()
-- bufferData (MkContext context) target (MkJSArray dat) usage = mkForeign
bufferData : Context -> BufferTarget -> Float32Array -> BufferUsage -> IO ()
bufferData (MkContext context) target (MkFloat32Array dat) usage = mkForeign
    (FFun "%0.bufferData(%1, %2, %3)"
    [FPtr, FEnum, FPtr, FEnum] FUnit)
    context (toGLEnum target) dat (toGLEnum usage)

{-
----------------------------------------------------------------------

bufferSubData : Context -> BufferTarget -> Int -> ArrayBufferView -> IO ()
bufferSubData (MkContext context) target offset (MkArrayBufferView data) = mkForeign
    (FFun "%0.bufferSubData(%1, %2, %3)"
    [FPtr, FEnum, FInt, FPtr] FUnit)
    context (toGLEnum target) offset data

----------------------------------------------------------------------
-}

bufferSubData : Context -> BufferTarget -> Int -> ArrayBuffer -> IO ()
bufferSubData (MkContext context) target offset (MkArrayBuffer dat) = mkForeign
    (FFun "%0.bufferSubData(%1, %2, %3)"
    [FPtr, FEnum, FInt, FPtr] FUnit)
    context (toGLEnum target) offset dat

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

getBufferParameter : Context -> BufferTarget -> BufferParameter -> IO Int
getBufferParameter (MkContext context) target pname = mkForeign
    (FFun "%0.getBufferParameter(%1, %2)"
    [FPtr, FEnum, FEnum] FInt)
    context (toGLEnum target) (toGLEnum pname)

----------------------------------------------------------------------

isBuffer : Context -> Buffer -> IO Bool
isBuffer (MkContext context) (MkBuffer buffer) = map fromGLBool $ mkForeign
    (FFun "%0.isBuffer(%1)"
    [FPtr, FPtr] FBool)
    context buffer

----------------------------------------------------------------------

