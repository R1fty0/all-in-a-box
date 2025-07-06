shader_type spatial;
render_mode unshaded;

uniform sampler2D magnify_tex;
uniform vec2 center = vec2(0.5);
uniform float radius = 0.5;
uniform float strength = 0.3;

void fragment() {
    vec2 uv = UV;
    vec2 offset = uv - center;
    float dist = length(offset);

    if (dist < radius) {
        float factor = 1.0 + strength * (1.0 - dist / radius);
        uv = center + offset * factor;
    }

    ALBEDO = texture(magnify_tex, uv).rgb;
}