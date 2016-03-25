attribute vec4 a_Position;
attribute vec4 a_Color;

varying lowp vec4 frag_Color;

void main(void) {
    frag_Color = a_Color;
    gl_Position = a_Position;
}