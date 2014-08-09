module Graphics.WebGL.Functions

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

----------------------------------------------------------------------

getElemById : String -> IO Element
getElemById x = map MkElement $
    mkForeign (FFun "document.getElementById(%0)" [FString] FPtr) x

----------------------------------------------------------------------

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
data ContextAttributes = MkContextAttributes Ptr

getContextAttributes : Context -> IO ContextAttributes
getContextAttributes (MkContext context) = map MkContextAttributes $ mkForeign
    (FFun "%0.getContextAttributes()"
    [FPtr] FPtr)
    context

----------------------------------------------------------------------

isContextLost : Context -> IO Bool
isContextLost (MkContext context) = map fromGLBool $ mkForeign
    (FFun "%0.isContextLost()"
    [FPtr] FBool)
    context

----------------------------------------------------------------------

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

    fromGLEnum 0x0B44 = CullFace
    fromGLEnum 0x0BE2 = Blend
    fromGLEnum 0x0BD0 = Dither
    fromGLEnum 0x0B90 = StencilTest
    fromGLEnum 0x0B71 = DepthTest
    fromGLEnum 0x0C11 = ScissorTest
    fromGLEnum 0x8037 = PolygonOffsetFill
    fromGLEnum 0x809E = SampleAlphaToCoverage
    fromGLEnum 0x80A0 = SampleCoverage

enable : Context -> Capability -> IO ()
enable (MkContext context) cap = mkForeign
    (FFun "%0.enable(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum cap)

disable : Context -> Capability -> IO ()
disable (MkContext context) cap = mkForeign
    (FFun "%0.disable(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum cap)

isEnabled : Context -> Capability -> IO Bool
isEnabled (MkContext context) cap = map fromGLBool $ mkForeign
    (FFun "%0.isEnabled(%1)"
    [FPtr, FEnum] FBool)
    context (toGLEnum cap)

----------------------------------------------------------------------

finish : Context -> IO ()
finish (MkContext context) = mkForeign
    (FFun "%0.finish()"
    [FPtr] FUnit)
    context

----------------------------------------------------------------------

flush : Context -> IO ()
flush (MkContext context) = mkForeign
    (FFun "%0.flush()"
    [FPtr] FUnit)
    context

----------------------------------------------------------------------

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

    fromGLEnum 0 = NoError
    fromGLEnum 0x0500 = InvalidEnum
    fromGLEnum 0x0501 = InvalidValue
    fromGLEnum 0x0502 = InvalidOperation
    fromGLEnum 0x0505 = OutOfMemory
    fromGLEnum 0x0506 = InvalidFramebufferOperation

getError : Context -> IO ErrorType
getError (MkContext context) = map fromGLEnum $ mkForeign
    (FFun "%0.getError()"
    [FPtr] FEnum)
    context

----------------------------------------------------------------------

data HintTarget
   = GenerateMipmapHint

instance MarshallGLEnum HintTarget where
    toGLEnum GenerateMipmapHint             = 0x8192
    fromGLEnum 0x8192 = GenerateMipmapHint

data HintMode
   = DontCare
   | Fastest
   | Nicest

instance MarshallGLEnum HintMode where
    toGLEnum DontCare                       = 0x1100
    toGLEnum Fastest                        = 0x1101
    toGLEnum Nicest                         = 0x1102

    fromGLEnum 0x1100 = DontCare
    fromGLEnum 0x1101 = Fastest
    fromGLEnum 0x1102 = Nicest

hint : Context -> HintTarget -> HintMode -> IO ()
hint (MkContext context) target mode = mkForeign
    (FFun "%0.hint(%1, %2)"
    [FPtr, FEnum, FEnum] FUnit)
    context (toGLEnum target) (toGLEnum mode)

----------------------------------------------------------------------

data Alignment
   = UnpackAlignment
   | PackAlignment

instance MarshallGLEnum Alignment where
    toGLEnum UnpackAlignment                = 0x0CF5
    toGLEnum PackAlignment                  = 0x0D05

    fromGLEnum 0x0CF5 = UnpackAlignment
    fromGLEnum 0x0D05 = PackAlignment

pixelStorei : Context -> Alignment -> Int -> IO ()
pixelStorei (MkContext context) pname param = mkForeign
    (FFun "%0.pixelStorei(%1, %2)"
    [FPtr, FEnum, FInt] FUnit)
    context (toGLEnum pname) param

----------------------------------------------------------------------

readPixels : Context -> Int -> Int -> Int -> Int -> PixelFormat -> PixelType -> ArrayBufferView -> IO ()
readPixels (MkContext context) x y width height format type (MkArrayBufferView pixels) = mkForeign
    (FFun "%0.readPixels(%1, %2, %3, %4, %5, %6, %7)"
    [FPtr, FInt, FInt, FInt, FInt, FEnum, FEnum, FPtr] FUnit)
    context x y width height (toGLEnum format) (toGLEnum type) pixels

----------------------------------------------------------------------
