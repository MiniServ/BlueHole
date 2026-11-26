extends RefCounted

var potion_stat: Dictionary =  {
	"lv": 0,
	"qty": 3,
	"hp": 3,
	"hp_heal": 100,
	"eng": 0,
	"eng_heal": 50,
}

#HP +1, eng -1
func _up_hp_potion():
	if potion_stat["hp"] == potion_stat["qty"]:
		return
	
	potion_stat["hp"] += 1
	potion_stat["eng"] -= 1

#HP -1, eng +1
func _down_hp_potion():
	if potion_stat["hp"] == 0:
		return
	
	potion_stat["hp"] -= 1
	potion_stat["eng"] += 1

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
	
