extends DirectionalLight3D

@onready var directional_light_3d = $"."
@export var rotationSpeed : float

func _process(delta):
	directional_light_3d.rotate_x(rotationSpeed * delta)
