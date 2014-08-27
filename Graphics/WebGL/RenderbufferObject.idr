module Graphics.WebGL.RenderbufferObject

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType

----------------------------------------------------------------------

public
data RenderbufferParameter
   = RenderbufferWidth
   | RenderbufferHeight
   | RenderbufferInternalFormat
   | RenderbufferRedSize
   | RenderbufferGreenSize
   | RenderbufferBlueSize
   | RenderbufferAlphaSize
   | RenderbufferDepthSize
   | RenderbufferStencilSize

instance MarshallGLEnum RenderbufferParameter where
    toGLEnum RenderbufferWidth               = 0x8D42
    toGLEnum RenderbufferHeight              = 0x8D43
    toGLEnum RenderbufferInternalFormat      = 0x8D44
    toGLEnum RenderbufferRedSize             = 0x8D50
    toGLEnum RenderbufferGreenSize           = 0x8D51
    toGLEnum RenderbufferBlueSize            = 0x8D52
    toGLEnum RenderbufferAlphaSize           = 0x8D53
    toGLEnum RenderbufferDepthSize           = 0x8D54
    toGLEnum RenderbufferStencilSize         = 0x8D55

    fromGLEnum 0x8D42 = Just RenderbufferWidth
    fromGLEnum 0x8D43 = Just RenderbufferHeight
    fromGLEnum 0x8D44 = Just RenderbufferInternalFormat
    fromGLEnum 0x8D50 = Just RenderbufferRedSize
    fromGLEnum 0x8D51 = Just RenderbufferGreenSize
    fromGLEnum 0x8D52 = Just RenderbufferBlueSize
    fromGLEnum 0x8D53 = Just RenderbufferAlphaSize
    fromGLEnum 0x8D54 = Just RenderbufferDepthSize
    fromGLEnum 0x8D55 = Just RenderbufferStencilSize
    fromGLEnum _      = Nothing

instance MarshallToJType RenderbufferParameter where
    toJType RenderbufferWidth               = JInt
    toJType RenderbufferHeight              = JInt
    toJType RenderbufferInternalFormat      = JEnum PixelFormat fromGLEnum toGLEnum
    toJType RenderbufferRedSize             = JInt
    toJType RenderbufferGreenSize           = JInt
    toJType RenderbufferBlueSize            = JInt
    toJType RenderbufferAlphaSize           = JInt
    toJType RenderbufferDepthSize           = JInt
    toJType RenderbufferStencilSize         = JInt

----------------------------------------------------------------------

public
getRenderbufferParameter : Context -> RenderbufferTarget -> (pname : RenderbufferParameter) -> IO (interpJRetType (toJType pname))
getRenderbufferParameter (MkContext context) target pname =
    map (unpackType pname) $ mkForeign
    (FFun "%0.getRenderbufferParameter(%1, %2)"
    [FPtr, FEnum, FEnum] (JTypeToFType pname))
    context (toGLEnum target) (toGLEnum pname)

----------------------------------------------------------------------

public
bindRenderbuffer : Context -> RenderbufferTarget -> Renderbuffer -> IO ()
bindRenderbuffer (MkContext context) target (MkRenderbuffer renderbuffer) = mkForeign
    (FFun "%0.bindRenderbuffer(%1, %2)"
    [FPtr, FEnum, FPtr] FUnit)
    context (toGLEnum target) renderbuffer

----------------------------------------------------------------------

public
createRenderbuffer : Context -> IO Renderbuffer
createRenderbuffer (MkContext context) = map MkRenderbuffer $ mkForeign
    (FFun "%0.createRenderbuffer()"
    [FPtr] FPtr)
    context

----------------------------------------------------------------------

public
deleteRenderbuffer : Context -> Renderbuffer -> IO ()
deleteRenderbuffer (MkContext context) (MkRenderbuffer renderbuffer) = mkForeign
    (FFun "%0.deleteRenderbuffer(%1)"
    [FPtr, FPtr] FUnit)
    context renderbuffer

----------------------------------------------------------------------

public
isRenderbuffer : Context -> Renderbuffer -> IO Bool
isRenderbuffer (MkContext context) (MkRenderbuffer renderbuffer) = map fromGLBool $ mkForeign
    (FFun "%0.isRenderbuffer(%1)"
    [FPtr, FPtr] FBool)
    context renderbuffer

----------------------------------------------------------------------

public
data StorageFormat
   = StorageFormatRGBA4
   | StorageFormatRGB5A1
   | StorageFormatRGB565
   | StorageFormatDepthComponent16
   | StorageFormatStencilIndex8

instance MarshallGLEnum StorageFormat where
    toGLEnum StorageFormatRGBA4                          = 0x8056
    toGLEnum StorageFormatRGB5A1                         = 0x8057
    toGLEnum StorageFormatRGB565                         = 0x8D62
    toGLEnum StorageFormatDepthComponent16               = 0x81A5
    toGLEnum StorageFormatStencilIndex8                  = 0x8D48

    fromGLEnum 0x8056 = Just StorageFormatRGBA4
    fromGLEnum 0x8057 = Just StorageFormatRGB5A1
    fromGLEnum 0x8D62 = Just StorageFormatRGB565
    fromGLEnum 0x81A5 = Just StorageFormatDepthComponent16
    fromGLEnum 0x8D48 = Just StorageFormatStencilIndex8
    fromGLEnum _      = Nothing

public
renderbufferStorage : Context -> RenderbufferTarget -> StorageFormat -> Int -> Int -> IO ()
renderbufferStorage (MkContext context) target internalformat width height = mkForeign
    (FFun "%0.renderbufferStorage(%1, %2, %3, %4)"
    [FPtr, FEnum, FEnum, FInt, FInt] FUnit)
    context (toGLEnum target) (toGLEnum internalformat) width height

----------------------------------------------------------------------
