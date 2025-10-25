extends Button

@onready var popup = $"/root/gui-control/popup-confirm"

func _ready():
	pressed.connect(_on_pressed)
	popup.confirmed.connect(_on_confirmed)
	popup.cancelled.connect(_on_cancelled)

func _on_pressed():
	popup.show_popup({
		"message": "ARE YOU SURE YOU WANT TO QUIT?",
		"confirm_txt": "   YES   ",
		"cancel_txt": "   NO   "
	})
	AudioController.play_click_9
		
func _on_confirmed():
	get_tree().quit()

func _on_cancelled():
	pass
