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
