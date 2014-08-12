module Graphics.WebGL.ViewClip

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

----------------------------------------------------------------------

public
depthRange : Context -> Float -> Float -> IO ()
depthRange (MkContext context) zNear zFar = mkForeign
    (FFun "%0.depthRange(%1, %2)"
    [FPtr, FFloat, FFloat] FUnit)
    context zNear zFar

----------------------------------------------------------------------

public
scissor : Context -> Int -> Int -> Int -> Int -> IO ()
scissor (MkContext context) x y width height = mkForeign
    (FFun "%0.scissor(%1, %2, %3, %4)"
    [FPtr, FInt, FInt, FInt, FInt] FUnit)
    context x y width height

----------------------------------------------------------------------

public
viewport : Context -> Int -> Int -> Int -> Int -> IO ()
viewport (MkContext context) x y width height = mkForeign
    (FFun "%0.viewport(%1, %2, %3, %4)"
    [FPtr, FInt, FInt, FInt, FInt] FUnit)
    context x y width height

