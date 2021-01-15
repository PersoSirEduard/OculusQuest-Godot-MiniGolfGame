extends Spatial

onready var waterSplash = $Audio_WaterSplash

func _on_Area_body_entered(body):
	if (body.is_in_group("GolfBall")):
		waterSplash.play()
