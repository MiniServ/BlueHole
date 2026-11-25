extends RefCounted

var currency = preload("res://AutoLoad/Player/currency.gd").new()
var stat = preload("res://AutoLoad/Player/stat.gd").new()

var level = 0
var soulstone = 10000000

#레벨 설정
func _set_level():
	var a = 0
	for i in stat.stat_up.values():
		a += i
	
	level = a

func _apply_player_upgrade(data, point):
	stat._apply_player_upgrade_stat(data)
	for i in point:
		currency._player_upgrade_cost(true, i)
	
	level += point
	
	Game.save._save_player()
	Game.save._save_stat()

func _reset_player_upgrade():
	stat._reset_player_upgrade_stat()
	currency._reset_player_upgrade_cost()
	_set_level()
	Game.save._save_player()
	Game.save._save_stat()
