extends Node

@onready var bg_music: AudioStreamPlayer = $bg_music
@onready var click_8: AudioStreamPlayer = $"click-8"
@onready var click_9: AudioStreamPlayer = $"click-9"
@onready var click_10: AudioStreamPlayer = $"click-10"

func _ready():
	AudioController.play_music()

func play_music():
	bg_music.play()
	
# Button Clicks
func play_click_8():
	click_8.play()

func play_click_9():
	click_9.play()

func play_click_10():
	click_10.play()

func apply_audio_settings(audio_settings: Dictionary) -> void:
	var master_vol = 0.0 if audio_settings["muted"] else audio_settings["master_volume"] / 100.0
	var music_vol = audio_settings["music_volume"] / 100.0
	var sfx_vol = audio_settings["sfx_volume"] / 100.0

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(master_vol))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_vol))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx_vol))
