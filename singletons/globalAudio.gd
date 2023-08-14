extends AudioStreamPlayer


func _ready():
	self.play()

func _playAudio(track):
	self.set_stream(track)
	self.playing = true

func _stopAudio():
	self.playing = false

func _pauseAudio():
	self.stream_paused = true

func _unPauseAudio():
	self.stream_paused = false
