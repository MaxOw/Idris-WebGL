module Graphics.WebGL.Texture

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType

----------------------------------------------------------------------

data TextureUnitTarget
   = Texture2D
   | TextureCubeMap

instance MarshallGLEnum TextureUnitTarget where
    toGLEnum Texture2D                      = 0x0DE1
    toGLEnum TextureCubeMap                 = 0x8513

    fromGLEnum 0x0DE1 = Texture2D
    fromGLEnum 0x8513 = TextureCubeMap

----------------------------------------------------------------------

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

    fromGLEnum 0x0DE1 = Texture2D'
    fromGLEnum 0x8515 = TextureCubeMapPositiveX
    fromGLEnum 0x8516 = TextureCubeMapNegativeX
    fromGLEnum 0x8517 = TextureCubeMapPositiveY
    fromGLEnum 0x8518 = TextureCubeMapNegativeY
    fromGLEnum 0x8519 = TextureCubeMapPositiveZ
    fromGLEnum 0x851A = TextureCubeMapNegativeZ

----------------------------------------------------------------------

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

    fromGLEnum 0x1906 = TextureAlpha
    fromGLEnum 0x1907 = TextureRGB
    fromGLEnum 0x1908 = TextureRGBA
    fromGLEnum 0x1909 = TextureLuminance
    fromGLEnum 0x190A = TextureLuminanceAlpha

----------------------------------------------------------------------

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

    fromGLEnum 0x2800 = TextureMagFilter
    fromGLEnum 0x2801 = TextureMinFilter
    fromGLEnum 0x2802 = TextureWrapS
    fromGLEnum 0x2803 = TextureWrapT


----------------------------------------------------------------------

{-
getTexParameter : Context -> TextureUnitTarget -> (pname : TextureParameter) -> IO (interpJType (toJType pname))
getTexParameter (MkContext context) target pname = map (unpackType (toJType pname)) $ mkForeign
    (FFun "%0.getTexParameter(%1, %2)"
    [FPtr, FEnum, FEnum] (toFType (toJType pname)))
    context (toGLEnum target) (toGLEnum pname)
-}

----------------------------------------------------------------------

