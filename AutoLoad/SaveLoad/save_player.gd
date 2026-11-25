extends RefCounted

const save_path := "user://player.json"
const SAVE_PASSWORD := "Turtle Neck"

func _save_dict() -> Dictionary:
	return{
	"level": Game.player.level,
	"soulstone": Game.player.soulstone,
	}
	
func _load_dict(data: Dictionary):
	if data.has("level"):
		Game.player.level = int(data["level"])
	if data.has("soulstone"):
		Game.player.soulstone = int(data["soulstone"])
	
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
