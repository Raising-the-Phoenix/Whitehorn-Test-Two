extends Control

signal menu_loaded

func _ready():
	emit_signal("menu_loaded")
	
	
