//https://en.wikipedia.org/wiki/Grayscale#Luma_coding_in_video_systems
//https://en.wikipedia.org/wiki/Luma_(video)
//vec3 BT601 = vec3(0.299, 0.587, 0.114);
//vec3 BT709 = vec3(0.2126, 0.7152, 0.0722);
//vec3 BT2100 = vec3(0.2627, 0.6780, 0.0593);

const vec3 Luma = vec3(0.2126, 0.7152, 0.0722);

float GetLuminance(vec3 color)
{
    return dot(color, Luma);
}


