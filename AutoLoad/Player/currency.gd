extends RefCounted


func _player_upgrade_cost(use, level):
	var cost = 5000
	cost += ceili(level ** 2 * 30)
	
	if use:
		Game.player.soulstone -= cost
	else:
		return cost

func _reset_player_upgrade_cost():
	var cost = 0
	for i in Game.player.level:
		cost += 5000 + ceili(i ** 2 * 30)
		print(cost)
	
	Game.player.soulstone += cost

#포션 업글 재화
func _potion_upgrade_cost(use):
	var cost = 5000
	
	if use:
		Game.player.soulstone -= cost
	else:
		return cost

#포션 업글 리셋(테스트용)
func _reset_potion_upgrade_cost():
	var cost = 0
	for i in Game.player.potion.potion_stat["lv"]:
		cost += 5000
	
	Game.player.soulstone += cost
