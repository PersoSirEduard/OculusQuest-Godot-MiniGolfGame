extends Spatial

export(int) var currentLvl = 0
var max_lvls = 5

func _ready():
	loadLevel()
	
func loadLevel():
	var level = get_node("Level" + str(currentLvl))
	var player = preload("res://Scripts/Player/Player.tscn").instance()
	player.translation = level.get_node("Player_Spawnpoint").translation
	player.spawnpoint = level.get_node("Player_Spawnpoint").translation
	level.add_child(player)
	var ball = preload("res://Scripts/Golfball/Golfball.tscn").instance()
	ball.player = player
	player.ball = ball
	ball.translation = level.get_node("GolfBall_Spawnpoint").translation
	ball.spawnpoint = level.get_node("GolfBall_Spawnpoint").translation
	level.add_child(ball)
