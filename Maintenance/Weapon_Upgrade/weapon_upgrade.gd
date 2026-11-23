extends Control

@onready var before_name_text = $Right_Panel/Right_Under_Upgrade_Panel/HBox_Before_Name/Before_Name
@onready var before_atk_text = $Right_Panel/Right_Under_Upgrade_Panel/HBox_Before_Attack/Before_Attack_Text
@onready var before_amount_text = $Right_Panel/Right_Under_Upgrade_Panel/HBox_Before_Amount/Before_Amount_Text
@onready var after_name_text = $Right_Panel/Right_Under_Upgrade_Panel/Right_Under_Upgrade_After_Panel/HBox_After_Name/After_Name
@onready var after_atk_text = $Right_Panel/Right_Under_Upgrade_Panel/Right_Under_Upgrade_After_Panel/HBox_After_Attack/After_Attack_Text
@onready var after_amount_text = $Right_Panel/Right_Under_Upgrade_Panel/Right_Under_Upgrade_After_Panel/HBox_After_Amount/After_Amount_Text

@onready var before_upgrade = $Right_Panel/Right_Under_Upgrade_Panel/HBox_Before_Name/Before_Upgrade
@onready var before_atk = $Right_Panel/Right_Under_Upgrade_Panel/HBox_Before_Attack/Before_Attack
@onready var before_amount = $Right_Panel/Right_Under_Upgrade_Panel/HBox_Before_Amount/Before_Amount
@onready var after_upgrade = $Right_Panel/Right_Under_Upgrade_Panel/Right_Under_Upgrade_After_Panel/HBox_After_Name/After_Upgrade
@onready var after_atk = $Right_Panel/Right_Under_Upgrade_Panel/Right_Under_Upgrade_After_Panel/HBox_After_Attack/After_Attack
@onready var after_amount = $Right_Panel/Right_Under_Upgrade_Panel/Right_Under_Upgrade_After_Panel/HBox_After_Amount/After_Amount

@onready var right_under_text = $Right_Panel/Right_Under_Panel/Right_Under_Text

@onready var right_under_upgrade_panel = $Right_Panel/Right_Under_Upgrade_Panel
@onready var right_under_upgrade_after_panel = $Right_Panel/Right_Under_Upgrade_Panel/Right_Under_Upgrade_After_Panel
@onready var right_under_upgrade_max_text = $Right_Panel/Right_Under_Upgrade_Panel/Right_Under_Upgrade_MAX
@onready var right_under_panel = $Right_Panel/Right_Under_Panel

@onready var weaponup_panel = $Right_Panel/Panel/WeaponUpPanel
@onready var weaponup_normal = $Right_Panel/WeaponUpButton/WeaponUp_Normal
@onready var weaponup_over = $Right_Panel/WeaponUpButton/WeaponUp_Over
@onready var weaponup_texture = $Right_Panel/Panel/WeaponUpTexture

@onready var storeup_weapon = $Left_Panel/MarginContainer/VBoxContainer/ScrollContainer/Store_Up_Weapon_Inventory

@onready var item_name_text = $Left_Panel/MarginContainer/VBoxContainer/Item_Name

@onready var right_panel = $Right_Panel
@onready var left_panel = $Left_Panel

var selected_entry_id = ""
var selected_item_id = "long_sword"

var item_max = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_right_under(false)
	_set_left_item_name(false)

func _set_language():
	var lang_stat = LangData.weapon_up.get(LangData.language)
	var lang_stat2 = LangData.weapon_name.get(LangData.language)
	
	before_name_text.text = lang_stat2.get(selected_item_id) + " +"
	before_atk_text.text = lang_stat.get("watk") + " : "
	before_amount_text.text = lang_stat.get("amount") + " : "
	after_name_text.text = lang_stat2.get(selected_item_id) + " +"
	after_atk_text.text = lang_stat.get("watk") + " : "
	after_amount_text.text = lang_stat.get("amount") + " : "
	

func _set_right_under(selected):
	var lang_stat = LangData.weapon_up.get(LangData.language)
	if selected:
		right_under_upgrade_after_panel.visible = false
		right_under_upgrade_max_text.visible = true
	else:
		right_under_text.text = lang_stat.get("unselect")
		right_under_upgrade_panel.visible = false
		right_under_panel.visible = true

