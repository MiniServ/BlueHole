extends Control

@onready var hp_potion = $Panel2/AnimatedSprite2D
@onready var eng_potion = $Panel3/AnimatedSprite2D

@onready var coin_need_text = $Coin_Need_Text
@onready var before_up_text = $HBoxContainer/VBoxContainer/Before_Upgrade_Text
@onready var before_amount_text = $HBoxContainer/VBoxContainer/Before_Amount_Text
@onready var before_hp_text = $HBoxContainer/VBoxContainer/Before_HP_Text
@onready var before_eng_text = $HBoxContainer/VBoxContainer/Before_Energy_Text
@onready var after_up_text = $HBoxContainer2/VBoxContainer/After_Upgrade_Text
@onready var after_amount_text = $HBoxContainer2/VBoxContainer/After_Amount_Text
@onready var after_hp_text = $HBoxContainer2/VBoxContainer/After_HP_Text
@onready var after_eng_text = $HBoxContainer2/VBoxContainer/After_Energy_Text

@onready var potionup_normal = $PotionUpButton/PotionUp_Normal
@onready var potionup_over = $PotionUpButton/PotionUp_Over
@onready var hpup_normal = $HPUpButton/HPUp_Normal
@onready var hpup_over = $HPUpButton/HPUp_Over
@onready var hpdown_normal = $HPDownButton/HPDown_Normal
@onready var hpdown_over = $HPDownButton/HPDown_Over
@onready var engup_normal = $EnergyUpButton/EnergyUp_Normal
@onready var engup_over = $EnergyUpButton/EnergyUp_Over
@onready var engdown_normal = $EnergyDownButton/EnergyDown_Normal
@onready var engdown_over = $EnergyDownButton/EnergyDown_Over

@onready var coin_need = $Coin_Need

@onready var before_up = $HBoxContainer/VBoxContainer2/Before_Upgrade
@onready var before_amount = $HBoxContainer/VBoxContainer2/Before_Amount
@onready var before_hp = $HBoxContainer/VBoxContainer2/Before_HP
@onready var before_eng = $HBoxContainer/VBoxContainer2/Before_Energy
@onready var after_up = $HBoxContainer2/VBoxContainer2/After_Upgrade
@onready var after_amount = $HBoxContainer2/VBoxContainer2/After_Amount
@onready var after_hp = $HBoxContainer2/VBoxContainer2/After_HP
@onready var after_eng = $HBoxContainer2/VBoxContainer2/After_Energy


@onready var hp_num = $Panel2/PotionHPNum
@onready var eng_num = $Panel3/PotionEnergyNum

var up_preview

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_potion()
	_upgrade_preview()
	_set_language()
	
func _set_potion():
	hp_num.text = str(Game.player.potion.potion_stat["hp"])
	eng_num.text = str(Game.player.potion.potion_stat["eng"])
	
	if Game.player.potion.potion_stat["hp"] == 0:
		hp_potion.animation = "Empty"
	else:
		hp_potion.animation = "HP"
	if Game.player.potion.potion_stat["eng"] == 0:
		eng_potion.animation = "Empty"
	else:
		eng_potion.animation = "Energy"

#텍스트
func _set_language():
	var lang_stat = LangData.potion_up.get(LangData.language)
	
	coin_need_text.text = lang_stat.get("coin_need") + " : "
	before_up_text.text = lang_stat.get("current_up") + " : "
	before_amount_text.text = lang_stat.get("amount") + " : "
	before_hp_text.text = lang_stat.get("hp") + " : "
	before_eng_text.text = lang_stat.get("eng") + " : "
	after_up_text.text = lang_stat.get("after_up") + " : "
	after_amount_text.text = lang_stat.get("amount") + " : "
	after_hp_text.text = lang_stat.get("hp") + " : "
	after_eng_text.text = lang_stat.get("eng") + " : "

#포션 강화 텍스트
#preview 불러오기
func _upgrade_preview():
	up_preview = Game.player.potion._potion_upgrade(false)
	coin_need.text = str(Game.player.currency._potion_upgrade_cost(false))
	_before_upgrade_text()
	_after_upgrade_text()

#강화 전
func _before_upgrade_text():
	before_up.text = str(Game.player.potion.potion_stat["lv"])
	before_amount.text = str(Game.player.potion.potion_stat["qty"])
	before_hp.text = str(Game.player.potion.potion_stat["hp_heal"])
	before_eng.text = str(Game.player.potion.potion_stat["eng_heal"])
	
#강화 후
func _after_upgrade_text():
	after_up.text = str(up_preview["lv"])
	after_amount.text = str(up_preview["qty"])
	after_hp.text = str(up_preview["hp_heal"])
	after_eng.text = str(up_preview["eng_heal"])

#포션 강화
func _on_potion_up_button_mouse_entered() -> void:
	potionup_normal.visible = false
	potionup_over.visible = true


func _on_potion_up_button_mouse_exited() -> void:
	potionup_normal.visible = true
	potionup_over.visible = false


func _on_potion_up_button_pressed() -> void:
	Game.player._potion_upgrade()
	_upgrade_preview()
	#get_parent().get_parent().get_parent()._get_coin()
	_set_potion()


func _on_hp_up_button_mouse_entered() -> void:
	hpup_normal.visible = false
	hpup_over.visible = true


func _on_hp_up_button_mouse_exited() -> void:
	hpup_normal.visible = true
	hpup_over.visible = false


func _on_hp_up_button_pressed() -> void:
	Game.player.potion._up_hp_potion()
	_set_potion()


func _on_hp_down_button_mouse_entered() -> void:
	hpdown_normal.visible = false
	hpdown_over.visible = true


func _on_hp_down_button_mouse_exited() -> void:
	hpdown_normal.visible = true
	hpdown_over.visible = false


func _on_hp_down_button_pressed() -> void:
	Game.player.potion._down_hp_potion()
	_set_potion()


func _on_energy_up_button_mouse_entered() -> void:
	engup_normal.visible = false
	engup_over.visible = true


func _on_energy_up_button_mouse_exited() -> void:
	engup_normal.visible = true
	engup_over.visible = false


func _on_energy_up_button_pressed() -> void:
	Game.player.potion._down_hp_potion()
	_set_potion()


func _on_energy_down_button_mouse_entered() -> void:
	engdown_normal.visible = false
	engdown_over.visible = true


func _on_energy_down_button_mouse_exited() -> void:
	engdown_normal.visible = true
	engdown_over.visible = false


func _on_energy_down_button_pressed() -> void:
	Game.player.potion._up_hp_potion()
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
