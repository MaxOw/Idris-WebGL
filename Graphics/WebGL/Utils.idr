module Graphics.WebGL.Utils

FEnum : FTy
FEnum = FInt

FBool : FTy
FBool = FInt

toGLBool : Bool -> interpFTy FBool
toGLBool x = if x then 1 else 0

fromGLBool : interpFTy FBool -> Bool
fromGLBool x = x /= 0

class MarshallGLEnum a where
    toGLEnum : a -> interpFTy FEnum
    fromGLEnum : interpFTy FEnum -> a

----------------------------------------------------------------------

infixr 1 =<<
(=<<) : Monad m => (a -> m b) -> m a -> m b
(=<<) = flip (>>=)

infixl 5 .|.
(.|.) : Int -> Int -> Int
(.|.) a b = prim__orInt a b

infixl 7 .&.
(.&.) : Int -> Int -> Int
(.&.) a b = prim__andInt a b

