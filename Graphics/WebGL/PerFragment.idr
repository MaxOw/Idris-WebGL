module Graphics.WebGL.Functions

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

-- Per-Fragment Operations (section 5.13.3)
-- https://www.khronos.org/registry/webgl/specs/1.0.0/#5.13.3

----------------------------------------------------------------------

public
blendColor : Context -> Float -> Float -> Float -> Float -> IO ()
blendColor (MkContext context) red green blue alpha = mkForeign
    (FFun "%0.blendColor(%1, %2, %3, %4)"
    [FPtr, FFloat, FFloat, FFloat, FFloat] FUnit)
    context red green blue alpha

----------------------------------------------------------------------

public
data BlendEquation
   = FuncAdd
   | FuncSubtract
   | FuncReverseSubtract
instance MarshallGLEnum BlendEquation where
    toGLEnum FuncAdd                        = 0x8006
    toGLEnum FuncSubtract                   = 0x800A
    toGLEnum FuncReverseSubtract            = 0x800B

    fromGLEnum 0x8006 = FuncAdd
    fromGLEnum 0x800A = FuncSubtract
    fromGLEnum 0x800B = FuncReverseSubtract

public
blendEquation : Context -> BlendEquation -> IO ()
blendEquation (MkContext context) mode = mkForeign
    (FFun "%0.blendEquation(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum mode)

----------------------------------------------------------------------

public
data BlendFunc
   = Zero
   | One
   | SrcColor
   | OneMinusSrcColor
   | SrcAlpha
   | OneMinusSrcAlpha
   | DstAlpha
   | OneMinusDstAlpha
   | DstColor
   | OneMinusDstColor
   | SrcAlphaSaturate
   | ConstantColor
   | OneMinusConstantColor
   | ConstantAlpha
   | OneMinusConstantAlpha

instance MarshallGLEnum BlendFunc where
    toGLEnum Zero                           = 0
    toGLEnum One                            = 1
    toGLEnum SrcColor                       = 0x0300
    toGLEnum OneMinusSrcColor               = 0x0301
    toGLEnum SrcAlpha                       = 0x0302
    toGLEnum OneMinusSrcAlpha               = 0x0303
    toGLEnum DstAlpha                       = 0x0304
    toGLEnum OneMinusDstAlpha               = 0x0305
    toGLEnum DstColor                       = 0x0306
    toGLEnum OneMinusDstColor               = 0x0307
    toGLEnum SrcAlphaSaturate               = 0x0308
    toGLEnum ConstantColor                  = 0x8001
    toGLEnum OneMinusConstantColor          = 0x8002
    toGLEnum ConstantAlpha                  = 0x8003
    toGLEnum OneMinusConstantAlpha          = 0x8004

    fromGLEnum 0 = Zero
    fromGLEnum 1 = One
    fromGLEnum 0x0300 = SrcColor
    fromGLEnum 0x0301 = OneMinusSrcColor
    fromGLEnum 0x0302 = SrcAlpha
    fromGLEnum 0x0303 = OneMinusSrcAlpha
    fromGLEnum 0x0304 = DstAlpha
    fromGLEnum 0x0305 = OneMinusDstAlpha
    fromGLEnum 0x0306 = DstColor
    fromGLEnum 0x0307 = OneMinusDstColor
    fromGLEnum 0x0308 = SrcAlphaSaturate
    fromGLEnum 0x8001 = ConstantColor
    fromGLEnum 0x8002 = OneMinusConstantColor
    fromGLEnum 0x8003 = ConstantAlpha
    fromGLEnum 0x8004 = OneMinusConstantAlpha

public
blendEquationSeparate : Context -> BlendEquation -> BlendEquation -> IO ()
blendEquationSeparate (MkContext context) modeRGB modeAlpha = mkForeign
    (FFun "%0.blendEquationSeparate(%1, %2)"
    [FPtr, FEnum, FEnum] FUnit)
    context (toGLEnum modeRGB) (toGLEnum modeAlpha)

----------------------------------------------------------------------

public
blendFunc : Context -> BlendFunc -> BlendFunc -> IO ()
blendFunc (MkContext context) sfactor dfactor = mkForeign
    (FFun "%0.blendFunc(%1, %2)"
    [FPtr, FEnum, FEnum] FUnit)
    context (toGLEnum sfactor) (toGLEnum dfactor)

----------------------------------------------------------------------

public
blendFuncSeparate : Context -> BlendFunc -> BlendFunc -> BlendFunc -> BlendFunc -> IO ()
blendFuncSeparate (MkContext context) srcRGB dstRGB srcAlpha dstAlpha = mkForeign
    (FFun "%0.blendFuncSeparate(%1, %2, %3, %4)"
    [FPtr, FEnum, FEnum, FEnum, FEnum] FUnit)
    context (toGLEnum srcRGB) (toGLEnum dstRGB) (toGLEnum srcAlpha) (toGLEnum dstAlpha)

----------------------------------------------------------------------

public
data RelationFunc
   = Never
   | Less
   | Equal
   | LEqual
   | Greater
   | NotEqual
   | GEqual
   | Always

instance MarshallGLEnum RelationFunc where
    toGLEnum Never                          = 0x0200
    toGLEnum Less                           = 0x0201
    toGLEnum Equal                          = 0x0202
    toGLEnum LEqual                         = 0x0203
    toGLEnum Greater                        = 0x0204
    toGLEnum NotEqual                       = 0x0205
    toGLEnum GEqual                         = 0x0206
    toGLEnum Always                         = 0x0207

    fromGLEnum 0x0200 = Never
    fromGLEnum 0x0201 = Less
    fromGLEnum 0x0202 = Equal
    fromGLEnum 0x0203 = LEqual
    fromGLEnum 0x0204 = Greater
    fromGLEnum 0x0205 = NotEqual
    fromGLEnum 0x0206 = GEqual
    fromGLEnum 0x0207 = Always

public
depthFunc : Context -> RelationFunc -> IO ()
depthFunc (MkContext context) func = mkForeign
    (FFun "%0.depthFunc(%1)"
    [FPtr, FEnum] FUnit)
    context (toGLEnum func)

----------------------------------------------------------------------

public
sampleCoverage : Context -> Float -> Bool -> IO ()
sampleCoverage (MkContext context) value invert = mkForeign
    (FFun "%0.sampleCoverage(%1, %2)"
    [FPtr, FFloat, FBool] FUnit)
    context value (toGLBool invert)

----------------------------------------------------------------------

public
stencilFunc : Context -> RelationFunc -> Int -> Int -> IO ()
stencilFunc (MkContext context) func ref mask = mkForeign
    (FFun "%0.stencilFunc(%1, %2, %3)"
    [FPtr, FEnum, FInt, FInt] FUnit)
    context (toGLEnum func) ref mask

----------------------------------------------------------------------

public
stencilFuncSeparate : Context -> Face -> RelationFunc -> Int -> Int -> IO ()
stencilFuncSeparate (MkContext context) face func ref mask = mkForeign
    (FFun "%0.stencilFuncSeparate(%1, %2, %3, %4)"
    [FPtr, FEnum, FEnum, FInt, FInt] FUnit)
    context (toGLEnum face) (toGLEnum func) ref mask

----------------------------------------------------------------------

public
data StencilOp
   = OpZero
   | OpKeep
   | OpReplace
   | OpIncr
   | OpDecr
   | OpInvert
   | OpIncrWrap
   | OpDecrWrap

instance MarshallGLEnum StencilOp where
    toGLEnum OpZero                           = 0
    toGLEnum OpKeep                           = 0x1E00
    toGLEnum OpReplace                        = 0x1E01
    toGLEnum OpIncr                           = 0x1E02
    toGLEnum OpDecr                           = 0x1E03
    toGLEnum OpInvert                         = 0x150A
    toGLEnum OpIncrWrap                       = 0x8507
    toGLEnum OpDecrWrap                       = 0x8508

    fromGLEnum 0      = OpZero
    fromGLEnum 0x1E00 = OpKeep
    fromGLEnum 0x1E01 = OpReplace
    fromGLEnum 0x1E02 = OpIncr
    fromGLEnum 0x1E03 = OpDecr
    fromGLEnum 0x150A = OpInvert
    fromGLEnum 0x8507 = OpIncrWrap
    fromGLEnum 0x8508 = OpDecrWrap

public
stencilOp : Context -> StencilOp -> StencilOp -> StencilOp -> IO ()
stencilOp (MkContext context) fail zfail zpass = mkForeign
    (FFun "%0.stencilOp(%1, %2, %3)"
    [FPtr, FEnum, FEnum, FEnum] FUnit)
    context (toGLEnum fail) (toGLEnum zfail) (toGLEnum zpass)

----------------------------------------------------------------------

public
stencilOpSeparate : Context -> Face -> StencilOp -> StencilOp -> StencilOp -> IO ()
stencilOpSeparate (MkContext context) face fail zfail zpass = mkForeign
    (FFun "%0.stencilOpSeparate(%1, %2, %3, %4)"
    [FPtr, FEnum, FEnum, FEnum, FEnum] FUnit)
    context (toGLEnum face) (toGLEnum fail) (toGLEnum zfail) (toGLEnum zpass)

