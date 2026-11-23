extends Control

@onready var storesell_grid = $Right_Panel/SellContainer/MarginContainer/SellGrid

@onready var storesell_left = $Left_Panel
@onready var storesell_weapon = $Left_Panel/MarginContainer/VBoxContainer/ScrollContainer/Store_Sell_Weapon_Inventory
@onready var storesell_accessory = $Left_Panel/MarginContainer/VBoxContainer/ScrollContainer/Store_Sell_Accessory_Inventory
@onready var storesell_memory = $Left_Panel/MarginContainer/VBoxContainer/ScrollContainer/Store_Sell_Accessory_Inventory

@onready var storesellapply_normal = $Right_Panel/StoreSellApplyButton/StoreSellApply_Normal
@onready var storesellapply_over = $Right_Panel/StoreSellApplyButton/StoreSellApply_Over
@onready var storesellapply_text = $Right_Panel/StoreSellApplyButton/StoreSellApply_Text
@onready var storesellcancel_normal = $Right_Panel/StoreSellCancelButton/StoreSellCancel_Normal
@onready var storesellcancel_over = $Right_Panel/StoreSellCancelButton/StoreSellCancel_Over
@onready var storesellcancel_text = $Right_Panel/StoreSellCancelButton/StoreSellCancel_Text
@onready var weaponsell_normal = $Left_Panel/WeaponSellButton/WeaponSell_Normal
@onready var weaponsell_over = $Left_Panel/WeaponSellButton/WeaponSell_Over
@onready var accessorysell_normal = $Left_Panel/AccessorySellButton/AccessorySell_Normal
@onready var accessorysell_over = $Left_Panel/AccessorySellButton/AccessorySell_Over
@onready var helmetsell_normal = $Left_Panel/HelmetSellButton/HelmetSell_Normal
@onready var helmetsell_over = $Left_Panel/HelmetSellButton/HelmetSell_Over
@onready var weaponsell_button = $Left_Panel/WeaponSellButton
@onready var accessorysell_button = $Left_Panel/AccessorySellButton
@onready var helmetell_button = $Left_Panel/HelmetSellButton
@onready var weaponup_left = $Left_Panel/WeaponUp

@onready var right_panel = $Right_Panel
@onready var left_panel = $Left_Panel

@onready var item_name_text = $Left_Panel/MarginContainer/VBoxContainer/Item_Name

var click_left = ""

var sell_item_type = []
var entry_id = []

var selected_item_id = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_left_item_name(false)

	
func _sell_button_pressed():
	_on_weapon_sell_button_pressed()
	storesell_weapon._after_sell()
	storesell_accessory._after_sell()
	storesell_memory._after_sell()
	_sell_inventory_control(true)

#func _after_buy():
	#storesell_weapon._after_sell()
	#storesell_accessory._after_sell()
	
func _other_button_pressed():
	_on_store_sell_cancel_button_pressed()
	right_panel.visible = false
	_sell_inventory_control(false)

func _sell_inventory_control(show):
	var tween = create_tween()
	if show:
		if left_panel.position.x < -1397:
			get_parent().get_parent().get_parent().blocker.visible = true
			tween.tween_property(left_panel, "position:x", -728, 0.2)
	else:
		if left_panel.position.x > -1397:
			right_panel.visible = false
			get_parent().get_parent().get_parent().blocker.visible = true
			tween.tween_property(left_panel, "position:x", -1398, 0.2)
	await get_tree().create_timer(0.2).timeout
	get_parent().get_parent().get_parent().blocker.visible = false
	if right_panel.visible == false:
		self.visible = false
		right_panel.visible = true


func create_item(name: String, item_id: String) -> void:
	#print(item_id)
	var panel := Panel.new()
	panel.name = name
	panel.custom_minimum_size = Vector2(130, 130)

	var button := TextureButton.new()
	button.name = item_id
	button.anchor_right = 1.0
	button.anchor_bottom = 1.0
	button.texture_normal  = FrontGlobal._set_item_texture(item_id)
	button.ignore_texture_size = true
	button.stretch_mode = TextureButton.STRETCH_SCALE
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL

	panel.add_child(button)
	storesell_grid.add_child(panel)
	
	_set_panel_style(panel, false)

	button.mouse_entered.connect(_on_sell_item_button_mouse_entered.bind(panel))
	button.mouse_exited.connect(_on_sell_item_button_mouse_exited.bind(panel))
	button.pressed.connect(_on_sell_right_item_button_pressed.bind(panel))
	
	selected_item_id = item_id
	_set_left_item_name(true)
	
func _set_panel_style(panel: Panel, selected: bool) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#2c2f33")
	style.border_color = Color.WHITE if selected else Color("#2b2b2f")
	style.set_border_width_all(3)

	panel.add_theme_stylebox_override("panel", style)


func _on_sell_item_button_mouse_entered(panel: Panel) -> void:
	_set_panel_style(panel, true)


