extends Area

var level = ""

func _ready():
	level = get_parent().name

func _on_GameArea_body_entered(body):
	if (body.is_in_group("GolfBall") and body.level == level):
		body.gameAreas.append(self)
		body.setOutZone(false)

func _on_GameArea_body_exited(body):
	if (body.is_in_group("GolfBall") and body.level == level):
		body.gameAreas.erase(self)
		if (body.gameAreas.size() <= 0):
			body.setOutZone(true)
