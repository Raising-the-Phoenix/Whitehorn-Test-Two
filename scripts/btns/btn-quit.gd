extends Button

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	AudioController.play_click_9()
	PopupManager.show_confirm(
		"are you sure you want to quit the game?",
		func(): get_tree().quit()
	)
