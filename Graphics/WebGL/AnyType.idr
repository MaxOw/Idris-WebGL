module Graphics.WebGL.AnyType

import Graphics.WebGL.Types
import Graphics.WebGL.Utils

----------------------------------------------------------------------

mutual
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
      JEnum         : (t : Type) -> (Int -> t) -> JType

 class MarshallToJType a where
     toJType : a -> JType

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
interpJType (JEnum t _)   = t

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
toFType (JEnum _ _)   = FEnum

unpackType : (a : JType) -> (interpFTy (toFType a) -> interpJType a)
unpackType JUnit         = id
unpackType JBool         = fromGLBool
unpackType JInt          = id
unpackType JFloat        = id
unpackType JString       = id
unpackType JInt32Array   = MkInt32Array  
unpackType JFloat32Array = MkFloat32Array
unpackType JBuffer       = MkBuffer      
unpackType JFramebuffer  = MkFramebuffer 
unpackType JRenderbuffer = MkRenderbuffer
unpackType JTexture      = MkTexture     
unpackType JProgram      = MkProgram     
unpackType (JEnum _ f)   = f
