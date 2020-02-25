#ifdef COMPILEVS

	#ifdef NUMVERTEXLIGHTS
		float GetVertexLight(int index, vec3 worldPos, vec3 normal)
		{
			vec3 lightDir = cVertexLights[index * 3 + 1].xyz;
			vec3 lightPos = cVertexLights[index * 3 + 2].xyz;
			float invRange = cVertexLights[index * 3].w;
			float cutoff = cVertexLights[index * 3 + 1].w;
			float invCutoff = cVertexLights[index * 3 + 2].w;

			// Directional light
			if (invRange == 0.0)
			{
				#ifdef TRANSLUCENT
					float NdotL = abs(dot(normal, lightDir));
				#else
					float NdotL = max(dot(normal, lightDir), 0.0);
				#endif
					return NdotL;
			}
			// Point/spot light
			else
			{
				vec3 lightVec = (lightPos - worldPos) * invRange;
				float lightDist = length(lightVec);
				vec3 localDir = lightVec / lightDist;
				#ifdef TRANSLUCENT
					float NdotL = abs(dot(normal, localDir));
				#else
					float NdotL = max(dot(normal, localDir), 0.0);
				#endif
				float atten = clamp(1.0 - lightDist * lightDist, 0.0, 1.0);
				float spotEffect = dot(localDir, lightDir);
				float spotAtten = clamp((spotEffect - cutoff) * invCutoff, 0.0, 1.0);
				return NdotL * atten * spotAtten;
			}
		}

		float GetVertexLightVolumetric(int index, vec3 worldPos) //Particle
		{
			vec3 lightDir = cVertexLights[index * 3 + 1].xyz;
			vec3 lightPos = cVertexLights[index * 3 + 2].xyz;
			float invRange = cVertexLights[index * 3].w;
			float cutoff = cVertexLights[index * 3 + 1].w;
			float invCutoff = cVertexLights[index * 3 + 2].w;

			// Directional light
			if (invRange == 0.0) //Why is there no braces
				return 1.0;
				// Point/spot light
			else
			{
				vec3 lightVec = (lightPos - worldPos) * invRange;
				float lightDist = length(lightVec);
				vec3 localDir = lightVec / lightDist;
				float atten = clamp(1.0 - lightDist * lightDist, 0.0, 1.0);
				float spotEffect = dot(localDir, lightDir);
				float spotAtten = clamp((spotEffect - cutoff) * invCutoff, 0.0, 1.0);
				return atten * spotAtten;
			}
		}
	#endif
#endif

#ifdef COMPILEPS
	float GetDiffuse(vec3 normal, vec3 worldPos, out vec3 lightDir)
	{
		#ifdef DIRLIGHT
			lightDir = cLightDirPS;
			#ifdef TRANSLUCENT
				return abs(dot(normal, lightDir));
			#else
				return max(dot(normal, lightDir), 0.0);
			#endif
		#else
			vec3 lightVec = (cLightPosPS.xyz - worldPos) * cLightPosPS.w;
			float lightDist = length(lightVec);
			lightDir = lightVec / lightDist;
			#ifdef TRANSLUCENT
				return abs(dot(normal, lightDir)) * texture2D(sLightRampMap, vec2(lightDist, 0.0)).r;
			#else
				return max(dot(normal, lightDir), 0.0) * texture2D(sLightRampMap, vec2(lightDist, 0.0)).r;
			#endif
		#endif
	}

	float GetAtten(vec3 normal, vec3 worldPos, out vec3 lightDir)
	{
		lightDir = cLightDirPS;
		return clamp(dot(normal, lightDir), 0.0, 1.0);
	}

	float GetAttenPoint(vec3 normal, vec3 worldPos, out vec3 lightDir)
	{
		vec3 lightVec = (cLightPosPS.xyz - worldPos) * cLightPosPS.w;
		float lightDist = length(lightVec);
		float falloff = pow(clamp(1.0 - pow(lightDist / 1.0, 4.0), 0.0, 1.0), 2.0) * 3.14159265358979323846 / (4.0 * 3.14159265358979323846)*(pow(lightDist, 2.0) + 1.0);
		lightDir = lightVec / lightDist;
		return clamp(dot(normal, lightDir), 0.0, 1.0) * falloff;
	}

	float GetAttenSpot(vec3 normal, vec3 worldPos, out vec3 lightDir)
	{
		vec3 lightVec = (cLightPosPS.xyz - worldPos) * cLightPosPS.w;
		float lightDist = length(lightVec);
		float falloff = pow(clamp(1.0 - pow(lightDist / 1.0, 4.0), 0.0, 1.0), 2.0) / (pow(lightDist, 2.0) + 1.0);

		lightDir = lightVec / lightDist;
		return clamp(dot(normal, lightDir), 0.0, 1.0) * falloff;
	}

	float GetDiffuseVolumetric(vec3 worldPos) //Particle
	{
		#ifdef DIRLIGHT
			return 1.0;
		#else
			vec3 lightVec = (cLightPosPS.xyz - worldPos) * cLightPosPS.w;
			float lightDist = length(lightVec);
			return texture2D(sLightRampMap, vec2(lightDist, 0.0)).r;
		#endif
	}

	float GetSpecular(vec3 normal, vec3 eyeVec, vec3 lightDir, float specularPower)
	{
		vec3 halfVec = normalize(normalize(eyeVec) + lightDir);  
		return pow(max(dot(normal, halfVec), 0.0), specularPower);
	}
#endif
