module Main

import Graphics.WebGL

vsrc : String
vsrc = 
 "attribute vec2 pos; \
 \uniform float offx; \
 \void main() { gl_Position = vec4(pos.x+offx, pos.y, 0, 1); }"

fsrc : String
fsrc = "void main() { gl_FragColor = vec4(0,1,0,1); }"

verts : List Float
verts = [-0.5, -0.5, 0.5, -0.5, 0, 0.5]

buildShader : Context -> ShaderType -> String -> IO Shader
buildShader c t src = do
    s <- createShader c t
    shaderSource c s src
    compileShader c s
    return s

buildProgram : Context -> String -> String -> IO Program
buildProgram c vsrc fsrc = do
    prog <- createProgram c

    vs <- buildShader c VertexShader vsrc
    attachShader c prog vs
    fs <- buildShader c FragmentShader fsrc
    attachShader c prog fs

    linkProgram c prog
    return prog

bufferFromArray : Context -> Float32Array -> IO ()
bufferFromArray c farr = do
    buf <- createBuffer c
    bindBuffer c ArrayBufferTarget buf
    bufferData c ArrayBufferTarget farr StaticDraw
        
mainLoop : Context -> UniformLocation -> Float -> IO Float
mainLoop c offx v = do
    clearColor c 1 0 0 1
    clear c [ColorBuffer]
    uniform1f c offx v
    drawArrays c Triangles 0 3
    return $ if (v > 1.5) then -1.5 else v + 0.01

main : IO ()
main = do
    canvas <- getElemById "main"
    c <- getContext canvas
    arr <- arrayFromList verts
    farr <- newFloat32Array arr

    bufferFromArray c farr

    prog <- buildProgram c vsrc fsrc
    useProgram c prog

    pos <- getAttribLocation c prog "pos"
    offx <- getUniformLocation c prog "offx"
    enableVertexAttribArray c pos
    vertexAttribPointer c pos 2 AttribFloat False 0 0

    initMainLoop (mainLoop c offx) 0
