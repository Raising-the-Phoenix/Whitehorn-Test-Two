extends Node

var PopupOKScene := preload("res://scenes/gui/popups/popup-OK.tscn")
var PopupConfirmScene := preload("res://scenes/gui/popups/popup-confirm.tscn")

func show_confirm(message: String, on_confirm, on_cancel = null) -> void:
	var popup = PopupConfirmScene.instantiate()
	get_tree().root.add_child(popup)
	popup.show_popup({
		"message": message.to_upper(),
		"confirm_txt": "   YES   ",
		"cancel_txt": "   NO   "
	})
	popup.confirmed.connect(func():
		on_confirm.call()
		popup.queue_free()
	)
	popup.cancelled.connect(func():
		if on_cancel:
			on_cancel.call()
		popup.queue_free()
	)
	
func _show_warning(message: String) -> void:
	# Instantiate the popup
	var popup = PopupOKScene.instantiate()
	# Add it to the scene tree so it can be displayed
	get_tree().root.add_child(popup) # add to root so it appears on top of everything
	# Show the popup with the message
	popup.show_popup({
		"message": message.to_upper(),
		"confirm_txt": "   OK   "
	})
	
func _show_confirm(message: String) -> void:
	# Instantiate the popup
	var popup = PopupConfirmScene.instantiate()
	# Add it to the scene tree so it can be displayed
	get_tree().root.add_child(popup) # add to root so it appears on top of everything
	# Show the popup with the message
	popup.show_popup({
		"message": message.to_upper(),
		"confirm_txt": "   YES   ",
		"cancel_txt": "   NO   "
	})
