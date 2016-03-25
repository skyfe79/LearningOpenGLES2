uniform highp mat4 u_ModelViewMatrix;
uniform highp mat4 u_ProjectionMatrix;

attribute vec4 a_Position;
attribute vec4 a_Color;
attribute vec2 a_TexCoord;

varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;

void main(void) {
    frag_Color = a_Color;
    frag_TexCoord = a_TexCoord;
    gl_Position = u_ProjectionMatrix * u_ModelViewMatrix * a_Position;
}