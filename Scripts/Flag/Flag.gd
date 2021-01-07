extends Spatial

onready var flag = $Flag_Mesh
onready var flag_up = $FlagUp
onready var near_me = $NearWin
var flagOrigin
var is_flag_up = false
var level = ""

func _ready():
	flagOrigin = flag.translation
	level = get_parent().name

func _process(delta):
	if is_flag_up:
		flag.translation = flag.translation.linear_interpolate(flag_up.translation, 0.8 * delta)
	else:
		flag.translation = flag.translation.linear_interpolate(flagOrigin, 0.8 * delta)

func _on_NearWin_body_entered(body):
	if (body.is_in_group("GolfBall")):
		is_flag_up = true


func _on_NearWin_body_exited(body):
	var bodies = near_me.get_overlapping_bodies()
	for b in bodies:
		if b.is_in_group("GolfBall"):
			is_flag_up = true
			pass
	is_flag_up = false


func _on_WinHole_body_entered(body):
	if (body.is_in_group("GolfBall") and body.level == level):
		vr.log_info("Goal")
		var scene = get_parent().get_parent()
		scene.currentLvl += 1
		if (scene.currentLvl <= scene.max_lvls):
			body.player.queue_free()
			body.queue_free()
			scene.loadLevel()
