extends Node3D

@export var puzzle : Resource
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalAudio._playAudio(puzzle.audioTrack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
