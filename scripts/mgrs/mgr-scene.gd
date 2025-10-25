extends Node

signal scene_loaded(scene_name: String)

var current_scene: Node = null

const MAIN_MENU_PATH := "res://scenes/gui/main-menu/main-menu.tscn"
# const PLAY_MENU_PATH := "res://scenes/play-scene.tscn"
const AUDIO_MENU_PATH := "res://scenes/gui/main-menu/audio-menu.tscn"

func _ready():
	load_scene(MAIN_MENU_PATH)

func load_scene(path: String):
	if current_scene:
		current_scene.queue_free()
		current_scene = null
		
	var new_scene = load(path).instantiate()
	# Use deferred add_child to avoid "parent busy" errors
	get_tree().root.call_deferred("add_child", new_scene)
	current_scene = new_scene
	
	# Wait one frame for the scene to finish adding before signaling
	await get_tree().process_frame
	emit_signal("scene_loaded", new_scene.name)
	
	# If the new scene emits "menu_loaded", connect to it
	if new_scene.has_signal("menu_loaded"):
		new_scene.emit_signal("menu_loaded")
