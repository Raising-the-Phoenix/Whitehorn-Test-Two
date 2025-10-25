extends Node

var config:= ConfigFile.new()
var config_path := "user://user_settings.cfg"

# Default settings reference for restoring (never changes)
var default_settings := {
		"audio": {
		"master_volume": 100,
		"music_volume": 70,
		"sfx_volume": 100,
		"muted": false
	},
	"video": {
		"resolution": "1920x1080",
		"fullscreen": true,
		"vsync": true,
		"ui_scale": 1.5
	},
	"gameplay": {
		"difficulty": "normal"		
	}
}

# Store current settings in memory (mutable)
var settings := {}



func _ready():
	settings = default_settings.duplicate(true)
	load_settings()

# Saving
	
func save_settings() -> void:
	for category in settings.keys():
		for key in settings[category].keys():
			config.set_value(category, key, settings[category][key])
	var err = config.save(config_path)
	if err != OK:
		PopupManager.show_warning("Failed to save config: %d" % err)

# Loading

func load_settings() -> void:
	var err = config.load(config_path)
	if err != OK:
		PopupManager.show_warning("Setting config not found; using defaults.")
		return
	for category in settings.keys():
		for key in settings[category].keys():
			if config.has_section_key(category, key):
				settings[category][key] = config.get_value(category, key, settings[category][key])

# Getters and Setters

func get_setting(category: String, key: String):
	if category in settings and key in settings[category]:
		return settings[category][key]
	return null

func set_setting(category: String, key: String, value) -> void:
	if category in settings and key in settings[category]:
		settings[category][key] = value
		save_settings()

# Restoring

func restore_defaults(category: String) -> void:
	if not default_settings.has(category):
		PopupManager.show_warning("No such category: " + category)
		return
	settings[category] = default_settings[category].duplicate(true)
	save_settings()
	PopupManager._show_warning("Restore default settings for " + category + ".")

# Audio
func apply_audio_settings() -> void:
	if not settings.has("audio"):
		return
	AudioController.apply_settings(settings["audio"])
	