func _upgrade_preview():
	right_under_upgrade_panel.visible = true
	right_under_upgrade_after_panel.visible = true
	right_under_upgrade_max_text.visible = false
	right_under_panel.visible = false
	
	#var preview: Dictionary = Api.maintenance.get_equipment_upgrade_preview(selected_entry_id, FrontGlobal.player_id)
	var preview: Dictionary = Api.maintenance.get_equipment_upgrade_preview(
		selected_entry_id,
		FrontGlobal.player_id
	)
	
	#print(preview.get("current_effects", {}))
	
	if not bool(preview.get("ok", false)):
		#print(preview.get("reason", "UNKNOWN"))
		return
		
	var current_level = preview.get("upgrade_level", 0)
	var next_level = preview.get("next_upgrade_level", 0)
	var max_level = preview.get("upgrade_level_max", 0)

	var current_effects: Dictionary = preview.get("current_effects", {})
	var stat_add: Dictionary = current_effects.get("stat_add", {})

	var has_attack: bool = stat_add.has("physical_attack")
	var current_atk: float = float(stat_add.get("physical_attack", 0.0))
	#var current_atk = floor(preview["current_effects"]["stat_add"]["physical_attack"] * 10.0) / 10.0

	var next_effects: Dictionary = preview.get("current_effects", {})
	var next_stat_add: Dictionary = next_effects.get("stat_add", {})

	var next_has_attack: bool = next_stat_add.has("physical_attack")
	var next_atk: float = float(next_stat_add.get("physical_attack", 0.0))
	#var next_atk = floor(preview["next_effects"]["stat_add"]["physical_attack"] * 10.0) / 10.0
	
	before_upgrade.text = str(current_level)
	before_atk.text = str(current_atk)
	before_amount.text = str(1)
	after_upgrade.text = str(next_level)
	after_atk.text = str(next_atk)
	after_amount.text = str(1)
	
	if current_level == max_level:
		_set_right_under(true)
		item_max = true
	else:
		item_max = false
	
	
func _sell_button_pressed():
	storeup_weapon._reset_inven()
	
func _other_button_pressed():
	_remove_up_item()
	_sell_inventory_control(false, true)

#무기 강화
func _on_weapon_up_button_mouse_entered() -> void:
	if selected_entry_id == "" or item_max:
		return
		
	weaponup_normal.visible = false
	weaponup_over.visible = true


func _on_weapon_up_button_mouse_exited() -> void:
	if selected_entry_id == "" or item_max:
		return
		
	weaponup_normal.visible = true
	weaponup_over.visible = false


func _on_weapon_up_button_pressed() -> void:
	if selected_entry_id == "" or item_max:
		return
	
	var result: Dictionary = Api.maintenance.upgrade_inventory_item(selected_entry_id, FrontGlobal.player_id)
	get_parent().get_parent().get_parent()._get_coin()
	_upgrade_preview()


func _on_weapon_up_texture_button_mouse_entered() -> void:
	weaponup_panel.visible = true


func _on_weapon_up_texture_button_mouse_exited() -> void:
	weaponup_panel.visible = false


func _on_weapon_up_texture_button_pressed() -> void:
	if left_panel.position.x < -1397:
		_sell_inventory_control(true, false)
	elif left_panel.position.x > -1397:
		_sell_inventory_control(false, false)

func _sell_inventory_control(show, other_press):
	var tween = create_tween()
	if other_press:
		right_panel.visible = false
	if show:
		if left_panel.position.x < -1397:
			get_parent().get_parent().get_parent().blocker.visible = true
			tween.tween_property(left_panel, "position:x", -728, 0.2)
	else:
		if left_panel.position.x > -1397:
			get_parent().get_parent().get_parent().blocker.visible = true
			tween.tween_property(left_panel, "position:x", -1398, 0.2)
	await get_tree().create_timer(0.2).timeout
	if other_press:
		self.visible = false
		right_panel.visible = true
	get_parent().get_parent().get_parent().blocker.visible = false

func _set_up_item(entry_id: String, item_id: String):
	selected_entry_id = entry_id
	selected_item_id = item_id
	weaponup_texture.texture  = FrontGlobal._set_item_texture(item_id)
	_set_language()
	_set_left_item_name(true)
	_upgrade_preview()

func _remove_up_item():
	selected_entry_id = ""
	_set_right_under(false)
	_set_left_item_name(false)
	weaponup_texture.texture = null

func _set_left_item_name(selected):
	var lang_stat = LangData.weapon_name.get(LangData.language)
	if selected:
		item_name_text.text = lang_stat.get(selected_item_id)
	else:
		item_name_text.text = ""
		
