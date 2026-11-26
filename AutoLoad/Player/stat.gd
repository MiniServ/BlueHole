extends RefCounted

#기초 스탯
var stat: Dictionary = {
	"hp": 200, #체력
	"eng": 50, #에너지
	"def": 10, #방어력
	"sp": 100, #지구력
	"ms": 150, #이동속도
	"wgt": 0, #중량
	"atk": 10, #공격력
	"absb": 0, #흡수
	"adp": 0, #적응
	"luk": 0, #행운
	"reroll": 3, #새로고침
}
#부여된 포인트
var stat_up: Dictionary = {
	"hp": 0, #체력
	"eng": 0, #에너지
	"def": 0, #방어력
	"sp": 0, #지구력
	"wgt": 0, #중량
	"atk": 0, #공격력
	"absb": 0, #흡수
	"adp": 0, #적응
	"luk": 0, #행운
}
#초당 지구력 회복량
var sp_recover = 1

#전체 최종스탯 설정
func _set_final_all_stat():
	var final_stat: Dictionary = {
		"hp": stat["hp"], #체력
		"eng": stat["eng"], #에너지
		"def": stat["def"], #방어력
		"sp": stat["sp"], #지구력
		"ms": stat["ms"], #이동속도
		"wgt": stat["wgt"], #중량
		"atk": stat["atk"], #공격력
		"absb": stat["absb"], #흡수
		"adp": stat["adp"], #적응
		"luk": stat["luk"], #행운
		"reroll": stat["reroll"], #새로고침
	}
	
	final_stat["hp"] += clampi(stat_up["hp"], 0, 30) * 15
	final_stat["hp"] += clampi(stat_up["hp"] - 30, 0, 30) * 10
	final_stat["hp"] += clampi(stat_up["hp"] - 60, 0, 39) * 5
	
	final_stat["eng"] += clampi(stat_up["eng"], 0, 30) * 10
	final_stat["eng"] += clampi(stat_up["eng"] - 30, 0, 30) * 6
	final_stat["eng"] += clampi(stat_up["eng"] - 60, 0, 39) * 3
	
	final_stat["def"] += stat_up["def"]
	
	final_stat["sp"] += clampi(stat_up["sp"], 0, 50) * 2
	final_stat["ms"] += clampi(stat_up["sp"], 0, 50)
	final_stat["sp"] += clampi(stat_up["sp"] - 50, 0, 49)
	final_stat["ms"] += clampi(stat_up["sp"] - 50, 0, 49) * 0.5
	
	final_stat["wgt"] += stat_up["wgt"] * 2
	
	final_stat["atk"] += clampi(stat_up["atk"], 0, 50) * 3
	final_stat["atk"] += clampi(stat_up["atk"] - 50, 0, 30) * 2
	final_stat["atk"] += clampi(stat_up["atk"] - 80, 0, 19) * 1
	
	final_stat["absb"] += stat_up["absb"]
	
	final_stat["adp"] += stat_up["adp"]
	
	final_stat["luk"] += stat_up["luk"]
	final_stat["reroll"] += int(stat_up["luk"] / 5.0)
	
	return final_stat

#특정 최종스탯 설정
func _set_final_one_stat(stat_name, point):
	var final_stat = 0
	var pointed = point
	match stat_name:
		"hp":
			final_stat = stat["hp"]
			pointed += stat_up["hp"]
			final_stat += clampi(pointed, 0, 30) * 15
			final_stat += clampi(pointed - 30, 0, 30) * 10
			final_stat += clampi(pointed - 60, 0, 39) * 5
		"eng":
			final_stat = stat["eng"]
			pointed += stat_up["eng"]
			final_stat += clampi(pointed, 0, 30) * 10
			final_stat += clampi(pointed - 30, 0, 30) * 6
			final_stat += clampi(pointed - 60, 0, 39) * 3
		"def":
			final_stat = stat["def"]
			pointed += stat_up["def"]
			final_stat += pointed
		"sp":
			pointed += stat_up["sp"]
			final_stat = stat["sp"]
			final_stat += clampi(pointed, 0, 50) * 2
			final_stat += clampi(pointed - 50, 0, 49)
		"ms":
			pointed += stat_up["sp"]
			final_stat = stat["ms"]
			final_stat += clampi(pointed, 0, 50)
			final_stat += clampi(pointed - 50, 0, 49) * 0.5
		"wgt":
			final_stat = stat["wgt"]
			pointed += stat_up["wgt"]
			final_stat += pointed * 2
		"atk":
			final_stat = stat["atk"]
			pointed += stat_up["atk"]
			final_stat += clampi(pointed, 0, 50) * 3
			final_stat += clampi(pointed - 50, 0, 30) * 2
			final_stat += clampi(pointed - 80, 0, 19) * 1
		"absb":
			final_stat = stat["absb"]
			pointed += stat_up["absb"]
			final_stat += pointed
		"adp":
			final_stat = stat["adp"]
			pointed += stat_up["adp"]
			final_stat += pointed
		"luk":
			pointed += stat_up["luk"]
			final_stat = stat["luk"]
			final_stat += pointed
		"reroll":
			pointed += stat_up["luk"]
			final_stat = stat["reroll"]
			final_stat += int(pointed / 5.0)
	
	return final_stat

#스탯 업그레이드 확정
func _apply_player_upgrade_stat(data):
	for i in stat_up:
		stat_up[i] = data[i]

#스탯 업그레이드 초기화
func _reset_player_upgrade_stat():
	for i in stat_up:
		stat_up[i] = 0
