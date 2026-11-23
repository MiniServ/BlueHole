extends CanvasLayer

@onready var player_normal = $MarginContainer/Panel/PlayerButton/Player_Normal
@onready var player_over = $MarginContainer/Panel/PlayerButton/Player_Over
@onready var buy_normal = $MarginContainer/Panel/StoreBuyButton/Buy_Normal
@onready var buy_over = $MarginContainer/Panel/StoreBuyButton/Buy_Over
@onready var weapon_normal = $MarginContainer/Panel/WeaponButton/Weapon_Normal
@onready var weapon_over = $MarginContainer/Panel/WeaponButton/Weapon_Over
@onready var potion_normal = $MarginContainer/Panel/PotionButton/Potion_Normal
@onready var potion_over = $MarginContainer/Panel/PotionButton/Potion_Over
@onready var sell_normal = $MarginContainer/Panel/StoreSellButton/Sell_Normal
@onready var sell_over = $MarginContainer/Panel/StoreSellButton/Sell_Over

@onready var soulstone = $MarginContainer/Panel/SoulStone_Text

@onready var player_upgrade = $MarginContainer/Panel/Player_Upgrade
@onready var Store_Buy = $MarginContainer/Panel/Store_Buy
@onready var weapon_upgrade = $MarginContainer/Panel/Weapon_Upgrade
@onready var potion = $MarginContainer/Panel/Potion
@onready var Store_Sell = $MarginContainer/Panel/Store_Sell

@onready var blocker = $Blocker

var snapshot: Dictionary

var click = ""
var click_left = ""
var left = false

var click_store_right = []
var selected_panel: Panel = null
var click_store_left = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blocker.visible = true
	self.visible = false
	#_on_player_button_pressed()
	#_on_weapon_sell_button_pressed()
	_get_coin()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#상점 기본
func _get_coin():
	#snapshot = Api.stat.get_snapshot()
	#coin.text = str(snapshot.get("growth_currency", 0))
	soulstone.text = "111"

func _on_player_button_mouse_entered() -> void:
	player_normal.visible = false
	player_over.visible = true


func _on_player_button_mouse_exited() -> void:
	if click == "player":
		pass
	else:
		player_normal.visible = true
		player_over.visible = false


func _on_player_button_pressed() -> void:
	player_normal.visible = false
	player_over.visible = true
	
	click = "player"
	_click_reset()
	
	player_upgrade.visible = true
	Store_Buy.visible = false
	potion.visible = false
	Store_Sell._other_button_pressed()
	weapon_upgrade._other_button_pressed()
	


func _on_store_buy_button_mouse_entered() -> void:
	buy_normal.visible = false
	buy_over.visible = true


func _on_store_buy_button_mouse_exited() -> void:
	if click == "buy":
		pass
	else:
		buy_normal.visible = true
		buy_over.visible = false


func _on_store_buy_button_pressed() -> void:
	buy_normal.visible = false
	buy_over.visible = true
	
	click = "buy"
	_click_reset()
	
	player_upgrade.visible = false
	Store_Buy.visible = true
	potion.visible = false
	Store_Sell._other_button_pressed()
	weapon_upgrade._other_button_pressed()


func _on_weapon_button_mouse_entered() -> void:
	weapon_normal.visible = false
	weapon_over.visible = true


func _on_weapon_button_mouse_exited() -> void:
	if click == "weapon":
		pass
	else:
		weapon_normal.visible = true
		weapon_over.visible = false


func _on_weapon_button_pressed() -> void:
	weapon_normal.visible = false
	weapon_over.visible = true
	
	click = "weapon"
	_click_reset()
	
	player_upgrade.visible = false
	Store_Buy.visible = false
	potion.visible = false
	weapon_upgrade._sell_button_pressed()
	weapon_upgrade.visible = true
	Store_Sell._other_button_pressed()


func _on_potion_button_mouse_entered() -> void:
	potion_normal.visible = false
	potion_over.visible = true


func _on_potion_button_mouse_exited() -> void:
	if click == "potion":
		pass
	else:
		potion_normal.visible = true
		potion_over.visible = false


func _on_potion_button_pressed() -> void:
	potion_normal.visible = false
	potion_over.visible = true
	
	click = "potion"
	_click_reset()
	
	player_upgrade.visible = false
	Store_Buy.visible = false
	potion.visible = true
	Store_Sell._other_button_pressed()
	weapon_upgrade._other_button_pressed()


func _on_store_sell_button_mouse_entered() -> void:
	sell_normal.visible = false
	sell_over.visible = true


func _on_store_sell_button_mouse_exited() -> void:
	if click == "sell":
		pass
	else:
		sell_normal.visible = true
		sell_over.visible = false


func _on_store_sell_button_pressed() -> void:
	sell_normal.visible = false
	sell_over.visible = true
	
	click = "sell"
	_click_reset()
	
	player_upgrade.visible = false
	Store_Buy.visible = false
	potion.visible = false
	Store_Sell.visible = true
	weapon_upgrade._other_button_pressed()
	
	Store_Sell._sell_button_pressed()

