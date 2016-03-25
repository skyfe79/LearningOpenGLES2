uniform sampler2D u_Texture;

varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;

void main(void) {
    gl_FragColor = frag_Color * texture2D(u_Texture, frag_TexCoord);
}