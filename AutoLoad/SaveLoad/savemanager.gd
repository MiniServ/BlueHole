extends RefCounted

var save_player = preload("res://AutoLoad/SaveLoad/save_player.gd").new()
var save_stat = preload("res://AutoLoad/SaveLoad/save_stat.gd").new()
var save_potion = preload("res://AutoLoad/SaveLoad/save_potion.gd").new()

func _load_all():
	save_stat._load()
	save_player._load()
	save_potion._load()

func _save_stat():
	save_stat._save()

func _load_stat():
	save_stat._load()

func _save_player():
	save_player._save()

func _load_player():
	save_player._load()

func _save_potion():
	save_potion._save()

func _load_potion():
	save_potion._load()
