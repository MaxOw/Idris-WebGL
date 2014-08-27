module Graphics.WebGL.Functions

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

----------------------------------------------------------------------

public
getElemById : String -> IO Element
getElemById x = map MkElement $
    mkForeign (FFun "document.getElementById(%0)" [FString] FPtr) x

----------------------------------------------------------------------

public
getContext : Element -> IO Context
getContext (MkElement x) = map MkContext $
    mkForeign (FFun "%0.getContext('webgl')" [FPtr] FPtr) x

----------------------------------------------------------------------

-- WebGLContextAttributes (section 5.2)
-- https://www.khronos.org/registry/webgl/specs/1.0.0/#5.2

{-
 -
 - alpha
 -     If the value is true, the drawing buffer has an alpha channel
 -     for the purposes of performing OpenGL destination alpha
 -     operations and compositing with the page. If the value is
 -     false, no alpha buffer is available. 
 - depth
 -     If the value is true, the drawing buffer has a depth buffer
 -     of at least 16 bits. If the value is false, no depth buffer
 -     is available. 
 - stencil
 -     If the value is true, the drawing buffer has a stencil
 -     buffer of at least 8 bits. If the value is false, no
 -     stencil buffer is available. 
 - antialias
 -     If the value is true and the implementation
 -     supports antialiasing the drawing buffer will
 -     perform antialiasing using its choice of technique
 -     (multisample/supersample) and quality. If the value
 -     is false or the implementation does not support
 -     antialiasing, no antialiasing is performed. 
 - premultipliedAlpha
 -     If the value is true the page compositor will
 -     assume the drawing buffer contains colors with
 -     premultiplied alpha. If the value is false the
 -     page compositor will assume that colors in the
 -     drawing buffer are not premultiplied. This flag
 -     is ignored if the alpha flag is false. See
 -     Premultiplied Alpha for more information on the
 -     effects of the premultipliedAlpha flag. 
 - preserveDrawingBuffer
 -     If false, once the drawing buffer is
 -     presented as described in theDrawing Buffer
 -     section, the contents of the drawing buffer
 -     are cleared to their default values. All
 -     elements of the drawing buffer (color,
 -     depth and stencil) are cleared. If the
 -     value is true the buffers will not be
 -     cleared and will preserve their values
 -     until cleared or overwritten by the author. 
 -
 -}

-- ToDo expand
abstract
data ContextAttributes = MkContextAttributes Ptr

public
getContextAttributes : Context -> IO ContextAttributes
getContextAttributes (MkContext context) = map MkContextAttributes $ mkForeign
    (FFun "%0.getContextAttributes()"
    [FPtr] FPtr)
    context

----------------------------------------------------------------------

public
isContextLost : Context -> IO Bool
isContextLost (MkContext context) = map fromGLBool $ mkForeign
    (FFun "%0.isContextLost()"
    [FPtr] FBool)
    context

----------------------------------------------------------------------

public
data Capability
   = CullFace
   | Blend
   | Dither
   | StencilTest
   | DepthTest
   | ScissorTest
   | PolygonOffsetFill
   | SampleAlphaToCoverage
   | SampleCoverage

instance MarshallGLEnum Capability where
    toGLEnum CullFace                       = 0x0B44
    toGLEnum Blend                          = 0x0BE2
    toGLEnum Dither                         = 0x0BD0
    toGLEnum StencilTest                    = 0x0B90
    toGLEnum DepthTest                      = 0x0B71
    toGLEnum ScissorTest                    = 0x0C11
    toGLEnum PolygonOffsetFill              = 0x8037
    toGLEnum SampleAlphaToCoverage          = 0x809E
    toGLEnum SampleCoverage                 = 0x80A0

    fromGLEnum 0x0B44 = Just CullFace
    fromGLEnum 0x0BE2 = Just Blend
    fromGLEnum 0x0BD0 = Just Dither
    fromGLEnum 0x0B90 = Just StencilTest
    fromGLEnum 0x0B71 = Just DepthTest
    fromGLEnum 0x0C11 = Just ScissorTest
    fromGLEnum 0x8037 = Just PolygonOffsetFill
    fromGLEnum 0x809E = Just SampleAlphaToCoverage
    fromGLEnum 0x80A0 = Just SampleCoverage
    fromGLEnum _      = Nothing

