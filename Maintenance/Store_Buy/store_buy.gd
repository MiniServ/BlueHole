extends Control

#재화
@onready var coin_after = $Coin_After

@onready var storebuyapply = $StoreBuyApplyButton

@onready var storebuyapply_normal = $StoreBuyApplyButton/StoreBuyApply_Normal
@onready var storebuyapply_over = $StoreBuyApplyButton/StoreBuyApply_Over
@onready var storebuyapply_text = $StoreBuyApplyButton/StoreBuyApply_Text
@onready var storebuycancel_normal = $StoreBuyCancelButton/StoreBuyCancel_Normal
@onready var storebuycancel_over = $StoreBuyCancelButton/StoreBuyCancel_Over
@onready var storebuycancel_text =  $StoreBuyCancelButton/StoreBuyCancel_Text

@onready var store_buy_grid = $ScrollContainer/MarginContainer/GridContainer

@onready var item_name_text = $Item_Name

var selected_panel: Panel = null

var used_coin = 0

var inventory_item: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_item()
	_get_need_coin(false)
	_set_left_item_name(false, "")

func _set_item():
	_get_inventory_item()
	var result: Dictionary = Api.maintenance.get_equipment_shop_items("simul_player_test01")
	var shop_items: Array = result.get("equipment_shop_items", []) if result.get("equipment_shop_items", []) is Array else []
	var a = 0
	for item_variant: Variant in shop_items:
		a += 1
		if item_variant is Dictionary:
			var item: Dictionary = item_variant
			var item_id: String = str(item.get("item_id", "")) 
			var shop_item_id: String = str(item.get("shop_item_id", ""))
			#print(item_id)
			if a == 4 or a == 5:
				create_store_locked_item(shop_item_id, item_id)
			else:
				if inventory_item.has(item_id):
					create_store_selled_item(shop_item_id, item_id)
				else:
					create_store_item(shop_item_id, item_id)
			
			#print(item_variant)
			
	_set_item_order()

func _set_item_order():
	
	var items = store_buy_grid.get_children()

	items.sort_custom(func(a: Node, b: Node) -> bool:
		var type_order := {
			"sell": 0,
			"locked": 1,
			"selled": 2,
		}

		return type_order.get(a.get_meta("type", ""), 999) \
			< type_order.get(b.get_meta("type", ""), 999)
	)

	for i in items.size():
		store_buy_grid.move_child(items[i], i)

func _after_sell():
	inventory_item.clear()
	for child in store_buy_grid.get_children():
		store_buy_grid.remove_child(child)
		child.queue_free()
	
	_set_item()

func _get_inventory_item():
	FrontGlobal._snapshot_inventory()
	for weapon in FrontGlobal.inventory_resource["items"]["weapons"]:
		inventory_item.append(weapon["item_id"])
		
	for weapon in FrontGlobal.inventory_resource["items"]["accessories"]:
		inventory_item.append(weapon["item_id"])
		
	for weapon in FrontGlobal.inventory_resource["items"]["talismans"]:
		inventory_item.append(weapon["item_id"])
		
	for weapon in FrontGlobal.inventory_resource["items"]["memories"]:
		inventory_item.append(weapon["item_id"])
	
	#print("인벤토리",inventory_item)

func _get_need_coin(selected):
	var snapshot = Api.stat.get_snapshot()
	used_coin = snapshot.get("growth_currency", 0)
	if selected:
		used_coin -= 1000
	
	coin_after.text = str(used_coin)
	
	if used_coin < 0:
		coin_after.add_theme_color_override("font_color", Color.RED)
	else:
		coin_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))

#구매
func _on_store_buy_apply_button_mouse_entered() -> void:
	if not storebuyapply.disabled:
		storebuyapply_normal.visible = false
		storebuyapply_over.visible = true
		storebuyapply_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))


func _on_store_buy_apply_button_mouse_exited() -> void:
	storebuyapply_normal.visible = true
	storebuyapply_over.visible = false
	storebuyapply_text.add_theme_color_override("font_color", Color.WHITE)


func _on_store_buy_apply_button_pressed() -> void:
	var result = Api.maintenance.purchase_equipment_item(selected_panel.name, "simul_player_test01")
	#print(result)
	if not bool(result.get("ok", false)):
		var reason: String = str(result.get("reason", "UNKNOWN"))
		return
	
	#print("구매결과 : ",result)
	var entry_id: String = str(result.get("entry_id", ""))
	var item_type: String = str(result.get("item_type", ""))
	#Api.inventory.add_item(item_type, selected_panel.name, selected_panel.name, entry_id)
	selected_panel.queue_free()
	create_store_selled_item(selected_panel.name, selected_panel.get_meta("item_id"))
	storebuyapply.disabled = true
	get_parent().get_parent().get_parent()._get_coin()
	_get_need_coin(false)


func _on_store_buy_cancel_button_mouse_entered() -> void:
	storebuycancel_normal.visible = false
	storebuycancel_over.visible = true
	storebuycancel_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))


