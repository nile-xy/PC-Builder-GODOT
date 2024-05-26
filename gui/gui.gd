extends Control

func _process(delta):
	$fps.text = str("FPS: ",Engine.get_frames_per_second())
