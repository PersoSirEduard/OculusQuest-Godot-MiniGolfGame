extends Spatial
tool

export(String, MULTILINE) var text = "" setget set_text
onready var label = $Viewport/Label

func _ready():
	set_text(text)
	
func set_text(new_val):
	text = new_val
	label.text = text
	
