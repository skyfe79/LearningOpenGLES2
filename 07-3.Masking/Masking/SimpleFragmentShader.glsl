uniform sampler2D u_Texture;
uniform sampler2D u_Mask;

varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;

void main(void) {
    lowp vec4 texColor = texture2D(u_Texture, frag_TexCoord);
    lowp vec4 maskColor = texture2D(u_Mask, frag_TexCoord);
    gl_FragColor = vec4(texColor.r, texColor.g, texColor.b, maskColor.a * texColor.a);
}