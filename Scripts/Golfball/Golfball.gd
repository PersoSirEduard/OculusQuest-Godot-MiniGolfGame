extends RigidBody

var player
var level = ""
var spawnpoint
var hit = false setget setHitState
var out_zone = false setget setOutZone
var slow_down = false
export(float) var out_time = 15
export(float) var shot_time = 10
var gameAreas = []

onready var out_timer = $OutOfZone_Timer
onready var shot_timer = $Shot_Timer
onready var audio = $GolfBall_Audio

func _ready():
	friction = 0.8 # Default
	bounce = 0.7
	level = get_parent().name
	spawnpoint = transform.origin

func _physics_process(delta):
	if (slow_down):
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		slow_down = false
		var objective = (get_parent().get_node("Flag").transform.origin - transform.origin).normalized()
		var new_spawn = transform.origin - objective.cross(Vector3.UP).normalized() * 0.85
		spawnpoint = transform.origin
		player.spawnpoint = new_spawn
		player.transform.origin = new_spawn
		player.audio.play()
			
func setOutZone(new_val):
	out_zone = new_val
	if (out_zone):
		out_timer.start(out_time)
	else:
		out_timer.stop()

func setHitState(new_val):
	hit = new_val
	if (hit):
		shot_timer.start(shot_time)
	else:
		shot_timer.stop()
		
func respawn():
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	transform.origin = spawnpoint
	hit.setHitState(false)
	slow_down = false
	sleeping = false

func _on_OutOfZone_Timer_timeout():
	respawn()

func _on_Shot_Timer_timeout():
	slow_down = true
