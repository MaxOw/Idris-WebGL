module Graphics.WebGL.Parameter

import Graphics.WebGL.Types
import Graphics.WebGL.Utils
import Graphics.WebGL.AnyType
import Graphics.WebGL.PerFragment
import Graphics.WebGL.Rasterization
import Graphics.WebGL.Functions

public
data Parameter
   = ActiveTexture
   | AliasedLineWidthRange
   | AliasedPointSizeRange
   | AlphaBits
   | ArrayBufferBinding
   | Blend
   | BlendColor
   | BlendDstAlpha
   | BlendDstRGB
   | BlendEquationAlpha
   | BlendEquationRGB
   | BlendSrcAlpha
   | BlendSrcRGB
   | BlueBits
   | ColorClearValue
   | ColorWritemask
   | CompressedTextureFormats
   | CullFace
   | CullFaceMode
   | CurrentProgram
   | DepthBits
   | DepthClearValue
   | DepthFunc
   | DepthRange
   | DepthTest
   | DepthWritemask
   | Dither
   | ElementArrayBufferBinding
   | FramebufferBinding
   | FrontFace
   | GenerateMipmapHint'
   | GreenBits
   | LineWidth
   | MaxCombinedTextureImageUnits
   | MaxCubeMapTextureSize
   | MaxFragmentUniformVectors
   | MaxRenderbufferSize
   | MaxTextureImageUnits
   | MaxTextureSize
   | MaxVaryingVectors
   | MaxVertexAttribs
   | MaxVertexTextureImageUnits
   | MaxVertexUniformVectors
   | MaxViewportDims
   | NumCompressedTextureFormats
   | PackAlignment
   | PolygonOffsetFactor
   | PolygonOffsetFill
   | PolygonOffsetUnits
   | RedBits
   | RenderbufferBinding
   | Renderer
   | SampleBuffers
   | SampleCoverageInvert
   | SampleCoverageValue
   | Samples
   | ScissorBox
   | ScissorTest
   | ShadingLanguageVersion
   | StencilBackFail
   | StencilBackFunc
   | StencilBackPassDepthFail
   | StencilBackPassDepthPass
   | StencilBackRef
   | StencilBackValueMask
   | StencilBackWritemask
   | StencilBits
   | StencilClearValue
   | StencilFail
   | StencilFunc
   | StencilPassDepthFail
   | StencilPassDepthPass
   | StencilRef
   | StencilTest
   | StencilValueMask
   | StencilWritemask
   | SubpixelBits
   | TextureBinding2D
   | TextureBindingCubeMap
   | UnpackAlignment
   | UnpackColorspaceConversionWebGL
   | UnpackFlipYWebGL
   | UnpackPremultiplyAlphaWebGL
   | Vendor
   | Version
   | Viewport

