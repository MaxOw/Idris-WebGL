module Graphics.WebGL.Types

import Graphics.WebGL.Utils

public
Color : Type
Color = Vect 4 Float

-- This should be abstract :/
public
data Element = MkElement Ptr

-- WebGLRenderingContext (section 5.12)
-- https://www.khronos.org/registry/webgl/specs/1.0.0/#5.12

{- 
 -
 - canvas of type HTMLCanvasElement
 -     A reference to the canvas element which created this context. 
 - drawingBufferWidth of type GLsizei
 -     The actual width of the drawing buffer. May be different
 -     from the width attribute of the HTMLCanvasElement if the
 -     implementation is unable to satisfy the requested widthor
 -     height. 
 - drawingBufferHeight of type GLsizei
 -     The actual height of the drawing buffer. May be
 -     different from the height attribute of the
 -     HTMLCanvasElement if the implementation is unable to
 -     satisfy the requested width or height. 
 -     
 -}

-- This all should be abstract
public
data Context = MkContext Ptr

-- WebGLObject (section 5.3)
-- https://www.khronos.org/registry/webgl/specs/1.0.0/#5.3

public
data Buffer = MkBuffer Ptr
public
data Texture = MkTexture Ptr
public
data Framebuffer = MkFramebuffer Ptr
public
data Renderbuffer = MkRenderbuffer Ptr
public
data Program = MkProgram Ptr
public
data Shader = MkShader Ptr
public
data UniformLocation = MkUniformLocation Ptr
public
data ActiveInfo = MkActiveInfo Ptr

----------------------------------------------------------------------

public
data TextureUnit = MkTextureUnit Int

instance MarshallGLEnum TextureUnit where
    toGLEnum (MkTextureUnit n) = 0x84C0 + n
    fromGLEnum n = Just $ MkTextureUnit (n - 0x84C0)


public
data ImageData        = MkImageData Ptr
public
data HTMLImageElement = MkHTMLImageElement Ptr
public
data HTMLCanvasElemen = MkHTMLCanvasElemen Ptr
public
data HTMLVideoElement = MkHTMLVideoElement Ptr

----------------------------------------------------------------------

public
data RenderbufferTarget
   = RenderbufferTarget'
instance MarshallGLEnum RenderbufferTarget where
    toGLEnum RenderbufferTarget' = 0x8D41
    fromGLEnum 0x8D41 = Just RenderbufferTarget'
    fromGLEnum _      = Nothing

public
data ShaderType
   = FragmentShader
   | VertexShader

instance MarshallGLEnum ShaderType where
    toGLEnum FragmentShader                 = 0x8B30
    toGLEnum VertexShader                   = 0x8B31

    fromGLEnum 0x8B30 = Just FragmentShader
    fromGLEnum 0x8B31 = Just VertexShader
    fromGLEnum _      = Nothing

public
data Face
   = Front
   | Back
   | FrontAndBack

instance MarshallGLEnum Face where
    toGLEnum Front                          = 0x0404
    toGLEnum Back                           = 0x0405
    toGLEnum FrontAndBack                   = 0x0408

    fromGLEnum 0x0404 = Just Front
    fromGLEnum 0x0405 = Just Back
    fromGLEnum 0x0408 = Just FrontAndBack
    fromGLEnum _      = Nothing

public
data PixelFormat
   = PixelFormatAlpha
   | PixelFormatRGB
   | PixelFormatRGBA

instance MarshallGLEnum PixelFormat where
    toGLEnum PixelFormatAlpha                          = 0x1906
    toGLEnum PixelFormatRGB                            = 0x1907
    toGLEnum PixelFormatRGBA                           = 0x1908

    fromGLEnum 0x1906 = Just PixelFormatAlpha
    fromGLEnum 0x1907 = Just PixelFormatRGB
    fromGLEnum 0x1908 = Just PixelFormatRGBA
    fromGLEnum _      = Nothing

public
data PixelType
   = PixelTypeUnsignedByte
   | PixelTypeUnsignedShort565
   | PixelTypeUnsignedShort4444
   | PixelTypeUnsignedShort5551

instance MarshallGLEnum PixelType where
    toGLEnum PixelTypeUnsignedByte                   = 0x1401
    toGLEnum PixelTypeUnsignedShort4444              = 0x8033
    toGLEnum PixelTypeUnsignedShort5551              = 0x8034
    toGLEnum PixelTypeUnsignedShort565               = 0x8363

    fromGLEnum 0x1401 = Just PixelTypeUnsignedByte
    fromGLEnum 0x8033 = Just PixelTypeUnsignedShort4444
    fromGLEnum 0x8034 = Just PixelTypeUnsignedShort5551
    fromGLEnum 0x8363 = Just PixelTypeUnsignedShort565
    fromGLEnum _      = Nothing

----------------------------------------------------------------------

public
data JSArray a = MkJSArray Ptr

public
newJSArray : IO (JSArray a)
newJSArray = map MkJSArray $ mkForeign (FFun "new Array()" [] FPtr)

public
void : IO a -> IO ()
void m = do m; return ()

public
pushFloat : JSArray Float -> Float -> IO ()
pushFloat (MkJSArray arr) a = void $
        mkForeign (FFun "%0.push(%1)" [FPtr, FFloat] FInt) arr a

public
pushInt : JSArray Int -> Int -> IO ()
pushInt (MkJSArray arr) a = void $
        mkForeign (FFun "%0.push(%1)" [FPtr, FInt] FInt) arr a

public
class JSArrayPush a where
    push : JSArray a -> a -> IO ()
instance JSArrayPush Float where
    push = pushFloat
instance JSArrayPush Int where
    push = pushInt

public
arrayFromList : JSArrayPush a => List a -> IO (JSArray a)
arrayFromList ls = do
    arr <- newJSArray
    fpush arr ls
    return arr
  where
    fpush : JSArray a -> List a -> IO ()
    fpush arr [] = return ()
    fpush arr (a :: as) = do
        push arr a
        fpush arr as

-- ArrayBuffer and Typed Arrays (section 5.12)
-- https://www.khronos.org/registry/webgl/specs/1.0.0/#5.12

{-
data ViewType
   = Int8Array
   | Int16Array
   | Int32Array
   | Uint8Array
   | Uint16Array
   | Uint32Array
   | Float32Array
-}

public
data ArrayBuffer = MkArrayBuffer Ptr
public
data ArrayBufferView = MkArrayBufferView Ptr

{-
newArrayBuffer : Int -> IO ArrayBuffer
newArrayBuffer size = map MkArrayBuffer $ mkForeign 
    (FFun "new ArrayBuffer(%0)" [FInt] FPtr) size
-}

public
data Float32Array = MkFloat32Array Ptr

public
newFloat32Array : JSArray Float -> IO Float32Array
newFloat32Array (MkJSArray ptr) = map MkFloat32Array $ mkForeign 
    (FFun "new Float32Array(%0)" [FPtr] FPtr) ptr

public
data Int32Array = MkInt32Array Ptr

public
newInt32Array : JSArray Float -> IO Int32Array
newInt32Array (MkJSArray ptr) = map MkInt32Array $ mkForeign 
    (FFun "new Int32Array(%0)" [FPtr] FPtr) ptr

