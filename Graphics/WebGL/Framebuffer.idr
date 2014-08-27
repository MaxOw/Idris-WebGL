module Graphics.WebGL.Framebuffer

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

-- Whole Framebuffer Operations (section 5.13.3)
-- https://www.khronos.org/registry/webgl/specs/1.0.0/#5.13.3

----------------------------------------------------------------------

public
data BufferBit
   = DepthBuffer
   | StencilBuffer
   | ColorBuffer

public
bitToInt : BufferBit -> Int
bitToInt DepthBuffer   = 0x00000100
bitToInt StencilBuffer = 0x00000400
bitToInt ColorBuffer   = 0x00004000

instance MarshallGLEnum (List BufferBit) where
    toGLEnum = foldl (.|.) 0 . map bitToInt
    fromGLEnum n = Just $ filter (\a => n .&. bitToInt a /= 0)
                 [ DepthBuffer, StencilBuffer, ColorBuffer ]

public
clear : Context -> List BufferBit -> IO ()
clear (MkContext context) bs = mkForeign
    (FFun "%0.clear(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum bs)

----------------------------------------------------------------------

public
clearColor : Context -> Float -> Float -> Float -> Float -> IO ()
clearColor (MkContext context) red green blue alpha = mkForeign
    (FFun "%0.clearColor(%1, %2, %3, %4)"
    [FPtr, FFloat, FFloat, FFloat, FFloat] FUnit)
    context red green blue alpha

----------------------------------------------------------------------

public
clearDepth : Context -> Float -> IO ()
clearDepth (MkContext context) depth = mkForeign
    (FFun "%0.clearDepth(%1)"
    [FPtr, FFloat] FUnit)
    context depth

----------------------------------------------------------------------

public
clearStencil : Context -> Int -> IO ()
clearStencil (MkContext context) s = mkForeign
    (FFun "%0.clearStencil(%1)"
    [FPtr, FInt] FUnit)
    context s

----------------------------------------------------------------------

public
colorMask : Context -> Bool -> Bool -> Bool -> Bool -> IO ()
colorMask (MkContext context) red green blue alpha = mkForeign
    (FFun "%0.colorMask(%1, %2, %3, %4)"
    [FPtr, FBool, FBool, FBool, FBool] FUnit)
    context (toGLBool red) (toGLBool green) (toGLBool blue) (toGLBool alpha)

----------------------------------------------------------------------

public
depthMask : Context -> Bool -> IO ()
depthMask (MkContext context) flag = mkForeign
    (FFun "%0.depthMask(%1)"
    [FPtr, FBool] FUnit)
    context (toGLBool flag)

----------------------------------------------------------------------

public
stencilMask : Context -> Int -> IO ()
stencilMask (MkContext context) mask = mkForeign
    (FFun "%0.stencilMask(%1)"
    [FPtr, FInt] FUnit)
    context mask

----------------------------------------------------------------------

public
stencilMaskSeparate : Context -> Face -> Int -> IO ()
stencilMaskSeparate (MkContext context) face mask = mkForeign
    (FFun "%0.stencilMaskSeparate(%1, %2)"
    [FPtr, FEnum, FInt] FUnit)
    context (toGLEnum face) mask

----------------------------------------------------------------------

