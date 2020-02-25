#ifdef COMPILEPS
vec4 Gradient4(float input, vec4 color1, vec4 color2, vec4 color3, vec4 color4, float split1, float split2)
{
	float lerpA = input/split1;
	float lerpB = (input-split1)/(split2-split1);
	float lerpC = (input-split2)/(1.0-split2);
	vec4 colMix1 = mix(color1, color2, lerpA);
	vec4 colMix2 = mix(color2, color3, lerpB);
	vec4 colMix3 = mix(color3, color4, lerpC);
	float stepA = step(split1, input);
	float stepB = step(split2, input);
	return mix(mix(colMix1, colMix2, stepA), colMix3, stepB);
}
vec4 Gradient3(float input, vec4 color1, vec4 color2, vec4 color3, float split)
{
	float lerpA = input/split;
	float lerpB = (input-split)/(1.0-split);
	vec4 colMix1 = mix(color1, color2, lerpA);
	vec4 colMix2 = mix(color2, color3, lerpB);
	float stepA = step(split, input);
	return mix(colMix1, colMix2, stepA);
}
vec4 Gradient2(float input, vec4 color1, vec4 color2)
{
	return mix(color1, color2, input);
}
#endif