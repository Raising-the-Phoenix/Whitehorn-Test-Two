extends Button

func _ready():
	pressed.connect(_on_pressed)
	
func _on_pressed():
	# SceneManager.load_scene(SceneManager.PLAY_MENU_PATH)
	get_tree().change_scene_to_file("res://scenes/play-scene.tscn")
