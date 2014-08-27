module Graphics.WebGL.Utils

public
FEnum : FTy
FEnum = FInt

public
FBool : FTy
FBool = FInt

public total
toGLBool : Bool -> interpFTy FBool
toGLBool x = if x then 1 else 0

public total
fromGLBool : interpFTy FBool -> Bool
fromGLBool x = x /= 0

public
class MarshallGLEnum a where
    total
    toGLEnum : a -> interpFTy FEnum
    total
    fromGLEnum : interpFTy FEnum -> Maybe a

----------------------------------------------------------------------

infixr 1 =<<
public
(=<<) : Monad m => (a -> m b) -> m a -> m b
(=<<) = flip (>>=)

infixl 5 .|.
public
(.|.) : Int -> Int -> Int
(.|.) a b = prim__orInt a b

infixl 7 .&.
public
(.&.) : Int -> Int -> Int
(.&.) a b = prim__andInt a b

----------------------------------------------------------------------
-- Ghetto IORefs

abstract
data IORef a = MkIORef Int

private
gvarName : String
gvarName = "__IDRIS__IOREF__"

private
initgvar : IO a -> IO a
initgvar act = do
  o <- mkForeign (FFun ("typeof " ++ gvarName) [] FString) 
  when (o /= "object") $
    mkForeign (FFun (gvarName ++ " = new Array()") [] FUnit)
  act

public
writeIORef : {a : Type} -> IORef a -> a -> IO ()
writeIORef {a} (MkIORef ct) v = initgvar $
    mkForeign (FFun (gvarName ++ "[%0] = %1")
    [FInt, FAny a] FUnit)
    ct v

public
newIORef : a -> IO (IORef a)
newIORef v = initgvar $ do
    r <- map MkIORef $ mkForeign (FFun (gvarName ++ ".length") [] FInt)
    writeIORef r v
    return r

public
readIORef : {a : Type} -> IORef a -> IO a
readIORef {a} (MkIORef ct) = initgvar $
    mkForeign (FFun (gvarName ++ "[%0]")
    [FInt] (FAny a))
    ct

