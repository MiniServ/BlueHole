extends Control

var player_id = "simul_player_test01"

@onready var hp_potion = $Panel2/AnimatedSprite2D
@onready var mp_potion = $Panel3/AnimatedSprite2D

@onready var coin_need_text = $Coin_Need_Text
@onready var before_up_text = $HBoxContainer/VBoxContainer/Label
@onready var before_amount_text = $HBoxContainer/VBoxContainer/Label2
@onready var before_hp_text = $HBoxContainer/VBoxContainer/Label3
@onready var before_mp_text = $HBoxContainer/VBoxContainer/Label4
@onready var after_up_text = $HBoxContainer2/VBoxContainer/Label
@onready var after_amount_text = $HBoxContainer2/VBoxContainer/Label2
@onready var after_hp_text = $HBoxContainer2/VBoxContainer/Label3
@onready var after_mp_text = $HBoxContainer2/VBoxContainer/Label4

@onready var potionup_normal = $PotionUpButton/PotionUp_Normal
@onready var potionup_over = $PotionUpButton/PotionUp_Over
@onready var hpup_normal = $HPUpButton/HPUp_Normal
@onready var hpup_over = $HPUpButton/HPUp_Over
@onready var hpdown_normal = $HPDownButton/HPDown_Normal
@onready var hpdown_over = $HPDownButton/HPDown_Over
@onready var mpup_normal = $MPUpButton/MPUp_Normal
@onready var mpup_over = $MPUpButton/MPUp_Over
@onready var mpdown_normal = $MPDownButton/MPDown_Normal
@onready var mpdown_over = $MPDownButton/MPDown_Over

@onready var coin_need = $Coin_Need

@onready var before_up = $HBoxContainer/VBoxContainer2/Before_Upgrade
@onready var before_amount = $HBoxContainer/VBoxContainer2/Before_Amount
@onready var before_hp = $HBoxContainer/VBoxContainer2/Before_HP
@onready var before_mp = $HBoxContainer/VBoxContainer2/Before_MP
@onready var after_up = $HBoxContainer2/VBoxContainer2/After_Upgrade
@onready var after_amount = $HBoxContainer2/VBoxContainer2/After_Amount
@onready var after_hp = $HBoxContainer2/VBoxContainer2/After_HP
@onready var after_mp = $HBoxContainer2/VBoxContainer2/After_MP


@onready var hp_num = $Panel2/PotionHPNum
@onready var mp_num = $Panel3/PotionMPNum

var up_preview

var hp_potion_amount = 0
var mp_potion_amount = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_potion()
	_upgrade_preview()
	_set_language()
	
func _set_potion():
	var allocation: Dictionary = Api.stat.get_potion_allocation(player_id)
	hp_num.text = str(int(allocation.get(&"hp_max", 0)))
	mp_num.text = str(int(allocation.get(&"mp_max", 0)))
	hp_potion_amount = int(allocation.get(&"hp_max", 0))
	mp_potion_amount = int(allocation.get(&"mp_max", 0))
	
	if hp_potion_amount == 0:
		hp_potion.animation = "Empty"
	else:
		hp_potion.animation = "HP"
	if mp_potion_amount == 0:
		mp_potion.animation = "Empty"
	else:
		mp_potion.animation = "MP"

#텍스트
func _set_language():
	var lang_stat = LangData.potion_up.get(LangData.language)
	
	coin_need_text.text = lang_stat.get("coin_need") + " : "
	before_up_text.text = lang_stat.get("current_up") + " : "
	before_amount_text.text = lang_stat.get("amount") + " : "
	before_hp_text.text = lang_stat.get("hp") + " : "
	before_mp_text.text = lang_stat.get("mp") + " : "
	after_up_text.text = lang_stat.get("after_up") + " : "
	after_amount_text.text = lang_stat.get("amount") + " : "
	after_hp_text.text = lang_stat.get("hp") + " : "
	after_mp_text.text = lang_stat.get("mp") + " : "

