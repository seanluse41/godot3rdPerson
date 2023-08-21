shader_type sky;
render_mode use_half_res_pass;

uniform vec3 topSkyDay : source_color;
uniform vec3 horizonSkyDay : source_color;
uniform vec3 topSkyNight : source_color;
uniform vec3 horizonSkyNight : source_color;
uniform vec3 topSunRiseSet: source_color;
uniform vec3 horizonSunRiseSet: source_color;
uniform vec3 sunColor: source_color;
uniform float sunSize = .2;
uniform vec3 moonColor: source_color;
uniform float moonSize = .1;
uniform float moonOffset = .05;

void sky() {
	
	float sunDirection = distance(EYEDIR.xyz, LIGHT0_DIRECTION);
	float sunPosition = 1.0 - clamp(sunDirection / sunSize, 0.0, 1.0);
	float sunDisk = step(sunSize, sunPosition);
	vec4 sun = vec4(sunColor, sunDisk);
	
	float moonDirection = distance(EYEDIR.xyz, -LIGHT0_DIRECTION);
	float moonPosition = 1.0 - clamp(moonDirection / moonSize, 0.0, 1.0);
	float moonDisk = step(moonSize, moonPosition);
	float moonCrescentDirection = distance(vec3(EYEDIR.x + moonOffset, EYEDIR.yz), -LIGHT0_DIRECTION);
	float moonCrescentPosition = 1.0 - clamp(moonCrescentDirection / moonSize, 0.0, 1.0);
	float moonCrescent = step(moonSize, moonCrescentPosition);
	
	vec4 moon = vec4(moonColor, clamp((moonDisk - moonCrescent), 0.0, 1.0));
	
	float colorGradient = clamp(EYEDIR.y, 0.0, 1.0);
	vec3 skyColorDay = mix(horizonSkyDay, topSkyDay, colorGradient);
	vec3 skyColorNight = mix(horizonSkyNight, topSkyNight, colorGradient);
	vec3 skyColorSunRiseSet = mix(horizonSunRiseSet, topSunRiseSet, colorGradient);
	
	vec3 skyColor = vec3(0.0, 0.0, 0.0);
	
	if (LIGHT0_DIRECTION.y > 0.0){
		if (LIGHT0_DIRECTION.y > 0.1){
			skyColor = skyColorDay;
		} else {
			skyColor = mix(skyColorSunRiseSet, skyColorDay, LIGHT0_DIRECTION.y);
		}
	} else {
		if (LIGHT0_DIRECTION.y > -0.3) {
				skyColor = mix(skyColorSunRiseSet, skyColorNight, abs(LIGHT0_DIRECTION.y));
		} else {
			skyColor = skyColorNight;		
		}
	}
	skyColor = mix(skyColor, sun.rgb, sun.a);
	skyColor = mix(skyColor, moon.rgb, moon.a);
	COLOR = skyColor;
}
