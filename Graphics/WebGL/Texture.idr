module Graphics.WebGL.Texture

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType

----------------------------------------------------------------------

public
data TextureUnitTarget
   = Texture2D
   | TextureCubeMap

instance MarshallGLEnum TextureUnitTarget where
    toGLEnum Texture2D                      = 0x0DE1
    toGLEnum TextureCubeMap                 = 0x8513

    fromGLEnum 0x0DE1 = Just Texture2D
    fromGLEnum 0x8513 = Just TextureCubeMap
    fromGLEnum _      = Nothing

----------------------------------------------------------------------

public
data TextureTarget
   = Texture2D'
   | TextureCubeMapPositiveX
   | TextureCubeMapNegativeX
   | TextureCubeMapPositiveY
   | TextureCubeMapNegativeY
   | TextureCubeMapPositiveZ
   | TextureCubeMapNegativeZ

instance MarshallGLEnum TextureTarget where
    toGLEnum Texture2D'                      = 0x0DE1
    toGLEnum TextureCubeMapPositiveX        = 0x8515
    toGLEnum TextureCubeMapNegativeX        = 0x8516
    toGLEnum TextureCubeMapPositiveY        = 0x8517
    toGLEnum TextureCubeMapNegativeY        = 0x8518
    toGLEnum TextureCubeMapPositiveZ        = 0x8519
    toGLEnum TextureCubeMapNegativeZ        = 0x851A

    fromGLEnum 0x0DE1 = Just Texture2D'
    fromGLEnum 0x8515 = Just TextureCubeMapPositiveX
    fromGLEnum 0x8516 = Just TextureCubeMapNegativeX
    fromGLEnum 0x8517 = Just TextureCubeMapPositiveY
    fromGLEnum 0x8518 = Just TextureCubeMapNegativeY
    fromGLEnum 0x8519 = Just TextureCubeMapPositiveZ
    fromGLEnum 0x851A = Just TextureCubeMapNegativeZ
    fromGLEnum _      = Nothing

----------------------------------------------------------------------

public
data TextureFormat
   = TextureAlpha
   | TextureRGB
   | TextureRGBA
   | TextureLuminance
   | TextureLuminanceAlpha

instance MarshallGLEnum TextureFormat where
    toGLEnum TextureAlpha                          = 0x1906
    toGLEnum TextureRGB                            = 0x1907
    toGLEnum TextureRGBA                           = 0x1908
    toGLEnum TextureLuminance                      = 0x1909
    toGLEnum TextureLuminanceAlpha                 = 0x190A

    fromGLEnum 0x1906 = Just TextureAlpha
    fromGLEnum 0x1907 = Just TextureRGB
    fromGLEnum 0x1908 = Just TextureRGBA
    fromGLEnum 0x1909 = Just TextureLuminance
    fromGLEnum 0x190A = Just TextureLuminanceAlpha
    fromGLEnum _      = Nothing

----------------------------------------------------------------------

public
data TextureParameter
   = TextureMagFilter
   | TextureMinFilter
   | TextureWrapS
   | TextureWrapT

instance MarshallGLEnum TextureParameter where
    toGLEnum TextureMagFilter               = 0x2800
    toGLEnum TextureMinFilter               = 0x2801
    toGLEnum TextureWrapS                   = 0x2802
    toGLEnum TextureWrapT                   = 0x2803

    fromGLEnum 0x2800 = Just TextureMagFilter
    fromGLEnum 0x2801 = Just TextureMinFilter
    fromGLEnum 0x2802 = Just TextureWrapS
    fromGLEnum 0x2803 = Just TextureWrapT
    fromGLEnum _      = Nothing

public
data TextureFilter
   = Nearest
   | Linear
   | NearestMipmapNearest
   | LinearMipmapNearest
   | NearestMipmapLinear
   | LinearMipmapLinear

instance MarshallGLEnum TextureFilter where
    toGLEnum Nearest                        = 0x2600
    toGLEnum Linear                         = 0x2601
    toGLEnum NearestMipmapNearest           = 0x2700
    toGLEnum LinearMipmapNearest            = 0x2701
    toGLEnum NearestMipmapLinear            = 0x2702
    toGLEnum LinearMipmapLinear             = 0x2703

    fromGLEnum 0x2600 = Just Nearest
    fromGLEnum 0x2601 = Just Linear
    fromGLEnum 0x2700 = Just NearestMipmapNearest
    fromGLEnum 0x2701 = Just LinearMipmapNearest
    fromGLEnum 0x2702 = Just NearestMipmapLinear
    fromGLEnum 0x2703 = Just LinearMipmapLinear
    fromGLEnum _      = Nothing

public
data TextureWrapMode
   = Repeat
   | ClampToEdge
   | MirroredRepeat

instance MarshallGLEnum TextureWrapMode where
    toGLEnum Repeat                         = 0x2901
    toGLEnum ClampToEdge                    = 0x812F
    toGLEnum MirroredRepeat                 = 0x8370

    fromGLEnum 0x2901 = Just Repeat
    fromGLEnum 0x812F = Just ClampToEdge
    fromGLEnum 0x8370 = Just MirroredRepeat
    fromGLEnum _      = Nothing

instance MarshallToJType TextureParameter where
    toJType TextureMagFilter = JEnum TextureFilter fromGLEnum toGLEnum
    toJType TextureMinFilter = JEnum TextureFilter fromGLEnum toGLEnum
    toJType TextureWrapS     = JEnum TextureWrapMode fromGLEnum toGLEnum
    toJType TextureWrapT     = JEnum TextureWrapMode fromGLEnum toGLEnum

----------------------------------------------------------------------