func _click_reset():
	_on_player_button_mouse_exited()
	_on_store_buy_button_mouse_exited()
	_on_weapon_button_mouse_exited()
	_on_potion_button_mouse_exited()
	_on_store_sell_button_mouse_exited()

#항목 추가
func create_store_item(item_id: String, type: String) -> void:
	var store_buy_grid = $MarginContainer/Panel/StoreBuyLayer/ScrollContainer/MarginContainer/GridContainer
	var store_sell_grid = $MarginContainer/Panel/StoreSellLayer/ScrollContainer/MarginContainer/GridContainer
	var store_left_weapon_grid = $MarginContainer/Panel/StoreSell_Left/ScrollContainer/MarginContainer/WeaponContainer
	var store_left_accessory_grid = $MarginContainer/Panel/StoreSell_Left/ScrollContainer/MarginContainer/AccesoryContainer
	var store_left_helmet_grid = $MarginContainer/Panel/StoreSell_Left/ScrollContainer/MarginContainer/HelmetContainer
	var store_left_weaponup_grid = $MarginContainer/Panel/StoreSell_Left/ScrollContainer/MarginContainer/WeaponUpContainer

	var panel := Panel.new()
	panel.name = item_id
	panel.custom_minimum_size = Vector2(130, 130)

	var button := TextureButton.new()
	button.name = "TextureButton"
	button.anchor_right = 1.0
	button.anchor_bottom = 1.0
	#button.texture_normal = preload("res://ui/art/test/weapon/Arrow01(32x32).png")
	button.ignore_texture_size = true
	button.stretch_mode = TextureButton.STRETCH_SCALE
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL

	panel.add_child(button)
	if type == "buy":	
		store_buy_grid.add_child(panel)
	elif type == "sell":
		store_sell_grid.add_child(panel)
	elif type == "left_weaponup":
		store_left_weaponup_grid.add_child(panel)
	elif type == "left_weapon":
		store_left_weapon_grid.add_child(panel)
	elif type == "left_accessory":
		store_left_accessory_grid.add_child(panel)
	elif type == "left_helmet":
		store_left_helmet_grid.add_child(panel)

	_set_panel_style(panel, false)

	button.mouse_entered.connect(_on_store_item_button_mouse_entered.bind(panel))
	button.mouse_exited.connect(_on_store_item_button_mouse_exited.bind(panel))
	if type.substr(0, 4) == "left":
		if type.right(2) == "up":
			button.pressed.connect(_on_store_left_up_item_button_pressed.bind(panel))
		else:
			button.pressed.connect(_on_store_left_item_button_pressed.bind(panel))
	else:
		button.pressed.connect(_on_store_right_item_button_pressed.bind(panel))


func _on_store_item_button_mouse_entered(panel: Panel) -> void:
	_set_panel_style(panel, true)


func _on_store_item_button_mouse_exited(panel: Panel) -> void:
	if selected_panel == panel or click_store_left.has(panel.name):
		return

	_set_panel_style(panel, false)



func _on_store_right_item_button_pressed(panel: Panel) -> void:
	if selected_panel != null and selected_panel != panel:
		_set_panel_style(selected_panel, false)
	
	if selected_panel == panel:
		_set_panel_style(selected_panel, false)
		selected_panel = null
		return
	
	selected_panel  = panel
	_set_panel_style(panel, true)

	#print(selected_panel)
	
func _on_store_left_item_button_pressed(panel: Panel) -> void:
	if click_store_left.has(panel.name):
		click_store_left.erase(panel.name)
		_set_panel_style(panel, false)
		var store_sell_grid = $MarginContainer/Panel/StoreSellLayer/ScrollContainer/MarginContainer/GridContainer
		var target = store_sell_grid.get_node(panel.name + "_1")
		#print(target)
		target.queue_free()
	else:
		click_store_left.append(panel.name)
		_set_panel_style(panel, true)
		create_store_item(panel.name + "_1", "sell")

	#print(click_store_left)
	
func _on_store_left_up_item_button_pressed(panel: Panel) -> void:
	pass
	
func _set_panel_style(panel: Panel, selected: bool) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#2c2f33")
	style.border_color = Color.WHITE if selected else Color("#2b2b2f")
	style.set_border_width_all(3)

	panel.add_theme_stylebox_override("panel", style)
		


func _on_texture_button_pressed1(extra_arg_0: int) -> void:
	match  extra_arg_0:
		1: create_store_item("item001", "left_weapon")
		2: create_store_item("item001", "left_accessory")
		3: create_store_item("item001", "left_helmet")
		4: create_store_item("item001", "left_weaponup")


func _on_button_pressed() -> void:
	self.visible = false
	player_upgrade.visible = false
	potion.visible = false
	weapon_upgrade.visible = false
	Store_Buy.visible = false
	Store_Sell.visible = false


#func _on_weapon_up_texture_button_mouse_entered() -> void:
	#weaponup_panel.visible = true
#
#
#func _on_weapon_up_texture_button_mouse_exited() -> void:
	#weaponup_panel.visible = false
