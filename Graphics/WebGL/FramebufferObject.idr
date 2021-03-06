module Graphics.WebGL.FramebufferObject

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType
import Graphics.WebGL.Texture

----------------------------------------------------------------------

public
data FramebufferTarget
   = FramebufferTarget'

instance MarshallGLEnum FramebufferTarget where
    toGLEnum FramebufferTarget' = 0x8D40
    fromGLEnum 0x8D40 = Just FramebufferTarget'
    fromGLEnum _      = Nothing

----------------------------------------------------------------------

public
data Attachment
   = ColorAttachment Int
   | DepthAttachment
   | StencilAttachment

instance MarshallGLEnum Attachment where
    toGLEnum (ColorAttachment n)            = 0x8CE0 + n
    toGLEnum DepthAttachment                = 0x8D00
    toGLEnum StencilAttachment              = 0x8D20
    -- toGLEnum DepthStencilAttachment         = 0x821A
    fromGLEnum 0x8D00 = Just DepthAttachment
    fromGLEnum 0x8D20 = Just StencilAttachment
    -- fromGLEnum 0x821A = Just DepthStencilAttachment
    fromGLEnum n      = Just $ ColorAttachment (n - 0x8CE0)
    -- fromGLEnum _      = Nothing

----------------------------------------------------------------------

public
data FramebufferAttachmentParameter
   = FramebufferAttachmentObjectType
   | FramebufferAttachmentObjectName
   | FramebufferAttachmentTextureLevel
   | FramebufferAttachmentTextureCubeMapFace

instance MarshallGLEnum FramebufferAttachmentParameter where
    toGLEnum FramebufferAttachmentObjectType = 0x8CD0
    toGLEnum FramebufferAttachmentObjectName = 0x8CD1
    toGLEnum FramebufferAttachmentTextureLevel = 0x8CD2
    toGLEnum FramebufferAttachmentTextureCubeMapFace = 0x8CD3

    fromGLEnum 0x8CD0 = Just FramebufferAttachmentObjectType
    fromGLEnum 0x8CD1 = Just FramebufferAttachmentObjectName
    fromGLEnum 0x8CD2 = Just FramebufferAttachmentTextureLevel
    fromGLEnum 0x8CD3 = Just FramebufferAttachmentTextureCubeMapFace
    fromGLEnum _      = Nothing

public
data AttachmentObjectType
   = AttachmentNone
   | AttachmentRenderbuffer
   | AttachmentTexture

instance MarshallGLEnum AttachmentObjectType where
    toGLEnum AttachmentNone = 0
    toGLEnum AttachmentRenderbuffer = 0x8D41
    toGLEnum AttachmentTexture = 0x1702

    fromGLEnum 0      = Just AttachmentNone
    fromGLEnum 0x8D41 = Just AttachmentRenderbuffer
    fromGLEnum 0x1702 = Just AttachmentTexture
    fromGLEnum _      = Nothing

instance MarshallToJType FramebufferAttachmentParameter where
    toJType FramebufferAttachmentObjectType         = JEnum AttachmentObjectType fromGLEnum toGLEnum
    toJType FramebufferAttachmentObjectName         = JUnit
        -- Renderbuffer / TextureUnit
        -- depending on AttachmentObjectType
    toJType FramebufferAttachmentTextureLevel       = JInt
    toJType FramebufferAttachmentTextureCubeMapFace = JEnum TextureTarget fromGLEnum toGLEnum
        -- This is slightly iffy

public
getFramebufferAttachmentParameter : Context -> FramebufferTarget -> Attachment -> (pname : FramebufferAttachmentParameter) -> IO (interpJRetType (toJType pname))
getFramebufferAttachmentParameter (MkContext context) target attachment pname = map (unpackType pname) $ mkForeign
    (FFun "%0.getFramebufferAttachmentParameter(%1, %2, %3)"
    [FPtr, FEnum, FEnum, FEnum] (JTypeToFType pname))
    context (toGLEnum target) (toGLEnum attachment) (toGLEnum pname)