#포션 강화 텍스트
#preview 불러오기
func _upgrade_preview():
	up_preview = Api.stat.preview_potion_upgrade(player_id)
	coin_need.text = str(int(up_preview.get(&"required_amount", 0)))
	_before_upgrade_text()
	_after_upgrade_text()

#강화 전
func _before_upgrade_text():
	before_up.text = str(int(up_preview.get(&"current_level", 0)))
	before_amount.text = str(int(up_preview.get(&"current_total_max", 0)))
	before_hp.text = str(int(up_preview.get(&"current_hp_heal_amount", 0)))
	before_mp.text = str(int(up_preview.get(&"current_mp_heal_amount", 0)))
	
#강화 후
func _after_upgrade_text():
	after_up.text = str(int(up_preview.get(&"next_level", 0)))
	after_amount.text = str(int(up_preview.get(&"next_total_max", 0)))
	after_hp.text = str(int(up_preview.get(&"next_hp_heal_amount", 0)))
	after_mp.text = str(int(up_preview.get(&"next_mp_heal_amount", 0)))

#포션 강화
func _on_potion_up_button_mouse_entered() -> void:
	potionup_normal.visible = false
	potionup_over.visible = true


func _on_potion_up_button_mouse_exited() -> void:
	potionup_normal.visible = true
	potionup_over.visible = false


func _on_potion_up_button_pressed() -> void:
	Api.stat.upgrade_potion(player_id)
	_upgrade_preview()
	get_parent().get_parent().get_parent()._get_coin()
	_set_potion()


func _on_hp_up_button_mouse_entered() -> void:
	hpup_normal.visible = false
	hpup_over.visible = true


func _on_hp_up_button_mouse_exited() -> void:
	hpup_normal.visible = true
	hpup_over.visible = false


func _on_hp_up_button_pressed() -> void:
	var hp_max_result: Dictionary = Api.stat.set_hp_potion_max_count(hp_potion_amount+1, player_id)
	_set_potion()


func _on_hp_down_button_mouse_entered() -> void:
	hpdown_normal.visible = false
	hpdown_over.visible = true


func _on_hp_down_button_mouse_exited() -> void:
	hpdown_normal.visible = true
	hpdown_over.visible = false


func _on_hp_down_button_pressed() -> void:
	var hp_max_result: Dictionary = Api.stat.set_hp_potion_max_count(hp_potion_amount-1, player_id)
	_set_potion()


func _on_mp_up_button_mouse_entered() -> void:
	mpup_normal.visible = false
	mpup_over.visible = true


func _on_mp_up_button_mouse_exited() -> void:
	mpup_normal.visible = true
	mpup_over.visible = false


func _on_mp_up_button_pressed() -> void:
	var hp_max_result: Dictionary = Api.stat.set_hp_potion_max_count(hp_potion_amount-1, player_id)
	_set_potion()


func _on_mp_down_button_mouse_entered() -> void:
	mpdown_normal.visible = false
	mpdown_over.visible = true


func _on_mp_down_button_mouse_exited() -> void:
	mpdown_normal.visible = true
	mpdown_over.visible = false


func _on_mp_down_button_pressed() -> void:
	var hp_max_result: Dictionary = Api.stat.set_hp_potion_max_count(hp_potion_amount+1, player_id)
	_set_potion()

func _reset_potion_up():
	var path := "user://test_data/players/simul_player_test01.json"

	# JSON 읽기
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		print("파일을 열 수 없음")
		return

	var json_text := file.get_as_text()
	file.close()

	var data = JSON.parse_string(json_text)

	if data == null:
		print("JSON 파싱 실패")
		return

	# 원하는 값만 변경
	data["potions"]["potion_upgrade_level"] = 0

	# 다시 저장
	file = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		print("파일을 저장할 수 없음")
		return

	file.store_string(JSON.stringify(data, "\t"))
	file.close()
	
	_upgrade_preview()
	get_parent().get_parent().get_parent()._get_coin()
	_set_potion()