func _on_store_buy_cancel_button_mouse_exited() -> void:
	storebuycancel_normal.visible = true
	storebuycancel_over.visible = false
	storebuycancel_text.add_theme_color_override("font_color", Color.WHITE)


func _on_store_buy_cancel_button_pressed() -> void:
	if selected_panel:
		_on_store_right_item_button_pressed(selected_panel)


func create_store_item(shop_item_id: String, item_id: String) -> void:
	var panel := Panel.new()
	panel.name = shop_item_id
	panel.custom_minimum_size = Vector2(130, 130)
	panel.set_meta("type", "sell")
	panel.set_meta("item_id", item_id)

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
	store_buy_grid.add_child(panel)

	_set_panel_style(panel, false)

	button.mouse_entered.connect(_on_store_item_button_mouse_entered.bind(panel))
	button.mouse_exited.connect(_on_store_item_button_mouse_exited.bind(panel))
	button.pressed.connect(_on_store_right_item_button_pressed.bind(panel))
	
func create_store_selled_item(shop_item_id: String, item_id: String) -> void:
	var panel := Panel.new()
	panel.name = shop_item_id
	panel.custom_minimum_size = Vector2(130, 130)
	panel.set_meta("type", "selled")
	panel.set_meta("item_id", item_id)

	var button := TextureButton.new()
	button.name = item_id
	button.custom_minimum_size = Vector2(130, 130)
	button.texture_normal  = FrontGlobal._set_item_texture(item_id)
	button.ignore_texture_size = true
	button.stretch_mode = TextureButton.STRETCH_SCALE
	
	button.add_child(panel)
	store_buy_grid.add_child(button)

	_set_panel_style_selled(panel)
	
func create_store_locked_item(shop_item_id: String, item_id: String) -> void:
	var panel := Panel.new()
	panel.name = shop_item_id
	panel.custom_minimum_size = Vector2(130, 130)
	panel.set_meta("type", "locked")
	panel.set_meta("item_id", item_id)

	var button := TextureButton.new()
	button.name = item_id
	button.anchor_right = 1.0
	button.anchor_bottom = 1.0
	button.texture_normal  = FrontGlobal._set_item_texture(item_id)
	button.ignore_texture_size = true
	button.stretch_mode = TextureButton.STRETCH_SCALE
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	button.modulate.a = 0.2

	panel.add_child(button)
	store_buy_grid.add_child(panel)

	_set_panel_style_locked(panel)

func _on_store_item_button_mouse_entered(panel: Panel) -> void:
	_set_left_item_name(true, panel.get_meta("item_id"))
	_set_panel_style(panel, true)


func _on_store_item_button_mouse_exited(panel: Panel) -> void:
	if selected_panel == panel:
		_set_left_item_name(true, selected_panel.get_meta("item_id"))
		return
	elif selected_panel != null:
		_set_left_item_name(true, selected_panel.get_meta("item_id"))
	else:
		_set_left_item_name(false, "")
		

	_set_panel_style(panel, false)



func _on_store_right_item_button_pressed(panel: Panel) -> void:
	if selected_panel != null and selected_panel != panel:
		_set_panel_style(selected_panel, false)
	
	if selected_panel == panel:
		_set_panel_style(selected_panel, false)
		selected_panel = null
		storebuyapply.disabled = true
		_get_need_coin(false)
		_set_left_item_name(false, "")
		return
	
	selected_panel  = panel
	_set_panel_style(panel, true)
	_get_need_coin(true)
	if used_coin >= 0:
		storebuyapply.disabled = false
	_set_left_item_name(true, panel.get_meta("item_id"))
	

	
func _set_panel_style(panel: Panel, selected: bool) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#2c2f33")
	style.border_color = Color.WHITE if selected else Color("#2b2b2f")
	style.set_border_width_all(3)

	panel.add_theme_stylebox_override("panel", style)
	
func _set_panel_style_selled(panel: Panel) -> void:
	var style := StyleBoxTexture.new()
	style.texture = preload("res://ui/art/ui/Strore_ui_box.png")
	style.region_rect = Rect2(2450, 316, 263, 263)
	

	panel.add_theme_stylebox_override("panel", style)
	
func _set_panel_style_locked(panel: Panel) -> void:
	var style := StyleBoxTexture.new()
	style.texture = preload("res://ui/art/ui/Strore_ui_box.png")
	style.region_rect = Rect2(2848, 316, 263, 263)

	panel.add_theme_stylebox_override("panel", style)


func _set_left_item_name(selected, selected_item_id):
	var lang_stat = LangData.weapon_name.get(LangData.language)
	if selected:
		if lang_stat.get(selected_item_id) == null:
			item_name_text.text = "테스트 용 아이템"
		else:
			item_name_text.text = lang_stat.get(selected_item_id)
	else:
		item_name_text.text = ""