----------------------------------------------------------------------

public
bindFramebuffer : Context -> FramebufferTarget -> Maybe Framebuffer -> IO ()
bindFramebuffer (MkContext context) target mfb = mkForeign
    (FFun "%0.bindFramebuffer(%1, %2)"
    [FPtr, FEnum, FPtr] FUnit)
    context (toGLEnum target) framebuffer
    where
    framebuffer = (maybe null (\(MkFramebuffer f) => f) mfb)

----------------------------------------------------------------------

public
data FramebufferStatus
   = FramebufferComplete
   | FramebufferIncompleteAttachment
   | FramebufferIncompleteDimensions
   | FramebufferIncompleteMissingAttachment
   | FramebufferUnsupported

instance MarshallGLEnum FramebufferStatus where
    toGLEnum FramebufferComplete                    = 0x8CD5
    toGLEnum FramebufferIncompleteAttachment        = 0x8CD6
    toGLEnum FramebufferIncompleteMissingAttachment = 0x8CD7
    toGLEnum FramebufferIncompleteDimensions        = 0x8CD9
    toGLEnum FramebufferUnsupported                 = 0x8CDD

    fromGLEnum 0x8CD5 = Just FramebufferComplete
    fromGLEnum 0x8CD6 = Just FramebufferIncompleteAttachment
    fromGLEnum 0x8CD7 = Just FramebufferIncompleteMissingAttachment
    fromGLEnum 0x8CD9 = Just FramebufferIncompleteDimensions
    fromGLEnum 0x8CDD = Just FramebufferUnsupported
    fromGLEnum _      = Nothing

public
checkFramebufferStatus : Context -> FramebufferTarget -> IO (Maybe FramebufferStatus)
checkFramebufferStatus (MkContext context) target = map fromGLEnum $ mkForeign
    (FFun "%0.checkFramebufferStatus(%1)"
    [FPtr, FEnum] FEnum)
    context (toGLEnum target)

----------------------------------------------------------------------

public
createFramebuffer : Context -> IO Framebuffer
createFramebuffer (MkContext context) = map MkFramebuffer $ mkForeign
    (FFun "%0.createFramebuffer()"
    [FPtr] FPtr)
    context

----------------------------------------------------------------------

public
deleteFramebuffer : Context -> Framebuffer -> IO ()
deleteFramebuffer (MkContext context) (MkFramebuffer framebuffer) = mkForeign
    (FFun "%0.deleteFramebuffer(%1)"
    [FPtr, FPtr] FUnit)
    context framebuffer

----------------------------------------------------------------------

public
framebufferRenderbuffer : Context -> FramebufferTarget -> Attachment -> RenderbufferTarget -> Renderbuffer -> IO ()
framebufferRenderbuffer (MkContext context) target attachment renderbuffertarget (MkRenderbuffer renderbuffer) = mkForeign
    (FFun "%0.framebufferRenderbuffer(%1, %2, %3, %4)"
    [FPtr, FEnum, FEnum, FEnum, FPtr] FUnit)
    context (toGLEnum target) (toGLEnum attachment) (toGLEnum renderbuffertarget) renderbuffer

----------------------------------------------------------------------

public
framebufferTexture2D : Context -> FramebufferTarget -> Attachment -> TextureTarget -> Texture -> Int -> IO ()
framebufferTexture2D (MkContext context) target attachment textarget (MkTexture texture) level = mkForeign
    (FFun "%0.framebufferTexture2D(%1, %2, %3, %4, %5)"
    [FPtr, FEnum, FEnum, FEnum, FPtr, FInt] FUnit)
    context (toGLEnum target) (toGLEnum attachment) (toGLEnum textarget) texture level

----------------------------------------------------------------------

public
isFramebuffer : Context -> Framebuffer -> IO Bool
isFramebuffer (MkContext context) (MkFramebuffer framebuffer) = map fromGLBool $ mkForeign
    (FFun "%0.isFramebuffer(%1)"
    [FPtr, FPtr] FBool)
    context framebuffer

----------------------------------------------------------------------
