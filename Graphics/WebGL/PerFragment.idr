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

    fromGLEnum 0x8006 = Just FuncAdd
    fromGLEnum 0x800A = Just FuncSubtract
    fromGLEnum 0x800B = Just FuncReverseSubtract
    fromGLEnum _      = Nothing

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

    fromGLEnum 0 = Just Zero
    fromGLEnum 1 = Just One
    fromGLEnum 0x0300 = Just SrcColor
    fromGLEnum 0x0301 = Just OneMinusSrcColor
    fromGLEnum 0x0302 = Just SrcAlpha
    fromGLEnum 0x0303 = Just OneMinusSrcAlpha
    fromGLEnum 0x0304 = Just DstAlpha
    fromGLEnum 0x0305 = Just OneMinusDstAlpha
    fromGLEnum 0x0306 = Just DstColor
    fromGLEnum 0x0307 = Just OneMinusDstColor
    fromGLEnum 0x0308 = Just SrcAlphaSaturate
    fromGLEnum 0x8001 = Just ConstantColor
    fromGLEnum 0x8002 = Just OneMinusConstantColor
    fromGLEnum 0x8003 = Just ConstantAlpha
    fromGLEnum 0x8004 = Just OneMinusConstantAlpha
    fromGLEnum _      = Nothing

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

    fromGLEnum 0x0200 = Just Never
    fromGLEnum 0x0201 = Just Less
    fromGLEnum 0x0202 = Just Equal
    fromGLEnum 0x0203 = Just LEqual
    fromGLEnum 0x0204 = Just Greater
    fromGLEnum 0x0205 = Just NotEqual
    fromGLEnum 0x0206 = Just GEqual
    fromGLEnum 0x0207 = Just Always
    fromGLEnum _      = Nothing

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

    fromGLEnum 0      = Just OpZero
    fromGLEnum 0x1E00 = Just OpKeep
    fromGLEnum 0x1E01 = Just OpReplace
    fromGLEnum 0x1E02 = Just OpIncr
    fromGLEnum 0x1E03 = Just OpDecr
    fromGLEnum 0x150A = Just OpInvert
    fromGLEnum 0x8507 = Just OpIncrWrap
    fromGLEnum 0x8508 = Just OpDecrWrap
    fromGLEnum _      = Nothing

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

