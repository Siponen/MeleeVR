shader_type spatial;
uniform sampler2D terrainTexture;

void vertex()
{
	//Matrix rotation along y-axis
	float angle = TIME;
	/*
	VERTEX = VERTEX * mat3(
		vec3(cos(angle),0,sin(angle)),
		vec3(0, 1.0, 0),
		vec3(-sin(angle), 0, cos(angle)));*/
	float textureDimension = 128.0*128.0;
	float arrayDimension = 16.0 * 16.0;
		
	UV = VERTEX.xz * textureDimension / arrayDimension;
}

void fragment()
{
	ALBEDO = texture(terrainTexture,UV).rgb * vec3(1.0,0.5,1.0);
}