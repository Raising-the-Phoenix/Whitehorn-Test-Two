extends CanvasLayer

@export var ui_scale = 1.5

func _ready():
	scale = Vector2(ui_scale, ui_scale)
	get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
