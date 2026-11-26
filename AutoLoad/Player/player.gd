extends RefCounted

var stat = preload("res://AutoLoad/Player/stat.gd").new()
var currency = preload("res://AutoLoad/Player/currency.gd").new()
var potion = preload("res://AutoLoad/Player/potion.gd").new()

var level = 0
var soulstone = 10000000

#레벨 설정
func _set_level():
	var a = 0
	for i in stat.stat_up.values():
		a += i
	
	level = a

#플레이어 강화
func _apply_player_upgrade(data, point):
	stat._apply_player_upgrade_stat(data)
	for i in point:
		currency._player_upgrade_cost(true, i)
	
	level += point
	
	Game.save._save_player()
	Game.save._save_stat()

#플레이어 강화 초기화
func _reset_player_upgrade():
	stat._reset_player_upgrade_stat()
	currency._reset_player_upgrade_cost()
	_set_level()
	Game.save._save_player()
	Game.save._save_stat()

#포션 강화
func _potion_upgrade():
	potion._potion_upgrade(true)
	currency._potion_upgrade_cost(true)
	
	Game.save._save_potion()

#포션 강화 초기화(테스트용)
func _reset_potion_upgrade():
	potion._potion_reset()
	currency._reset_potion_upgrade_cost()
	
	Game.save._save_potion()
