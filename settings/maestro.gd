extends Node

@onready var sfx_players: Array[AudioStreamPlayer] = [
	$SFXPlayer0,$SFXPlayer1,$SFXPlayer2,
	$SFXPlayer3,$SFXPlayer4,$SFXPlayer5,
	$SFXPlayer6,$SFXPlayer7,$SFXPlayer8,
	$SFXPlayer9,$SFXPlayer10,$SFXPlayer11]
@export var sounds: Dictionary[String,AudioStreamMP3]
@export var musics: Dictionary[String,AudioStreamMP3]
@export var voices: Dictionary[String,AudioStreamMP3]
var voice_queue:Array[AudioStreamMP3] = []

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var voice_player: AudioStreamPlayer = $VoicePlayer

enum BUS_TYPE{
	NULL,SFX,MUSIC,VOICE
}

func _ready() -> void:
	voice_player.finished.connect(play_next_voice)

func play(sfx_name:String):
	if !sounds.has(sfx_name):
		printerr("Tried playing sfx that didn't exist: ", sfx_name)
		return
	var chosen_player:AudioStreamPlayer = null
	for player:AudioStreamPlayer in sfx_players:
		if player.playing:
			continue
		chosen_player = player
		break
	if !chosen_player:
		return
	chosen_player.stream = sounds[sfx_name]
	chosen_player.pitch_scale = randf_range(.95,1.05)
	chosen_player.play()

func play_music(music_name:String, loop:bool = true):
	if !musics.has(music_name):
		printerr("Tried playing music that didn't exist: ", music_name)
		return
	music_player.stream = musics[music_name]
	music_player.stream.loop = loop
	music_player.play()

func play_voice(voice_name:String, enqueue:bool = true):
	if !voices.has(voice_name):
		printerr("Tried playing voice that didn't exist: ", voice_name)
		return
	if voice_player.playing and enqueue:
		voice_queue.append(voices[voice_name])
		return
	elif voice_player.playing: return
	voice_player.stream = voices[voice_name]
	voice_player.play()
		
func play_next_voice():
	if voice_queue.size() == 0: return
	
	voice_player.stream = voice_queue.pop_front()
	voice_player.play()
