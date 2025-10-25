extends Button

func _ready():
	pressed.connect(_on_pressed)
	
func _on_pressed():
	SceneManager.load_scene(SceneManager.AUDIO_MENU_PATH)
	AudioController.play_click_8()
