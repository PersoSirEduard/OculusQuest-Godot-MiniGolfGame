extends Spatial

export var max_impulse = 200
export var max_speed = 45
onready var tip = $ClubTip
onready var audioHit = $AudioHit
var tipVelocity = Vector3.ZERO
var prevTipPos = Vector3.ZERO

func _ready():
	prevTipPos = tip.global_transform.origin # Global position

func _process(delta):
	var currentTipPos = tip.global_transform.origin
	tipVelocity = (currentTipPos - prevTipPos) / delta
	prevTipPos = currentTipPos

func _on_HitArea_body_entered(body):
	if (body.is_in_group("GolfBall")):
		#var normal = -tip.global_transform.basis.x
		var normal = tipVelocity.normalized()
		var strength = clamp(tipVelocity.length(), 0, max_speed) / max_speed
		if (strength <= 0.001):
			body.linear_velocity = Vector3.ZERO
			body.angular_velocity = Vector3.ZERO
		else:
			body.sleeping = false
			var impulse = normal * max_impulse * strength
			body.apply_impulse(Vector3.ZERO, impulse)
			body.setHitState(true)
			audioHit.play()
