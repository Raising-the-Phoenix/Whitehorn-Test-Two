extends CanvasLayer

signal confirmed
signal cancelled

@onready var panel: = $"auto-panel"
@onready var label: Label = $"auto-panel/pop-content/pop-margin/lbl-message"
@onready var confirm: Button = $"auto-panel/pop-content/pop-margin2/btn-hbox/btn-margin-1/btn-confirm"
@onready var cancel: Button = $"auto-panel/pop-content/pop-margin2/btn-hbox/btn-margin-2/btn-cancel"

func _ready():
	hide() #hidden by default
	confirm.pressed.connect(_on_confirm)
	cancel.pressed.connect(_on_cancel)
	# process_mode = 1
	
func show_popup(options: Dictionary):
	# Expected keys: message, confirm_txt, cancel_txt
	label.text = options.get("message", "indicate a message here")
	confirm.text = options.get("confirm_txt", "   YES   ")
	cancel.text = options.get("cancel_txt", "   NO   ")
	call_deferred("show")
	panel.scale = Vector2(0.0, 0.0)

	var tween = create_tween()
	panel.pivot_offset = panel.size / 2 # from the center
	tween.tween_property(panel, "scale", Vector2(1.05, 1.05), 0.20).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# get_tree().paused = true
	
func _on_confirm():
	# get_tree().paused = false
	hide()
	emit_signal("confirmed")
	
func _on_cancel():
	# get_tree().paused = false
	hide()
	emit_signal("cancelled")
	
	
