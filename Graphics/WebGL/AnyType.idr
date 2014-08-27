module Graphics.WebGL.AnyType

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

----------------------------------------------------------------------

mutual
 public
 data JType : Type where
      JUnit         : JType
      JBool         : JType
      JInt          : JType
      JFloat        : JType
      JString       : JType
      JInt32Array   : JType
      JFloat32Array : JType
      JBuffer       : JType
      JFramebuffer  : JType
      JRenderbuffer : JType
      JTexture      : JType
      JProgram      : JType
      JEnum         : (t : Type) -> (Int -> Maybe t) -> (t -> Int) -> JType
      -- Why doesn't this work?
      -- JEnum         : MarshallGLEnum t => (t : Type) -> JType

 public
 class MarshallToJType a where
     total
     toJType : a -> JType

total public
interpJType : JType -> Type
interpJType JUnit         = ()
interpJType JBool         = Bool
interpJType JInt          = Int
interpJType JFloat        = Float
interpJType JString       = String
interpJType JInt32Array   = Int32Array
interpJType JFloat32Array = Float32Array
interpJType JBuffer       = Buffer
interpJType JFramebuffer  = Framebuffer
interpJType JRenderbuffer = Renderbuffer
interpJType JTexture      = Texture
interpJType JProgram      = Program
interpJType (JEnum t _ _) = t

total public
interpJRetType : JType -> Type
interpJRetType JUnit         = ()
interpJRetType JBool         = Bool
interpJRetType JInt          = Int
interpJRetType JFloat        = Float
interpJRetType JString       = String
interpJRetType JInt32Array   = Int32Array
interpJRetType JFloat32Array = Float32Array
interpJRetType JBuffer       = Buffer
interpJRetType JFramebuffer  = Framebuffer
interpJRetType JRenderbuffer = Renderbuffer
interpJRetType JTexture      = Texture
interpJRetType JProgram      = Program
interpJRetType (JEnum t _ _) = Maybe t

total public
toFType : JType -> FTy
toFType JUnit         = FUnit
toFType JBool         = FBool
toFType JInt          = FInt
toFType JFloat        = FFloat
toFType JString       = FString
toFType JInt32Array   = FPtr
toFType JFloat32Array = FPtr
toFType JBuffer       = FPtr
toFType JFramebuffer  = FPtr
toFType JRenderbuffer = FPtr
toFType JTexture      = FPtr
toFType JProgram      = FPtr
toFType (JEnum _ _ _) = FEnum

total public
JTypeToFType : MarshallToJType a => a -> FTy
JTypeToFType a = toFType (toJType a)

total private
UType : JType -> Type
UType a = interpFTy (toFType a) -> interpJRetType a
total public
unpackType : MarshallToJType t => (a : t) -> UType (toJType a)
unpackType a = unpackJType (toJType a)
  where
    total
    unpackJType : (a : JType) -> UType a
    unpackJType JUnit         = id
    unpackJType JBool         = fromGLBool
    unpackJType JInt          = id
    unpackJType JFloat        = id
    unpackJType JString       = id
    unpackJType JInt32Array   = MkInt32Array
    unpackJType JFloat32Array = MkFloat32Array
    unpackJType JBuffer       = MkBuffer
    unpackJType JFramebuffer  = MkFramebuffer
    unpackJType JRenderbuffer = MkRenderbuffer
    unpackJType JTexture      = MkTexture
    unpackJType JProgram      = MkProgram
    unpackJType (JEnum _ f _) = f

total private
PType : JType -> Type
PType a = interpJType a -> interpFTy (toFType a)
total public
packType : MarshallToJType t => (a : t) -> PType (toJType a)
packType a = packJType (toJType a)
  where
    total
    packJType : (a : JType) -> PType a
    packJType JUnit         = id
    packJType JBool         = toGLBool
    packJType JInt          = id
    packJType JFloat        = id
    packJType JString       = id
    packJType JInt32Array   = \(MkInt32Array   p) => p
    packJType JFloat32Array = \(MkFloat32Array p) => p
    packJType JBuffer       = \(MkBuffer       p) => p
    packJType JFramebuffer  = \(MkFramebuffer  p) => p
    packJType JRenderbuffer = \(MkRenderbuffer p) => p
    packJType JTexture      = \(MkTexture      p) => p
    packJType JProgram      = \(MkProgram      p) => p
    packJType (JEnum _ _ g) = g