public
enable : Context -> Capability -> IO ()
enable (MkContext context) cap = mkForeign
    (FFun "%0.enable(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum cap)

public
disable : Context -> Capability -> IO ()
disable (MkContext context) cap = mkForeign
    (FFun "%0.disable(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum cap)

public
isEnabled : Context -> Capability -> IO Bool
isEnabled (MkContext context) cap = map fromGLBool $ mkForeign
    (FFun "%0.isEnabled(%1)"
    [FPtr, FEnum] FBool)
    context (toGLEnum cap)

----------------------------------------------------------------------

public
finish : Context -> IO ()
finish (MkContext context) = mkForeign
    (FFun "%0.finish()"
    [FPtr] FUnit)
    context

----------------------------------------------------------------------

public
flush : Context -> IO ()
flush (MkContext context) = mkForeign
    (FFun "%0.flush()"
    [FPtr] FUnit)
    context

----------------------------------------------------------------------

public
data ErrorType
   = NoError
   | InvalidEnum
   | InvalidValue
   | InvalidOperation
   | OutOfMemory
   | InvalidFramebufferOperation

instance MarshallGLEnum ErrorType where
    toGLEnum NoError                        = 0
    toGLEnum InvalidEnum                    = 0x0500
    toGLEnum InvalidValue                   = 0x0501
    toGLEnum InvalidOperation               = 0x0502
    toGLEnum OutOfMemory                    = 0x0505
    toGLEnum InvalidFramebufferOperation    = 0x0506

    fromGLEnum 0 = Just NoError
    fromGLEnum 0x0500 = Just InvalidEnum
    fromGLEnum 0x0501 = Just InvalidValue
    fromGLEnum 0x0502 = Just InvalidOperation
    fromGLEnum 0x0505 = Just OutOfMemory
    fromGLEnum 0x0506 = Just InvalidFramebufferOperation
    fromGLEnum _      = Nothing

public
getError : Context -> IO (Maybe ErrorType)
getError (MkContext context) = map fromGLEnum $ mkForeign
    (FFun "%0.getError()"
    [FPtr] FEnum)
    context

----------------------------------------------------------------------

public
data HintTarget
   = GenerateMipmapHint

instance MarshallGLEnum HintTarget where
    toGLEnum GenerateMipmapHint             = 0x8192
    fromGLEnum 0x8192 = Just GenerateMipmapHint
    fromGLEnum _      = Nothing

public
data HintMode
   = DontCare
   | Fastest
   | Nicest

instance MarshallGLEnum HintMode where
    toGLEnum DontCare                       = 0x1100
    toGLEnum Fastest                        = 0x1101
    toGLEnum Nicest                         = 0x1102

    fromGLEnum 0x1100 = Just DontCare
    fromGLEnum 0x1101 = Just Fastest
    fromGLEnum 0x1102 = Just Nicest
    fromGLEnum _      = Nothing

public
hint : Context -> HintTarget -> HintMode -> IO ()
hint (MkContext context) target mode = mkForeign
    (FFun "%0.hint(%1, %2)"
    [FPtr, FEnum, FEnum] FUnit)
    context (toGLEnum target) (toGLEnum mode)

----------------------------------------------------------------------

public
data Alignment
   = UnpackAlignment
   | PackAlignment
   | UnpackFlipY
   | UnpackPremultiplyAlpha

instance MarshallGLEnum Alignment where
    toGLEnum UnpackAlignment                = 0x0CF5
    toGLEnum PackAlignment                  = 0x0D05
    toGLEnum UnpackFlipY                    = 0x9240
    toGLEnum UnpackPremultiplyAlpha         = 0x9241

    fromGLEnum 0x0CF5 = Just UnpackAlignment
    fromGLEnum 0x0D05 = Just PackAlignment
    fromGLEnum 0x9240 = Just UnpackFlipY
    fromGLEnum 0x9241 = Just UnpackPremultiplyAlpha
    fromGLEnum _      = Nothing

public
pixelStorei : Context -> Alignment -> Int -> IO ()
pixelStorei (MkContext context) pname param = mkForeign
    (FFun "%0.pixelStorei(%1, %2)"
    [FPtr, FEnum, FInt] FUnit)
    context (toGLEnum pname) param

----------------------------------------------------------------------

public
readPixels : Context -> Int -> Int -> Int -> Int -> PixelFormat -> PixelType -> ArrayBufferView -> IO ()
readPixels (MkContext context) x y width height format type (MkArrayBufferView pixels) = mkForeign
    (FFun "%0.readPixels(%1, %2, %3, %4, %5, %6, %7)"
    [FPtr, FInt, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context x y width height (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------
