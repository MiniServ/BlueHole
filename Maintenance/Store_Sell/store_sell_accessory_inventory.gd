extends GridContainer


var selected_panel = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_load_inventory()
	_get_inventory_accessories()
	
#func _load_inventory():
	#var load_result: Dictionary = Api.data.load_inventory(FrontGlobal.inventory_id)
	#var load_inventory_resource: Dictionary = load_result.get("resource", {}) if load_result.get("resource", {}) is Dictionary else {}
	#Api.inventory.apply_inventory_resource(load_inventory_resource)

func _get_inventory_accessories():
	for accessories in FrontGlobal.inventory_resource["items"]["accessories"]:
		if FrontGlobal.equip_weapon_id.has(accessories["item_id"]):
			pass
		else:
			create_item(accessories["item_id"], accessories["item_type"], accessories["entry_id"])

func _after_sell():
	for child in get_children():
		remove_child(child)
		child.queue_free()
		
	#_load_inventory()
	FrontGlobal._snapshot_inventory()
	_get_inventory_accessories()

func create_item(item_id: String, item_type: String, entry_id: String) -> void:
	var panel := Panel.new()
	#panel.name = _make_unique_name(self, "Item")
	panel.name = item_id
	panel.set_meta("item_id", item_id)
	panel.custom_minimum_size = Vector2(130, 130)

	var button := TextureButton.new()
	button.name = entry_id
	button.set_meta("entry_id", entry_id)
	button.anchor_right = 1.0
	button.anchor_bottom = 1.0
	button.texture_normal  = FrontGlobal._set_item_texture(item_id)
	button.ignore_texture_size = true
	button.stretch_mode = TextureButton.STRETCH_SCALE
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL

	panel.add_child(button)
	add_child(panel)

	_set_panel_style(panel, false)

	button.mouse_entered.connect(_on_iventory_item_button_mouse_entered.bind(panel))
	button.mouse_exited.connect(_on_iventory_item_button_mouse_exited.bind(panel))
	button.pressed.connect(_on_iventory_right_item_button_pressed.bind(panel))

#이름 랜덤 생성 및 중복 확인
#func _make_unique_name(parent: Node, prefix: String) -> String:
	#var new_name: String
#
	#while true:
		#new_name = "%s_%d_%d" % [
			#prefix,
			#Time.get_ticks_usec(),
			#randi()
		#]
#
		#if not parent.has_node(NodePath(new_name)):
			#return new_name
			#
	#return ""
	
func _set_panel_style(panel: Panel, selected: bool) -> void:
	#print(panel.name)
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#2c2f33")
	style.border_color = Color.WHITE if selected else Color("#2b2b2f")
	style.set_border_width_all(3)

	panel.add_theme_stylebox_override("panel", style)


func _on_iventory_item_button_mouse_entered(panel: Panel) -> void:
	var parent = get_parent().get_parent().get_parent().get_parent().get_parent()
	parent.selected_item_id = panel.get_meta("item_id")
	parent._set_left_item_name(true)
	_set_panel_style(panel, true)


func _on_iventory_item_button_mouse_exited(panel: Panel) -> void:
	var parent = get_parent().get_parent().get_parent().get_parent().get_parent()
	if selected_panel.has(panel.name):
		parent.selected_item_id = panel.get_meta("item_id")
		parent._set_left_item_name(true)
		return
	elif selected_panel.size() > 0:
		var panel_name = NodePath(selected_panel.back())
		#print(get_node(panel_name).get_meta("item_id"))
		parent.selected_item_id = get_node(panel_name).get_meta("item_id")
		parent._set_left_item_name(true)
	else:
		parent.selected_item_id = ""
		parent._set_left_item_name(false)

	_set_panel_style(panel, false)



func _on_iventory_right_item_button_pressed(panel: Panel) -> void:
	var parent = get_parent().get_parent().get_parent().get_parent().get_parent()
	var child = panel.get_child(0)
	if selected_panel.has(panel.name):
		selected_panel.erase(panel.name)
		parent.entry_id.erase(child.get_meta("entry_id"))
		parent.sell_item_type.erase("accessory")
		_set_panel_style(panel, false)
		parent._remove_item(panel.name)
	else:
		selected_panel.append(panel.name)
		parent.entry_id.append(child.get_meta("entry_id"))
		parent.sell_item_type.append("accessory")
		_set_panel_style(panel, true)
		parent.create_item(panel.name, panel.get_meta("item_id"))

func _remove_right_panel(panel: Panel):
	var parent = get_parent().get_parent().get_parent().get_parent().get_parent()
	_set_panel_style(panel, false)
	selected_panel.erase(panel.name)
	parent.sell_item_type.erase("accessory")
