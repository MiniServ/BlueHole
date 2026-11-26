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

@onready var hp_up_button = $HPUpButton
@onready var hp_down_button = $HPDownButton
@onready var eng_up_button = $EnergyUpButton
@onready var eng_down_button = $EnergyDownButton

@onready var potion_up_btn = $PotionUpButton

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

func _process(delta: float) -> void:
	if Game.player.potion.potion_stat["lv"] == 15:
		potion_up_btn.disabled = true
	
	if Game.player.potion.potion_stat["hp"] == Game.player.potion.potion_stat["qty"]:
		hp_up_button.disabled = true
	else:
		hp_up_button.disabled = false

	if Game.player.potion.potion_stat["hp"] == 0:
		hp_down_button.disabled = true
	else:
		hp_down_button.disabled = false

	if Game.player.potion.potion_stat["eng"] == Game.player.potion.potion_stat["qty"]:
		eng_up_button.disabled = true
	else:
		eng_up_button.disabled = false

	if Game.player.potion.potion_stat["eng"] == 0:
		eng_down_button.disabled = true
	else:
		eng_down_button.disabled = false

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
	if Game.player.potion.potion_stat["lv"] == 15:
		after_up.text = str(Game.player.potion.potion_stat["lv"])
		after_amount.text = str(Game.player.potion.potion_stat["qty"])
		after_hp.text = str(Game.player.potion.potion_stat["hp_heal"])
		after_eng.text = str(Game.player.potion.potion_stat["eng_heal"])
	else:
		after_up.text = str(up_preview["lv"])
		after_amount.text = str(up_preview["qty"])
		after_hp.text = str(up_preview["hp_heal"])
		after_eng.text = str(up_preview["eng_heal"])

#포션 강화
func _on_potion_up_button_pressed() -> void:
	Game.player._potion_upgrade()
	_upgrade_preview()
	#get_parent().get_parent().get_parent()._get_coin()
	_set_potion()


func _on_hp_up_button_pressed() -> void:
	Game.player.potion._up_hp_potion()
	_set_potion()


func _on_hp_down_button_pressed() -> void:
	Game.player.potion._down_hp_potion()
	_set_potion()



func _on_energy_up_button_pressed() -> void:
	Game.player.potion._down_hp_potion()
	_set_potion()



func _on_energy_down_button_pressed() -> void:
	Game.player.potion._up_hp_potion()
	_set_potion()

func _reset_potion_up():
	Game.player._reset_potion_upgrade()
	_upgrade_preview()
	#get_parent().get_parent().get_parent()._get_coin()
	_set_potion()