instance MarshallGLEnum Parameter where
    toGLEnum ActiveTexture                   = 0x84E0
    toGLEnum AliasedLineWidthRange           = 0x846E
    toGLEnum AliasedPointSizeRange           = 0x846D
    toGLEnum AlphaBits                       = 0x0D55
    toGLEnum ArrayBufferBinding              = 0x8894
    toGLEnum Blend                           = 0x0BE2
    toGLEnum BlendColor                      = 0x8005
    toGLEnum BlendDstAlpha                   = 0x80CA
    toGLEnum BlendDstRGB                     = 0x80C8
    toGLEnum BlendEquationAlpha              = 0x883D
    toGLEnum BlendEquationRGB                = 0x8009
    toGLEnum BlendSrcAlpha                   = 0x80CB
    toGLEnum BlendSrcRGB                     = 0x80C9
    toGLEnum BlueBits                        = 0x0D54
    toGLEnum ColorClearValue                 = 0x0C22
    toGLEnum ColorWritemask                  = 0x0C23
    toGLEnum CompressedTextureFormats        = 0x86A3
    toGLEnum CullFace                        = 0x0B44
    toGLEnum CullFaceMode                    = 0x0B45
    toGLEnum CurrentProgram                  = 0x8B8D
    toGLEnum DepthBits                       = 0x0D56
    toGLEnum DepthClearValue                 = 0x0B73
    toGLEnum DepthFunc                       = 0x0B74
    toGLEnum DepthRange                      = 0x0B70
    toGLEnum DepthTest                       = 0x0B71
    toGLEnum DepthWritemask                  = 0x0B72
    toGLEnum Dither                          = 0x0BD0
    toGLEnum ElementArrayBufferBinding       = 0x8895
    toGLEnum FramebufferBinding              = 0x8CA6
    toGLEnum FrontFace                       = 0x0B46
    toGLEnum GenerateMipmapHint'             = 0x8192
    toGLEnum GreenBits                       = 0x0D53
    toGLEnum LineWidth                       = 0x0B21
    toGLEnum MaxCombinedTextureImageUnits    = 0x8B4D
    toGLEnum MaxCubeMapTextureSize           = 0x851C
    toGLEnum MaxFragmentUniformVectors       = 0x8DFD
    toGLEnum MaxRenderbufferSize             = 0x84E8
    toGLEnum MaxTextureImageUnits            = 0x8872
    toGLEnum MaxTextureSize                  = 0x0D33
    toGLEnum MaxVaryingVectors               = 0x8DFC
    toGLEnum MaxVertexAttribs                = 0x8869
    toGLEnum MaxVertexTextureImageUnits      = 0x8B4C
    toGLEnum MaxVertexUniformVectors         = 0x8DFB
    toGLEnum MaxViewportDims                 = 0x0D3A
    toGLEnum NumCompressedTextureFormats     = 0x86A2
    toGLEnum PackAlignment                   = 0x0D05
    toGLEnum PolygonOffsetFactor             = 0x8038
    toGLEnum PolygonOffsetFill               = 0x8037
    toGLEnum PolygonOffsetUnits              = 0x2A00
    toGLEnum RedBits                         = 0x0D52
    toGLEnum RenderbufferBinding             = 0x8CA7
    toGLEnum Renderer                        = 0x1F01
    toGLEnum SampleBuffers                   = 0x80A8
    toGLEnum SampleCoverageInvert            = 0x80AB
    toGLEnum SampleCoverageValue             = 0x80AA
    toGLEnum Samples                         = 0x80A9
    toGLEnum ScissorBox                      = 0x0C10
    toGLEnum ScissorTest                     = 0x0C11
    toGLEnum ShadingLanguageVersion          = 0x8B8C
    toGLEnum StencilBackFail                 = 0x8801
    toGLEnum StencilBackFunc                 = 0x8800
    toGLEnum StencilBackPassDepthFail        = 0x8802
    toGLEnum StencilBackPassDepthPass        = 0x8803
    toGLEnum StencilBackRef                  = 0x8CA3
    toGLEnum StencilBackValueMask            = 0x8CA4
    toGLEnum StencilBackWritemask            = 0x8CA5
    toGLEnum StencilBits                     = 0x0D57
    toGLEnum StencilClearValue               = 0x0B91
    toGLEnum StencilFail                     = 0x0B94
    toGLEnum StencilFunc                     = 0x0B92
    toGLEnum StencilPassDepthFail            = 0x0B95
    toGLEnum StencilPassDepthPass            = 0x0B96
    toGLEnum StencilRef                      = 0x0B97
    toGLEnum StencilTest                     = 0x0B90
    toGLEnum StencilValueMask                = 0x0B93
    toGLEnum StencilWritemask                = 0x0B98
    toGLEnum SubpixelBits                    = 0x0D50
    toGLEnum TextureBinding2D                = 0x8069
    toGLEnum TextureBindingCubeMap           = 0x8514
    toGLEnum UnpackAlignment                 = 0x0CF5
    toGLEnum UnpackColorspaceConversionWebGL = 0x9243
    toGLEnum UnpackFlipYWebGL                = 0x9240
    toGLEnum UnpackPremultiplyAlphaWebGL     = 0x9241
    toGLEnum Vendor                          = 0x1F00
    toGLEnum Version                         = 0x1F02
    toGLEnum Viewport                        = 0x0BA2

    fromGLEnum 0x84E0 = Just ActiveTexture
    fromGLEnum 0x846E = Just AliasedLineWidthRange
    fromGLEnum 0x846D = Just AliasedPointSizeRange
    fromGLEnum 0x0D55 = Just AlphaBits
    fromGLEnum 0x8894 = Just ArrayBufferBinding
    fromGLEnum 0x0BE2 = Just Blend
    fromGLEnum 0x8005 = Just BlendColor
    fromGLEnum 0x80CA = Just BlendDstAlpha
    fromGLEnum 0x80C8 = Just BlendDstRGB
    fromGLEnum 0x883D = Just BlendEquationAlpha
    fromGLEnum 0x8009 = Just BlendEquationRGB
    fromGLEnum 0x80CB = Just BlendSrcAlpha
    fromGLEnum 0x80C9 = Just BlendSrcRGB
    fromGLEnum 0x0D54 = Just BlueBits
    fromGLEnum 0x0C22 = Just ColorClearValue
    fromGLEnum 0x0C23 = Just ColorWritemask
    fromGLEnum 0x86A3 = Just CompressedTextureFormats
    fromGLEnum 0x0B44 = Just CullFace
    fromGLEnum 0x0B45 = Just CullFaceMode
    fromGLEnum 0x8B8D = Just CurrentProgram
    fromGLEnum 0x0D56 = Just DepthBits
    fromGLEnum 0x0B73 = Just DepthClearValue
    fromGLEnum 0x0B74 = Just DepthFunc
    fromGLEnum 0x0B70 = Just DepthRange
    fromGLEnum 0x0B71 = Just DepthTest
    fromGLEnum 0x0B72 = Just DepthWritemask
    fromGLEnum 0x0BD0 = Just Dither
    fromGLEnum 0x8895 = Just ElementArrayBufferBinding
    fromGLEnum 0x8CA6 = Just FramebufferBinding
    fromGLEnum 0x0B46 = Just FrontFace
    fromGLEnum 0x8192 = Just GenerateMipmapHint'
    fromGLEnum 0x0D53 = Just GreenBits
    fromGLEnum 0x0B21 = Just LineWidth
    fromGLEnum 0x8B4D = Just MaxCombinedTextureImageUnits
    fromGLEnum 0x851C = Just MaxCubeMapTextureSize
    fromGLEnum 0x8DFD = Just MaxFragmentUniformVectors
    fromGLEnum 0x84E8 = Just MaxRenderbufferSize
    fromGLEnum 0x8872 = Just MaxTextureImageUnits
    fromGLEnum 0x0D33 = Just MaxTextureSize
    fromGLEnum 0x8DFC = Just MaxVaryingVectors
    fromGLEnum 0x8869 = Just MaxVertexAttribs
    fromGLEnum 0x8B4C = Just MaxVertexTextureImageUnits
    fromGLEnum 0x8DFB = Just MaxVertexUniformVectors
    fromGLEnum 0x0D3A = Just MaxViewportDims
    fromGLEnum 0x86A2 = Just NumCompressedTextureFormats
    fromGLEnum 0x0D05 = Just PackAlignment
    fromGLEnum 0x8038 = Just PolygonOffsetFactor
    fromGLEnum 0x8037 = Just PolygonOffsetFill
    fromGLEnum 0x2A00 = Just PolygonOffsetUnits
    fromGLEnum 0x0D52 = Just RedBits
    fromGLEnum 0x8CA7 = Just RenderbufferBinding
    fromGLEnum 0x1F01 = Just Renderer
    fromGLEnum 0x80A8 = Just SampleBuffers
    fromGLEnum 0x80AB = Just SampleCoverageInvert
    fromGLEnum 0x80AA = Just SampleCoverageValue
    fromGLEnum 0x80A9 = Just Samples
    fromGLEnum 0x0C10 = Just ScissorBox
    fromGLEnum 0x0C11 = Just ScissorTest
    fromGLEnum 0x8B8C = Just ShadingLanguageVersion
    fromGLEnum 0x8801 = Just StencilBackFail
    fromGLEnum 0x8800 = Just StencilBackFunc
    fromGLEnum 0x8802 = Just StencilBackPassDepthFail
    fromGLEnum 0x8803 = Just StencilBackPassDepthPass
    fromGLEnum 0x8CA3 = Just StencilBackRef
    fromGLEnum 0x8CA4 = Just StencilBackValueMask
    fromGLEnum 0x8CA5 = Just StencilBackWritemask
    fromGLEnum 0x0D57 = Just StencilBits
    fromGLEnum 0x0B91 = Just StencilClearValue
    fromGLEnum 0x0B94 = Just StencilFail
    fromGLEnum 0x0B92 = Just StencilFunc
    fromGLEnum 0x0B95 = Just StencilPassDepthFail
    fromGLEnum 0x0B96 = Just StencilPassDepthPass
    fromGLEnum 0x0B97 = Just StencilRef
    fromGLEnum 0x0B90 = Just StencilTest
    fromGLEnum 0x0B93 = Just StencilValueMask
    fromGLEnum 0x0B98 = Just StencilWritemask
    fromGLEnum 0x0D50 = Just SubpixelBits
    fromGLEnum 0x8069 = Just TextureBinding2D
    fromGLEnum 0x8514 = Just TextureBindingCubeMap
    fromGLEnum 0x0CF5 = Just UnpackAlignment
    fromGLEnum 0x9243 = Just UnpackColorspaceConversionWebGL
    fromGLEnum 0x9240 = Just UnpackFlipYWebGL
    fromGLEnum 0x9241 = Just UnpackPremultiplyAlphaWebGL
    fromGLEnum 0x1F00 = Just Vendor
    fromGLEnum 0x1F02 = Just Version
    fromGLEnum 0x0BA2 = Just Viewport
    fromGLEnum _      = Nothing

