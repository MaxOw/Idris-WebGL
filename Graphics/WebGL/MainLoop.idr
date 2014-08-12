module Graphics.WebGL.MainLoop

import Graphics.WebGL.Utils

----------------------------------------------------------------------

public
requestAnimFrame : IO () -> IO ()
requestAnimFrame f = mkForeign
    (FFun ("window.requestAnimationFrame(%0)")
    [FFunction FUnit (FAny (IO ()))] FUnit) (\() => f)

public
initMainLoop : (a -> IO a) -> a -> IO ()
initMainLoop f a = do
    ref <- newIORef a
    loop ref f
  where
    loop : {a : Type} -> IORef a -> (a -> IO a) -> IO ()
    loop ref f = do
        readIORef ref >>= f >>= writeIORef ref
        requestAnimFrame (loop ref f) 


