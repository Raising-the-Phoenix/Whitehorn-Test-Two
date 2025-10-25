extends Button

@export var category_to_restore := "audio"

func _ready():
	pressed.connect(_on_pressed)
	
func _on_pressed():
	AudioController.play_click_9()
	# Use SettingsManager to show the confirmation popup
	PopupManager.show_confirm(
		"RESTORE DEFAULT %s SETTINGS ONLY?" % category_to_restore.to_upper(), 
		func():
				SettingsManager.restore_defaults(category_to_restore)
				if category_to_restore == "audio":
						AudioController.apply_audio_settings(SettingsManager.settings["audio"])
	)
