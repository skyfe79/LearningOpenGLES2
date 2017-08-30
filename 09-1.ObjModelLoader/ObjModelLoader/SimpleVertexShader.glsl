uniform highp mat4 u_ModelViewMatrix;
uniform highp mat4 u_ProjectionMatrix;

attribute vec4 a_Position;
attribute vec4 a_Color;
attribute vec2 a_TexCoord;
attribute vec3 a_Normal;

varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;
varying lowp vec3 frag_Normal;
varying lowp vec3 frag_Position;

void main(void) {
    frag_Color = a_Color;
    frag_TexCoord = a_TexCoord;
    frag_Normal = (u_ModelViewMatrix * vec4(a_Normal, 0.0)).xyz;
    frag_Position = (u_ModelViewMatrix * a_Position).xyz;
    gl_Position = u_ProjectionMatrix * u_ModelViewMatrix * a_Position;
}