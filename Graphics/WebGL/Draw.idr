module Graphics.WebGL.Draw

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

----------------------------------------------------------------------

public
data PolygonMode
   = Points
   | LineStrip
   | LineLoop
   | Lines
   | TriangleStrip
   | TriangleFan
   | Triangles

instance MarshallGLEnum PolygonMode where
    toGLEnum Points                         = 0x0000
    toGLEnum Lines                          = 0x0001
    toGLEnum LineLoop                       = 0x0002
    toGLEnum LineStrip                      = 0x0003
    toGLEnum Triangles                      = 0x0004
    toGLEnum TriangleStrip                  = 0x0005
    toGLEnum TriangleFan                    = 0x0006

    fromGLEnum 0x0000 = Just Points
    fromGLEnum 0x0001 = Just Lines
    fromGLEnum 0x0002 = Just LineLoop
    fromGLEnum 0x0003 = Just LineStrip
    fromGLEnum 0x0004 = Just Triangles
    fromGLEnum 0x0005 = Just TriangleStrip
    fromGLEnum 0x0006 = Just TriangleFan
    fromGLEnum _      = Nothing

----------------------------------------------------------------------

public
drawArrays : Context -> PolygonMode -> Int -> Int -> IO ()
drawArrays (MkContext context) mode first count = mkForeign
    (FFun "%0.drawArrays(%1, %2, %3)"
    [FPtr, FEnum, FInt, FInt] FUnit)
    context (toGLEnum mode) first count

----------------------------------------------------------------------

public
data IndicesType
   = UnsignedByte
   | UnsignedShort
instance MarshallGLEnum IndicesType where
    toGLEnum UnsignedByte                   = 0x1401
    toGLEnum UnsignedShort                  = 0x1403

    fromGLEnum 0x1401 = Just UnsignedByte
    fromGLEnum 0x1403 = Just UnsignedShort
    fromGLEnum _      = Nothing

public
drawElements : Context -> PolygonMode -> Int -> IndicesType -> Int -> IO ()
drawElements (MkContext context) mode count type offset = mkForeign
    (FFun "%0.drawElements(%1, %2, %3, %4)"
    [FPtr, FEnum, FInt, FEnum, FInt] FUnit)
    context (toGLEnum mode) count (toGLEnum type) offset

----------------------------------------------------------------------
