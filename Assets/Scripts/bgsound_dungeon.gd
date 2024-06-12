extends AudioStreamPlayer2D


const menu_music = preload("res://Assets/backsound_menu/1_Dungeon_1_Master.ogg")
func play_music(music: AudioStream, volume = 1):
	if stream == music:
		return
		
		
		stream = music
		volume_db = volume
		play()

func play_music_level():
	play_music(menu_music)
