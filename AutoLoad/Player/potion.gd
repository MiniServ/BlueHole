extends RefCounted

var potion_stat: Dictionary =  {
	"lv": 0, #강화
	"qty": 3, #전체수량
	"hp": 3, #체력 수량
	"hp_heal": 100, #체력 회복량
	"eng": 0, #E에너지 수량
	"eng_heal": 50, #에너지 회복량
}

#HP +1, eng -1
func _up_hp_potion():
	if potion_stat["hp"] == potion_stat["qty"]:
		return
	
	potion_stat["hp"] += 1
	potion_stat["eng"] -= 1
	
	Game.save._save_potion()

#HP -1, eng +1
func _down_hp_potion():
	if potion_stat["hp"] == 0:
		return
	
	potion_stat["hp"] -= 1
	potion_stat["eng"] += 1
	
	Game.save._save_potion()

#포션 강화
func _potion_upgrade(use):
	if use:
		potion_stat["lv"] += 1
		if potion_stat["lv"] % 3 == 0:
			potion_stat["qty"] += 1
			potion_stat["hp"] += 1
		potion_stat["hp_heal"] += 10
		potion_stat["eng_heal"] += 5
	else:
		var preview: Dictionary = {
			"lv": potion_stat["lv"],
			"qty": potion_stat["qty"],
			"hp_heal": potion_stat["hp_heal"],
			"eng_heal": potion_stat["eng_heal"],
		}
		
		preview["lv"] += 1
		if preview["lv"] % 3 == 0:
			preview["qty"] += 1
		preview["hp_heal"] += 10
		preview["eng_heal"] += 5
		
		return preview

#포션 초기화(테스트용)
func _potion_reset():
	potion_stat["lv"] = 0
	potion_stat["qty"] = 3
	potion_stat["hp"] = 3
	potion_stat["hp_heal"] = 100
	potion_stat["eng"] = 0
	potion_stat["eng_heal"] = 50
	