instance MarshallToJType Parameter where
    toJType ActiveTexture                   = JEnum TextureUnit fromGLEnum toGLEnum
    toJType AliasedLineWidthRange           = JFloat32Array -- 2 Float
    toJType AliasedPointSizeRange           = JFloat32Array -- 2 Float
    toJType AlphaBits                       = JInt
    toJType ArrayBufferBinding              = JBuffer
    toJType Blend                           = JBool
    toJType BlendColor                      = JFloat32Array -- 4 Flaot
    toJType BlendDstAlpha                   = JEnum BlendFunc     fromGLEnum toGLEnum
    toJType BlendDstRGB                     = JEnum BlendFunc     fromGLEnum toGLEnum
    toJType BlendEquationAlpha              = JEnum BlendEquation fromGLEnum toGLEnum
    toJType BlendEquationRGB                = JEnum BlendEquation fromGLEnum toGLEnum
    toJType BlendSrcAlpha                   = JEnum BlendFunc     fromGLEnum toGLEnum
    toJType BlendSrcRGB                     = JEnum BlendFunc     fromGLEnum toGLEnum
    toJType BlueBits                        = JInt
    toJType ColorClearValue                 = JFloat32Array -- 4 Float
    toJType ColorWritemask                  = JBool         -- 4 Bool
    toJType CompressedTextureFormats        = JUnit -- List TextureFormat
    toJType CullFace                        = JBool
    toJType CullFaceMode                    = JEnum Face fromGLEnum toGLEnum
    toJType CurrentProgram                  = JProgram
    toJType DepthBits                       = JInt
    toJType DepthClearValue                 = JFloat
    toJType DepthFunc                       = JEnum RelationFunc fromGLEnum toGLEnum
    toJType DepthRange                      = JFloat32Array
    toJType DepthTest                       = JBool
    toJType DepthWritemask                  = JBool
    toJType Dither                          = JBool
    toJType ElementArrayBufferBinding       = JBuffer
    toJType FramebufferBinding              = JFramebuffer
    toJType FrontFace                       = JEnum FrontFaceMode fromGLEnum toGLEnum
    toJType GenerateMipmapHint'             = JEnum HintTarget fromGLEnum toGLEnum
    toJType GreenBits                       = JInt
    toJType LineWidth                       = JFloat
    toJType MaxCombinedTextureImageUnits    = JInt
    toJType MaxCubeMapTextureSize           = JInt
    toJType MaxFragmentUniformVectors       = JInt
    toJType MaxRenderbufferSize             = JInt
    toJType MaxTextureImageUnits            = JInt
    toJType MaxTextureSize                  = JInt
    toJType MaxVaryingVectors               = JInt
    toJType MaxVertexAttribs                = JInt
    toJType MaxVertexTextureImageUnits      = JInt
    toJType MaxVertexUniformVectors         = JInt
    toJType MaxViewportDims                 = JInt32Array
    toJType NumCompressedTextureFormats     = JInt
    toJType PackAlignment                   = JInt
    toJType PolygonOffsetFactor             = JFloat
    toJType PolygonOffsetFill               = JBool
    toJType PolygonOffsetUnits              = JFloat
    toJType RedBits                         = JInt
    toJType RenderbufferBinding             = JRenderbuffer
    toJType Renderer                        = JString
    toJType SampleBuffers                   = JInt
    toJType SampleCoverageInvert            = JBool
    toJType SampleCoverageValue             = JFloat
    toJType Samples                         = JInt
    toJType ScissorBox                      = JInt32Array
    toJType ScissorTest                     = JBool
    toJType ShadingLanguageVersion          = JString
    toJType StencilBackFail                 = JEnum StencilOp fromGLEnum toGLEnum
    toJType StencilBackFunc                 = JEnum RelationFunc fromGLEnum toGLEnum
    toJType StencilBackPassDepthFail        = JEnum StencilOp fromGLEnum toGLEnum
    toJType StencilBackPassDepthPass        = JEnum StencilOp fromGLEnum toGLEnum
    toJType StencilBackRef                  = JInt
    toJType StencilBackValueMask            = JInt
    toJType StencilBackWritemask            = JInt
    toJType StencilBits                     = JInt
    toJType StencilClearValue               = JInt
    toJType StencilFail                     = JEnum StencilOp fromGLEnum toGLEnum
    toJType StencilFunc                     = JEnum RelationFunc fromGLEnum toGLEnum
    toJType StencilPassDepthFail            = JEnum StencilOp fromGLEnum toGLEnum
    toJType StencilPassDepthPass            = JEnum StencilOp fromGLEnum toGLEnum
    toJType StencilRef                      = JInt
    toJType StencilTest                     = JBool
    toJType StencilValueMask                = JInt
    toJType StencilWritemask                = JInt
    toJType SubpixelBits                    = JInt
    toJType TextureBinding2D                = JTexture
    toJType TextureBindingCubeMap           = JTexture
    toJType UnpackAlignment                 = JInt
    toJType UnpackColorspaceConversionWebGL = JInt
    toJType UnpackFlipYWebGL                = JBool
    toJType UnpackPremultiplyAlphaWebGL     = JBool
    toJType Vendor                          = JString
    toJType Version                         = JString
    toJType Viewport                        = JInt32Array -- 4 Int

public
getParameter : Context -> (pname : Parameter) -> IO (interpJRetType (toJType pname))
getParameter (MkContext context) pname = map (unpackType pname) $ mkForeign
    (FFun "%0.getParameter(%1)"
    [FPtr, FEnum] (JTypeToFType pname))
    context (toGLEnum pname)