func _on_sell_item_button_mouse_exited(panel: Panel) -> void:
	_set_panel_style(panel, false)



func _on_sell_right_item_button_pressed(panel: Panel) -> void:
	panel.queue_free()
	var name = panel.name
	var result = name.trim_suffix("_1")
	if sell_item_type.has("weapon"):
		var target = storesell_weapon.get_node(result)
		storesell_weapon._remove_right_panel(target)
	if sell_item_type.has("accessory"):
		var target = storesell_accessory.get_node(result)
		storesell_accessory._remove_right_panel(target)
	if sell_item_type.has("memory"):
		var target = storesell_memory.get_node(result)
		storesell_memory._remove_right_panel(target)
	#print(entry_id)


func _remove_item(target_name: String):
	var target = storesell_grid.get_node(target_name)
	target.queue_free()
	

func _on_store_sell_apply_button_mouse_entered() -> void:
	storesellapply_normal.visible = false
	storesellapply_over.visible = true
	storesellapply_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))


func _on_store_sell_apply_button_mouse_exited() -> void:
	storesellapply_normal.visible = true
	storesellapply_over.visible = false
	storesellapply_text.add_theme_color_override("font_color", Color.WHITE)


func _on_store_sell_apply_button_pressed() -> void:
	for a in entry_id.size():
		var result = Api.maintenance.sell_inventory_item(entry_id[a], FrontGlobal.player_id)
		if sell_item_type.has("weapon"):
			storesell_weapon._after_sell()
		if sell_item_type.has("accessory"):
			storesell_accessory._after_sell()
		if sell_item_type.has("memory"):
			storesell_memory._after_sell()
		entry_id.erase(get_child(0).get_meta("entry_id"))
		#_on_store_sell_cancel_button_pressed()
	for child in storesell_grid.get_children():
		remove_child(child)
		child.queue_free()
	get_parent().get_parent().get_parent()._get_coin()
	get_parent().get_node("Store_Buy")._after_sell()
	_set_left_item_name(false)

func _on_store_sell_cancel_button_mouse_entered() -> void:
	storesellcancel_normal.visible = false
	storesellcancel_over.visible = true
	storesellcancel_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))


func _on_store_sell_cancel_button_mouse_exited() -> void:
	storesellcancel_normal.visible = true
	storesellcancel_over.visible = false
	storesellcancel_text.add_theme_color_override("font_color", Color.WHITE)


func _on_store_sell_cancel_button_pressed() -> void:
	for child in storesell_grid.get_children():
		_on_sell_right_item_button_pressed(child)


func _on_weapon_sell_button_mouse_entered() -> void:
	weaponsell_normal.visible = false
	weaponsell_over.visible = true


func _on_weapon_sell_button_mouse_exited() -> void:
	if click_left == "weapon":
		return
		
	weaponsell_normal.visible = true
	weaponsell_over.visible = false


func _on_weapon_sell_button_pressed() -> void:
	weaponsell_normal.visible = false
	weaponsell_over.visible = true
	click_left = "weapon"
	_click_left_reset()
	
	storesell_weapon.visible = true
	storesell_accessory.visible = false
	storesell_memory.visible = false


func _on_accessory_sell_button_mouse_entered() -> void:
	accessorysell_normal.visible = false
	accessorysell_over.visible = true


func _on_accessory_sell_button_mouse_exited() -> void:
	if click_left == "accessory":
		return
		
	accessorysell_normal.visible = true
	accessorysell_over.visible = false


func _on_accessory_sell_button_pressed() -> void:
	accessorysell_normal.visible = false
	accessorysell_over.visible = true
	click_left = "accessory"
	_click_left_reset()
	
	storesell_weapon.visible = false
	storesell_accessory.visible = true
	storesell_memory.visible = false


func _on_helmet_sell_button_mouse_entered() -> void:
	helmetsell_normal.visible = false
	helmetsell_over.visible = true


func _on_helmet_sell_button_mouse_exited() -> void:
	if click_left == "memory":
		return
		
	helmetsell_normal.visible = true
	helmetsell_over.visible = false


func _on_helmet_sell_button_pressed() -> void:
	helmetsell_normal.visible = false
	helmetsell_over.visible = true
	click_left = "memory"
	_click_left_reset()
	
	storesell_weapon.visible = false
	storesell_accessory.visible = false
	storesell_memory.visible = true

func _click_left_reset():
	_on_weapon_sell_button_mouse_exited()
	_on_accessory_sell_button_mouse_exited()
	_on_helmet_sell_button_mouse_exited()

func _set_left_item_name(selected):
	var lang_stat = LangData.weapon_name.get(LangData.language)
	if selected:
		if lang_stat.get(selected_item_id) == null:
			item_name_text.text = "테스트 용 아이템"
		else:
			item_name_text.text = lang_stat.get(selected_item_id)
	else:
		item_name_text.text = ""
