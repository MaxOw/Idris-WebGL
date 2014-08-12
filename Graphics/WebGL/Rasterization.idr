module Graphics.WebGL.Rasterization

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

----------------------------------------------------------------------

public
cullFace : Context -> Face -> IO ()
cullFace (MkContext context) mode = mkForeign
    (FFun "%0.cullFace(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum mode)

----------------------------------------------------------------------

public
data FrontFaceMode
   = ClockWise
   | CounterClockWise

instance MarshallGLEnum FrontFaceMode where
    toGLEnum ClockWise                      = 0x0900
    toGLEnum CounterClockWise               = 0x0901

    fromGLEnum 0x0900 = ClockWise
    fromGLEnum 0x0901 = CounterClockWise

public
frontFace : Context -> FrontFaceMode -> IO ()
frontFace (MkContext context) mode = mkForeign
    (FFun "%0.frontFace(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum mode)

----------------------------------------------------------------------

public
lineWidth : Context -> Float -> IO ()
lineWidth (MkContext context) width = mkForeign
    (FFun "%0.lineWidth(%1)"
    [FPtr, FFloat] FUnit)
    context width

----------------------------------------------------------------------

public
polygonOffset : Context -> Float -> Float -> IO ()
polygonOffset (MkContext context) factor units = mkForeign
    (FFun "%0.polygonOffset(%1, %2)"
    [FPtr, FFloat, FFloat] FUnit)
    context factor units
