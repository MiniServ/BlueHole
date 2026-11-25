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