activeTexture : Context -> TextureUnit -> IO ()
activeTexture (MkContext context) texture = mkForeign
    (FFun "%0.activeTexture(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum texture)

----------------------------------------------------------------------

bindTexture : Context -> TextureUnitTarget -> Texture -> IO ()
bindTexture (MkContext context) target (MkTexture texture) = mkForeign
    (FFun "%0.bindTexture(%1, %2)"
    [FPtr, FEnum, FPtr] FUnit)
    context (toGLEnum target) texture

----------------------------------------------------------------------

copyTexImage2D : Context -> TextureTarget -> Int -> TextureFormat -> Int -> Int -> Int -> Int -> Int -> IO ()
copyTexImage2D (MkContext context) target level internalformat x y width height border = mkForeign
    (FFun "%0.copyTexImage2D(%1, %2, %3, %4, %5, %6, %7, %8)"
    [FPtr, FEnum, FInt, FEnum, FInt, FInt, FInt, FInt, FInt] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) x y width height border

----------------------------------------------------------------------

copyTexSubImage2D : Context -> TextureTarget -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> IO ()
copyTexSubImage2D (MkContext context) target level xoffset yoffset x y width height = mkForeign
    (FFun "%0.copyTexSubImage2D(%1, %2, %3, %4, %5, %6, %7, %8)"
    [FPtr, FEnum, FInt, FInt, FInt, FInt, FInt, FInt, FInt] FUnit)
    context (toGLEnum target) level xoffset yoffset x y width height

----------------------------------------------------------------------

createTexture : Context -> IO Texture
createTexture (MkContext context) = map MkTexture $ mkForeign
    (FFun "%0.createTexture()"
    [FPtr] FPtr)
    context

----------------------------------------------------------------------

deleteTexture : Context -> Texture -> IO ()
deleteTexture (MkContext context) (MkTexture texture) = mkForeign
    (FFun "%0.deleteTexture(%1)"
    [FPtr, FPtr] FUnit)
    context texture

----------------------------------------------------------------------

generateMipmap : Context -> TextureUnitTarget -> IO ()
generateMipmap (MkContext context) target = mkForeign
    (FFun "%0.generateMipmap(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum target)

----------------------------------------------------------------------

isTexture : Context -> Texture -> IO Bool
isTexture (MkContext context) (MkTexture texture) = map fromGLBool $ mkForeign
    (FFun "%0.isTexture(%1)"
    [FPtr, FPtr] FBool)
    context texture

----------------------------------------------------------------------

texImage2D : Context -> TextureTarget -> Int -> TextureFormat -> Int -> Int -> Int -> TextureFormat -> PixelType -> ArrayBufferView -> IO ()
texImage2D (MkContext context) target level internalformat width height border format type (MkArrayBufferView pixels) = mkForeign
    (FFun "%0.texImage2D(%1, %2, %3, %4, %5, %6, %7, %8, %9)"
    [FPtr, FEnum, FInt, FEnum, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) width height border (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------

{-
texImage2D : Context -> TextureTarget -> Int -> TextureFormat -> TextureFormat -> PixelType -> ImageData -> IO ()
texImage2D (MkContext context) target level internalformat format type (MkImageData pixels) = mkForeign
    (FFun "%0.texImage2D(%1, %2, %3, %4, %5, %6)"
    [FPtr, FEnum, FInt, FEnum, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------

texImage2D : Context -> TextureTarget -> Int -> TextureFormat -> TextureFormat -> PixelType -> HTMLImageElement -> IO ()
texImage2D (MkContext context) target level internalformat format type (MkHTMLImageElement image) = mkForeign
    (FFun "%0.texImage2D(%1, %2, %3, %4, %5, %6)"
    [FPtr, FEnum, FInt, FEnum, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) (toGLEnum format) (toGLEnum type) image

----------------------------------------------------------------------

texImage2D : Context -> TextureTarget -> Int -> TextureFormat -> TextureFormat -> PixelType -> HTMLCanvasElement -> IO ()
texImage2D (MkContext context) target level internalformat format type (MkHTMLCanvasElement canvas) = mkForeign
    (FFun "%0.texImage2D(%1, %2, %3, %4, %5, %6)"
    [FPtr, FEnum, FInt, FEnum, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) (toGLEnum format) (toGLEnum type) canvas

----------------------------------------------------------------------

texImage2D : Context -> TextureTarget -> Int -> TextureFormat -> TextureFormat -> PixelType -> HTMLVideoElement -> IO ()
texImage2D (MkContext context) target level internalformat format type (MkHTMLVideoElement video) = mkForeign
    (FFun "%0.texImage2D(%1, %2, %3, %4, %5, %6)"
    [FPtr, FEnum, FInt, FEnum, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level (toGLEnum internalformat) (toGLEnum format) (toGLEnum type) video
-}

----------------------------------------------------------------------

texParameterf : Context -> TextureUnitTarget -> TextureParameter -> Float -> IO ()
texParameterf (MkContext context) target pname param = mkForeign
    (FFun "%0.texParameterf(%1, %2, %3)"
    [FPtr, FEnum, FEnum, FFloat] FUnit)
    context (toGLEnum target) (toGLEnum pname) param

----------------------------------------------------------------------

texParameteri : Context -> TextureUnitTarget -> TextureParameter -> Int -> IO ()
texParameteri (MkContext context) target pname param = mkForeign
    (FFun "%0.texParameteri(%1, %2, %3)"
    [FPtr, FEnum, FEnum, FInt] FUnit)
    context (toGLEnum target) (toGLEnum pname) param

----------------------------------------------------------------------

texSubImage2D : Context -> TextureTarget -> Int -> Int -> Int -> Int -> Int -> TextureFormat -> PixelType -> ArrayBufferView -> IO ()
texSubImage2D (MkContext context) target level xoffset yoffset width height format type (MkArrayBufferView pixels) = mkForeign
    (FFun "%0.texSubImage2D(%1, %2, %3, %4, %5, %6, %7, %8, %9)"
    [FPtr, FEnum, FInt, FInt, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level xoffset yoffset width height (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------

{-
texSubImage2D : Context -> GLEnum#target -> Int -> Int -> Int -> GLEnum#format -> GLEnum#type -> ImageData -> IO ()
texSubImage2D (MkContext context) target level xoffset yoffset format type (MkImageData pixels) = mkForeign
    (FFun "%0.texSubImage2D(%1, %2, %3, %4, %5, %6, %7)"
    [FPtr, FEnum, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level xoffset yoffset (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------

texSubImage2D : Context -> GLEnum#target -> Int -> Int -> Int -> GLEnum#format -> GLEnum#type -> HTMLImageElement -> IO ()
texSubImage2D (MkContext context) target level xoffset yoffset format type (MkHTMLImageElement image) = mkForeign
    (FFun "%0.texSubImage2D(%1, %2, %3, %4, %5, %6, %7)"
    [FPtr, FEnum, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level xoffset yoffset (toGLEnum format) (toGLEnum type) image

----------------------------------------------------------------------

texSubImage2D : Context -> GLEnum#target -> Int -> Int -> Int -> GLEnum#format -> GLEnum#type -> HTMLCanvasElement -> IO ()
texSubImage2D (MkContext context) target level xoffset yoffset format type (MkHTMLCanvasElement canvas) = mkForeign
    (FFun "%0.texSubImage2D(%1, %2, %3, %4, %5, %6, %7)"
    [FPtr, FEnum, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level xoffset yoffset (toGLEnum format) (toGLEnum type) canvas

----------------------------------------------------------------------

texSubImage2D : Context -> GLEnum#target -> Int -> Int -> Int -> GLEnum#format -> GLEnum#type -> HTMLVideoElement -> IO ()
texSubImage2D (MkContext context) target level xoffset yoffset format type (MkHTMLVideoElement video) = mkForeign
    (FFun "%0.texSubImage2D(%1, %2, %3, %4, %5, %6, %7)"
    [FPtr, FEnum, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) level xoffset yoffset (toGLEnum format) (toGLEnum type) video
-}
----------------------------------------------------------------------
