extends RefCounted

const save_path := "user://player_stat.json"
const SAVE_PASSWORD := "Turtle Neck"

func _save_dict() -> Dictionary:
	return{
	"hp": Game.player.stat.stat_up["hp"], #체력
	"eng": Game.player.stat.stat_up["eng"], #에너지
	"def": Game.player.stat.stat_up["def"], #방어력
	"sp": Game.player.stat.stat_up["sp"], #지구력
	"wgt": Game.player.stat.stat_up["wgt"], #중량
	"atk": Game.player.stat.stat_up["atk"], #공격력
	"absb": Game.player.stat.stat_up["absb"], #흡수
	"adp": Game.player.stat.stat_up["adp"], #적응
	"luk": Game.player.stat.stat_up["luk"], #행운
	}
	
func _load_dict(data: Dictionary):
	if data.has("hp"):
		Game.player.stat.stat_up["hp"] = int(data["hp"])
	if data.has("eng"):
		Game.player.stat.stat_up["eng"] = int(data["eng"])
	if data.has("def"):
		Game.player.stat.stat_up["def"] = int(data["def"])
	if data.has("sp"):
		Game.player.stat.stat_up["sp"] = int(data["sp"])
	if data.has("wgt"):
		Game.player.stat.stat_up["wgt"] = int(data["wgt"])
	if data.has("atk"):
		Game.player.stat.stat_up["atk"] = int(data["atk"])
	if data.has("absb"):
		Game.player.stat.stat_up["absb"] = int(data["absb"])
	if data.has("adp"):
		Game.player.stat.stat_up["adp"] = int(data["adp"])
	if data.has("luk"):
		Game.player.stat.stat_up["luk"] = int(data["luk"])
	
func get_save_path(file_name: String) -> String:
	var exe_dir := OS.get_executable_path().get_base_dir()
	var save_dir := exe_dir.path_join("save")
	DirAccess.make_dir_recursive_absolute(save_dir)
	return save_dir.path_join(file_name)
	
func _save():
	var file = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE, SAVE_PASSWORD)
	if not file:
		push_error("세이브 파일 열기 실패")
		return
	file.store_string(JSON.stringify(_save_dict(), "\t"))
	file.close()
	print("프론트 저장 완료:", save_path)
	
func _load():
	if not FileAccess.file_exists(save_path):
		print("저장 파일 없음")
		return
	var file = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, SAVE_PASSWORD)
	if file == null:
		push_error("암호화 세이브 열기 실패: %s" % FileAccess.get_open_error())
		return
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) == TYPE_DICTIONARY:
		_load_dict(parsed)
		print("프론트 불러오기 완료")
	else:
		push_error("JSON 파싱 실패")
