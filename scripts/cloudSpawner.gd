extends CSGBox3D

@export var cloudsToSpawn : int = 3
@export var _cloud : PackedScene

var rng = RandomNumberGenerator.new()

func _ready():
	spawnClouds()

func spawnClouds():
	while cloudsToSpawn >= 0:
		cloudsToSpawn -= 1
		
		var x : float = rng.randf_range(size.x / 2, -size.x / 2)
		var y : float = rng.randf_range(size.y / 2, -size.y / 2)
		var z : float = rng.randf_range(size.z / 2, -size.z / 2)
		
		var spawnPosition : Vector3 = Vector3(x, y, z)
		var cloud:= _cloud.instantiate()
		add_child(cloud)
		cloud.global_position = self.global_position + spawnPosition
