extends Spatial

export(float) var force = 80
export(Vector3) var direction = Vector3(0, 1, 0)

var bodies = []

func _physics_process(delta):
	for body in bodies:
		var impulse = direction.normalized() * force * delta
		body.apply_impulse(Vector3.ZERO, impulse)

func _on_Area_body_entered(body):
	if body.is_in_group("GolfBall") and bodies.has(body) == false:
		bodies.append(body)

func _on_Area_body_exited(body):
	if body.is_in_group("GolfBall") and bodies.has(body):
		bodies.erase(body)
