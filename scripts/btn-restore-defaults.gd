extends Button

@onready var popup: CanvasLayer = $"../../../../../../popup-OK"

func _ready():
	pressed.connect(_on_pressed)
	popup.confirmed.connect(_on_confirmed)

func _on_pressed():
	popup.show_popup({
		"message": "Warning: This is a test.",
		"confirm_txt": "   OK   "
	})
	AudioController.play_click_9
		
func _on_confirmed():
	pass