public
getTexParameter : Context -> TextureUnitTarget -> (pname : TextureParameter) -> IO (interpJRetType (toJType pname))
getTexParameter (MkContext context) target pname = map (unpackType pname) $ mkForeign
    (FFun "%0.getTexParameter(%1, %2)"
    [FPtr, FEnum, FEnum] (JTypeToFType pname))
    context (toGLEnum target) (toGLEnum pname)

----------------------------------------------------------------------

public
activeTexture : Context -> TextureUnit -> IO ()
activeTexture (MkContext context) texture = mkForeign
    (FFun "%0.activeTexture(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum texture)

----------------------------------------------------------------------

public
bindTexture : Context -> TextureUnitTarget -> Texture -> IO ()
bindTexture (MkContext context) target (MkTexture texture) = mkForeign
    (FFun "%0.bindTexture(%1, %2)"
    [FPtr, FEnum, FPtr] FUnit)
    context (toGLEnum target) texture

----------------------------------------------------------------------

public
copyTexImage2D : Context -> TextureTarget -> Int -> TextureFormat -> Int -> Int -> Int -> Int -> Int -> IO ()
copyTexImage2D (MkContext context) target level internalformat x y width height border = mkForeign
    (FFun "%0.copyTexImage2D(%1, %2, %3, %4, %5, %6, %7, %8)"
    [FPtr, FEnum, FInt, FEnum, FInt, FInt, FInt, FInt, FInt] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) x y width height border

----------------------------------------------------------------------

public
copyTexSubImage2D : Context -> TextureTarget -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> IO ()
copyTexSubImage2D (MkContext context) target level xoffset yoffset x y width height = mkForeign
    (FFun "%0.copyTexSubImage2D(%1, %2, %3, %4, %5, %6, %7, %8)"
    [FPtr, FEnum, FInt, FInt, FInt, FInt, FInt, FInt, FInt] FUnit)
    context (toGLEnum target) level xoffset yoffset x y width height

----------------------------------------------------------------------

public
createTexture : Context -> IO Texture
createTexture (MkContext context) = map MkTexture $ mkForeign
    (FFun "%0.createTexture()"
    [FPtr] FPtr)
    context

----------------------------------------------------------------------

public
deleteTexture : Context -> Texture -> IO ()
deleteTexture (MkContext context) (MkTexture texture) = mkForeign
    (FFun "%0.deleteTexture(%1)"
    [FPtr, FPtr] FUnit)
    context texture

----------------------------------------------------------------------

public
generateMipmap : Context -> TextureUnitTarget -> IO ()
generateMipmap (MkContext context) target = mkForeign
    (FFun "%0.generateMipmap(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum target)

----------------------------------------------------------------------

public
isTexture : Context -> Texture -> IO Bool
isTexture (MkContext context) (MkTexture texture) = map fromGLBool $ mkForeign
    (FFun "%0.isTexture(%1)"
    [FPtr, FPtr] FBool)
    context texture

----------------------------------------------------------------------

public
texImage2D : Context -> TextureTarget -> Int -> TextureFormat -> Int -> Int -> Int -> TextureFormat -> PixelType -> ArrayBufferView -> IO ()
texImage2D (MkContext context) target level internalformat width height border format type (MkArrayBufferView pixels) = mkForeign
    (FFun "%0.texImage2D(%1, %2, %3, %4, %5, %6, %7, %8, %9)"
    [FPtr, FEnum, FInt, FEnum, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) width height border (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------

abstract
class TextureData a where
    unpackToPtr : a -> Ptr
instance TextureData () where
    unpackToPtr () = null
instance TextureData ImageData where
    unpackToPtr (MkImageData dat) = dat
instance TextureData HTMLImageElement where
    unpackToPtr (MkHTMLImageElement dat) = dat
instance TextureData HTMLCanvasElemen where
    unpackToPtr (MkHTMLCanvasElemen dat) = dat
instance TextureData HTMLVideoElement where
    unpackToPtr (MkHTMLVideoElement dat) = dat

public
texImage2DData : TextureData a => Context -> TextureTarget -> Int -> TextureFormat -> TextureFormat -> PixelType -> a -> IO ()
texImage2DData (MkContext context) target level internalformat format type dat = mkForeign
    (FFun "%0.texImage2D(%1, %2, %3, %4, %5, %6)"
    [FPtr, FEnum, FInt, FEnum, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) (toGLEnum format) (toGLEnum type) (unpackToPtr dat)

----------------------------------------------------------------------

public
texParameter : Context -> TextureUnitTarget -> (pname : TextureParameter) -> interpJType (toJType pname) -> IO ()
texParameter (MkContext context) target pname param = mkForeign
    (FFun "%0.texParameteri(%1, %2, %3)"
    [FPtr, FEnum, FEnum, JTypeToFType pname] FUnit)
    context (toGLEnum target) (toGLEnum pname) (packType pname param)

----------------------------------------------------------------------

public
texSubImage2D : Context -> TextureTarget -> Int -> Int -> Int -> Int -> Int -> TextureFormat -> PixelType -> ArrayBufferView -> IO ()
texSubImage2D (MkContext context) target level xoffset yoffset width height format type (MkArrayBufferView pixels) = mkForeign
    (FFun "%0.texSubImage2D(%1, %2, %3, %4, %5, %6, %7, %8, %9)"
    [FPtr, FEnum, FInt, FInt, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level xoffset yoffset width height (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------

public
texSubImage2DData : TextureData a => Context -> TextureTarget -> Int -> Int -> Int -> TextureFormat -> PixelType -> a -> IO ()
texSubImage2DData (MkContext context) target level xoffset yoffset format type (MkImageData pixels) = mkForeign
    (FFun "%0.texSubImage2D(%1, %2, %3, %4, %5, %6, %7)"
    [FPtr, FEnum, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level xoffset yoffset (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------
