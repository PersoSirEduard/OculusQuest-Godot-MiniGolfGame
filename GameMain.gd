extends Node


func _process(_dt):
	pass;
		
func _ready():
	vr.initialize();
	vr.scene_switch_root = self;
	
	# Always advertise Godot a bit in the beginning
	if (vr.inVR): vr.switch_scene("res://Scenes/SplashScreen.tscn", 0.0, 0.0);
	
	vr.switch_scene("res://Scenes/Levels/Tutorial/Tutorial.tscn", 0.1, 5.0)
