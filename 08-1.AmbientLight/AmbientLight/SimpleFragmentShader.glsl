uniform sampler2D u_Texture;

varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;

struct Light {
    lowp vec3 Color;
    lowp float AmbientIntensity;
};
uniform Light u_Light;

void main(void) {
    
    // Ambient
    lowp vec4 AmbientColor = vec4(u_Light.Color, 1.0) * u_Light.AmbientIntensity;
    gl_FragColor = texture2D(u_Texture, frag_TexCoord) * AmbientColor;
}