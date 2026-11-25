extends Control

var player_id = "simul_player_test01"

#텍스트
@onready var up_hp_text = $Stat_Up_Container/HP_Container/UP_HP_Text
@onready var up_eng_text = $Stat_Up_Container/Energy_Container/UP_Energy_Text
@onready var up_def_text = $Stat_Up_Container/Defense_Container/UP_Defense_Text
@onready var up_sp_text = $Stat_Up_Container/Stamina_Container/UP_Stamina_Text
@onready var up_wgt_text = $Stat_Up_Container/Weight_Container/UP_Weight_Text
@onready var up_atk_text = $Stat_Up_Container/Attack_Container/UP_Attack_Text
@onready var up_absb_text = $Stat_Up_Container/Absorb_Container/UP_Absorb_Text
@onready var up_adp_text = $Stat_Up_Container/Adapt_Container/UP_Adapt_Text
@onready var up_luk_text = $Stat_Up_Container/Luck_Container/UP_Luck_Text
@onready var change_hp_text = $Change_Text/UP_HP_Text
@onready var change_eng_text = $Change_Text/UP_Energy_Text
@onready var change_def_text = $Change_Text/UP_Defense_Text
@onready var change_sp_text = $Change_Text/UP_Stamina_Text
@onready var change_speed_text = $Change_Text/UP_Speed_Text
@onready var change_wgt_text = $Change_Text/UP_Weight_Text
@onready var change_atk_text = $Change_Text/UP_Attack_Text
@onready var change_absb_text = $Change_Text/UP_Absorb_Text
@onready var change_adp_text = $Change_Text/UP_Adapt_Text
@onready var change_luk_text = $Change_Text/UP_Luck_Text
@onready var change_watk1_text = $Change_Text/UP_WAttack1_Text
@onready var change_watk2_text = $Change_Text/UP_WAttack2_Text
@onready var change_watk3_text = $Change_Text/UP_WAttack3_Text
@onready var change_watk4_text = $Change_Text/UP_WAttack4_Text
@onready var change_watk5_text = $Change_Text/UP_WAttack5_Text
@onready var change_reduce_text = $Change_Text/UP_Reduce_Text
@onready var change_reroll_text = $Change_Text/UP_Reroll_Text

#재화
@onready var coin_after = $Coin_After
@onready var coin_need = $Coin_Level_Container/Coin_Container/Coin_Need

@onready var level = $Coin_Level_Container/Level_Container/Level

#버튼
@onready var playerapply_normal = $PlayerApplyButton/PlayerApply_Normal
@onready var playerapply_over = $PlayerApplyButton/PlayerApply_Over
@onready var playerapply_text = $PlayerApplyButton/PlayerApply_Text

@onready var playerreset_normal = $PlayerResetButton/PlayerReset_Normal
@onready var playerreset_over = $PlayerResetButton/PlayerReset_Over
@onready var playerreset_text = $PlayerResetButton/PlayerReset_Text

#현재 능력치
@onready var hp_before = $Change_Before/UP_HP_Before
@onready var eng_before = $Change_Before/UP_Energy_Before
@onready var def_before = $Change_Before/UP_Defense_Before
@onready var sp_before = $Change_Before/UP_Stamina_Before
@onready var speed_before = $Change_Before/UP_Speed_Before
@onready var wgt_before = $Change_Before/UP_Weight_Before
@onready var atk_before = $Change_Before/UP_Attack_Before
@onready var absb_before = $Change_Before/UP_Absorb_Before
@onready var adp_before = $Change_Before/UP_Adapt_Before
@onready var luk_before = $Change_Before/UP_Luck_Before
@onready var reroll_before = $Change_Before/UP_Reroll_Before
@onready var wattack1_before = $Change_Before/UP_WAttack1_Before
@onready var wattack2_before = $Change_Before/UP_WAttack2_Before
@onready var wattack3_before = $Change_Before/UP_WAttack3_Before
@onready var wattack4_before = $Change_Before/UP_WAttack4_Before
@onready var wattack5_before = $Change_Before/UP_WAttack5_Before

#예상 능력치
@onready var hp_after = $Change_After/UP_HP_After
@onready var eng_after = $Change_After/UP_Energy_After
@onready var def_after = $Change_After/UP_Defense_After
@onready var sp_after = $Change_After/UP_Stamina_After
@onready var speed_after = $Change_After/UP_Speed_After
@onready var wgt_after = $Change_After/UP_Weight_After
@onready var atk_after = $Change_After/UP_Attack_After
@onready var absb_after = $Change_After/UP_Absorb_After
@onready var adp_after = $Change_After/UP_Adapt_After
@onready var luk_after = $Change_After/UP_Luck_After
@onready var reroll_after = $Change_After/UP_Reroll_After
@onready var wattack1_after = $Change_After/UP_WAttack1_After
@onready var wattack2_after = $Change_After/UP_WAttack2_After
@onready var wattack3_after = $Change_After/UP_WAttack3_After
@onready var wattack4_after = $Change_After/UP_WAttack4_After
@onready var wattack5_after = $Change_After/UP_WAttack5_After

#포인트 텍스트
@onready var point_hp_text = $Stat_Up_Container/HP_Container/Pont_Container/HP_Text
@onready var point_eng_text = $Stat_Up_Container/Energy_Container/Pont_Container/Energy_Text
@onready var point_def_text = $Stat_Up_Container/Defense_Container/Pont_Container/Defense_Text
@onready var point_sp_text = $Stat_Up_Container/Stamina_Container/Pont_Container/Stamina_Text
@onready var point_wgt_text = $Stat_Up_Container/Weight_Container/Pont_Container/Weight_Text
@onready var point_atk_text = $Stat_Up_Container/Attack_Container/Pont_Container/Attack_Text
@onready var point_absb_text = $Stat_Up_Container/Absorb_Container/Pont_Container/Absorb_Text
@onready var point_adp_text = $Stat_Up_Container/Adapt_Container/Pont_Container/Adapt_Text
@onready var point_luk_text = $Stat_Up_Container/Luck_Container/Pont_Container/Luck_Text

#포인트 버튼
@onready var hp_up_button = $Stat_Up_Container/HP_Container/Pont_Container/HPUpButton
@onready var eng_up_button = $Stat_Up_Container/Energy_Container/Pont_Container/EnergyUpButton
@onready var def_up_button = $Stat_Up_Container/Defense_Container/Pont_Container/DefenseUpButton
@onready var sp_up_button = $Stat_Up_Container/Stamina_Container/Pont_Container/StaminaUpButton
@onready var wgt_up_button = $Stat_Up_Container/Weight_Container/Pont_Container/WeightUpButton
@onready var atk_up_button = $Stat_Up_Container/Attack_Container/Pont_Container/AttackUpButton
@onready var absb_up_button = $Stat_Up_Container/Absorb_Container/Pont_Container/AbsorbUpButton
@onready var adp_up_button = $Stat_Up_Container/Adapt_Container/Pont_Container/AdaptUpButton
@onready var luk_up_button = $Stat_Up_Container/Luck_Container/Pont_Container/LuckUpButton

@onready var hp_down_button = $Stat_Up_Container/HP_Container/Pont_Container/HPDownButton
@onready var eng_down_button = $Stat_Up_Container/Energy_Container/Pont_Container/EnergyDownButton
@onready var def_down_button = $Stat_Up_Container/Defense_Container/Pont_Container/DefenseDownButton
@onready var sp_down_button = $Stat_Up_Container/Stamina_Container/Pont_Container/StaminaDownButton
@onready var wgt_down_button = $Stat_Up_Container/Weight_Container/Pont_Container/WeightDownButton
@onready var atk_down_button = $Stat_Up_Container/Attack_Container/Pont_Container/AttackDownButton
@onready var absb_down_button = $Stat_Up_Container/Absorb_Container/Pont_Container/AbsorbDownButton
@onready var adp_down_button = $Stat_Up_Container/Adapt_Container/Pont_Container/AdaptDownButton
@onready var luk_down_button = $Stat_Up_Container/Luck_Container/Pont_Container/LuckDownButton

#초기화
@onready var reset_text = $Reset

#기초스탯
var origin_stat: Dictionary

#포인트 부여
var up_hp = 0
var up_eng = 0
var up_def = 0
var up_sp = 0
var up_wgt = 0
var up_atk = 0
var up_absb = 0
var up_adp = 0
var up_luk = 0

var up_hp_min = 0
var up_eng_min = 0
var up_def_min = 0
var up_sp_min = 0
var up_wgt_min = 0
var up_atk_min = 0
var up_absb_min = 0
var up_adp_min = 0
var up_luk_min = 0

var start = false
var pointed = 0
var current_point = 0

var after_coin = 1000
var need_coin = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_initial()

func _set_initial():
	_set_pointed(true)
	_set_stat()
	_set_after_stat()
	_get_need_coin()
	#_set_language()

func _process(delta: float) -> void:
	if after_coin < need_coin:
		hp_up_button.disabled = true
		eng_up_button.disabled = true
		def_up_button.disabled = true
		sp_up_button.disabled = true
		wgt_up_button.disabled = true
		atk_up_button.disabled = true
		absb_up_button.disabled = true
		adp_up_button.disabled = true
		luk_up_button.disabled = true
	else:
		hp_up_button.disabled = false
		eng_up_button.disabled = false
		def_up_button.disabled = false
		sp_up_button.disabled = false
		wgt_up_button.disabled = false
		atk_up_button.disabled = false
		absb_up_button.disabled = false
		adp_up_button.disabled = false
		luk_up_button.disabled = false

	if up_hp > up_hp_min:
		hp_down_button.disabled = false
	else:
		hp_down_button.disabled = true
	if up_eng > up_eng_min:
		eng_down_button.disabled = false
	else:
		eng_down_button.disabled = true
	if up_def > up_def_min:
		def_down_button.disabled = false
	else:
		def_down_button.disabled = true
	if up_sp > up_sp_min:
		sp_down_button.disabled = false
	else:
		sp_down_button.disabled = true
	if up_wgt > up_wgt_min:
		wgt_down_button.disabled = false
	else:
		wgt_down_button.disabled = true
	if up_atk > up_atk_min:
		atk_down_button.disabled = false
	else:
		atk_down_button.disabled = true
	if up_absb > up_absb_min:
		absb_down_button.disabled = false
	else:
		absb_down_button.disabled = true
	if up_adp > up_adp_min:
		adp_down_button.disabled = false
	else:
		adp_down_button.disabled = true
	if up_luk > up_luk_min:
		luk_down_button.disabled = false
	else:
		luk_down_button.disabled = true

#언어 세팅
func _set_language():
	var lang_stat = LangData.stat.get(LangData.language)
	
	up_hp_text.text = lang_stat.get("hp")
	up_eng_text.text = lang_stat.get("eng")
	up_def_text.text = lang_stat.get("def")
	up_sp_text.text = lang_stat.get("sp")
	up_wgt_text.text = lang_stat.get("wgt")
	up_atk_text.text = lang_stat.get("atk")
	up_absb_text.text = lang_stat.get("absb")
	up_adp_text.text = lang_stat.get("adp")
	up_luk_text.text = lang_stat.get("luk")
	change_hp_text.text = lang_stat.get("hp")
	change_eng_text.text = lang_stat.get("eng")
	change_def_text.text = lang_stat.get("def")
	change_sp_text.text = lang_stat.get("sp")
	change_speed_text.text = lang_stat.get("speed")
	change_wgt_text.text = lang_stat.get("wgt")
	change_atk_text.text = lang_stat.get("atk")
	change_absb_text.text = lang_stat.get("absb")
	change_adp_text.text = lang_stat.get("adp")
	change_luk_text.text = lang_stat.get("luk")
	change_watk1_text.text = lang_stat.get("watk") + "1"
	change_watk2_text.text = lang_stat.get("watk") + "2"
	change_watk3_text.text = lang_stat.get("watk") + "3"
	change_watk4_text.text = lang_stat.get("watk") + "4"
	change_watk5_text.text = lang_stat.get("watk") + "5"
	change_reduce_text.text = lang_stat.get("reduce")
	change_reroll_text.text = lang_stat.get("reroll")

func _set_font(node: Node, font: Font):
	for child in node.get_children():
		if child is Label:
			child.add_theme_font_override("font", font)

		_set_font(child, font)

#포인트 세팅
func _set_pointed(first):
	if first:
		up_hp = int(Game.player.stat.stat_up["hp"])
		up_eng = int(Game.player.stat.stat_up["eng"])
		up_def = int(Game.player.stat.stat_up["def"])
		up_sp = int(Game.player.stat.stat_up["sp"])
		up_wgt = int(Game.player.stat.stat_up["wgt"])
		up_atk = int(Game.player.stat.stat_up["atk"])
		up_absb = int(Game.player.stat.stat_up["absb"])
		up_adp = int(Game.player.stat.stat_up["adp"])
		up_luk = int(Game.player.stat.stat_up["luk"])
		
		up_hp_min = int(Game.player.stat.stat_up["hp"])
		up_eng_min = int(Game.player.stat.stat_up["eng"])
		up_def_min = int(Game.player.stat.stat_up["def"])
		up_sp_min = int(Game.player.stat.stat_up["sp"])
		up_wgt_min = int(Game.player.stat.stat_up["wgt"])
		up_atk_min = int(Game.player.stat.stat_up["atk"])
		up_absb_min = int(Game.player.stat.stat_up["absb"])
		up_adp_min = int(Game.player.stat.stat_up["adp"])
		up_luk_min = int(Game.player.stat.stat_up["luk"])
		
		pointed = up_hp + up_eng + up_def + up_sp + up_wgt + up_atk + up_absb + up_adp + up_luk
	
	point_hp_text.text = str(up_hp)
	point_eng_text.text = str(up_eng)
	point_def_text.text = str(up_def)
	point_sp_text.text = str(up_sp)
	point_wgt_text.text = str(up_wgt)
	point_atk_text.text = str(up_atk)
	point_absb_text.text = str(up_absb)
	point_adp_text.text = str(up_adp)
	point_luk_text.text = str(up_luk)
	
	if up_hp == up_hp_min:
		point_hp_text.add_theme_color_override("font_color", Color.WHITE)
	if up_eng == up_eng_min:
		point_eng_text.add_theme_color_override("font_color", Color.WHITE)
	if up_def == up_def_min:
		point_def_text.add_theme_color_override("font_color", Color.WHITE)
	if up_sp == up_sp_min:
		point_sp_text.add_theme_color_override("font_color", Color.WHITE)
	if up_wgt == up_wgt_min:
		point_wgt_text.add_theme_color_override("font_color", Color.WHITE)
	if up_atk == up_atk_min:
		point_atk_text.add_theme_color_override("font_color", Color.WHITE)
	if up_absb == up_absb_min:
		point_absb_text.add_theme_color_override("font_color", Color.WHITE)
	if up_adp == up_adp_min:
		point_adp_text.add_theme_color_override("font_color", Color.WHITE)
	if up_luk == up_luk_min:
		point_luk_text.add_theme_color_override("font_color", Color.WHITE)
		
	_set_level()
	

func _set_stat():
	origin_stat = Game.player.stat._set_final_all_stat()
	hp_before.text = str(origin_stat["hp"])
	eng_before.text = str(origin_stat["eng"])
	def_before.text = str(origin_stat["def"])
	sp_before.text = str(origin_stat["sp"])
	speed_before.text = str(origin_stat["ms"])
	wgt_before.text = str(origin_stat["wgt"])
	atk_before.text = str(origin_stat["atk"])
	absb_before.text = str(origin_stat["absb"])
	adp_before.text = str(origin_stat["adp"])
	luk_before.text = str(origin_stat["luk"])
	#var weapon_resource
	#if FrontGlobal.equip_weapon_id[0] == null:
		#wattack1_before.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[0])["resource"]["attack"]
		#wattack1_before.text = str(Api.combat.attack_formula_damage(float(FrontGlobal.player_stats.get(&"physical_attack", 0.0)), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		#
	#if FrontGlobal.equip_weapon_id[1] == null:
		#wattack2_before.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[1])["resource"]["attack"]
		#wattack2_before.text = str(Api.combat.attack_formula_damage(float(FrontGlobal.player_stats.get(&"physical_attack", 0.0)), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		#
	#if FrontGlobal.equip_weapon_id[2] == null:
		#wattack3_before.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[2])["resource"]["attack"]
		#wattack3_before.text = str(Api.combat.attack_formula_damage(float(FrontGlobal.player_stats.get(&"physical_attack", 0.0)), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		#
	#if FrontGlobal.equip_weapon_id[3] == null:
		#wattack4_before.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[3])["resource"]["attack"]
		#wattack4_before.text = str(Api.combat.attack_formula_damage(float(FrontGlobal.player_stats.get(&"physical_attack", 0.0)), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		#
	#if FrontGlobal.equip_weapon_id[4] == null:
		#wattack5_before.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[4])["resource"]["attack"]
		#wattack5_before.text = str(Api.combat.attack_formula_damage(float(FrontGlobal.player_stats.get(&"physical_attack", 0.0)), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		
	reroll_before.text = str(origin_stat["reroll"])
	

func _set_after_stat() -> void:
	var eng_calc = 0
	hp_after.text = str(Game.player.stat._set_final_one_stat("hp", up_hp - up_hp_min))
	eng_after.text = str(Game.player.stat._set_final_one_stat("eng", up_eng - up_eng_min))
	def_after.text = str(Game.player.stat._set_final_one_stat("def", up_def - up_def_min))
	sp_after.text = str(Game.player.stat._set_final_one_stat("sp", up_sp - up_sp_min))
	speed_after.text = str(Game.player.stat._set_final_one_stat("ms", up_sp - up_sp_min))
	wgt_after.text = str(Game.player.stat._set_final_one_stat("wgt", up_wgt - up_wgt_min))
	atk_after.text = str(Game.player.stat._set_final_one_stat("atk", up_atk - up_atk_min))
	absb_after.text = str(Game.player.stat._set_final_one_stat("absb", up_absb - up_absb_min))
	adp_after.text = str(Game.player.stat._set_final_one_stat("adp", up_adp - up_adp_min))
	luk_after.text = str(Game.player.stat._set_final_one_stat("luk", up_luk - up_luk_min))
	#var weapon_resource
	#var atk_value = float(FrontGlobal.player_stats.get(&"physical_attack", 0.0)) + ((up_atk - up_atk_min) * float(FrontGlobal.growth_stats.get(&"physical_attack", 0.0)))
	#if FrontGlobal.equip_weapon_id[0] == null:
		#wattack1_after.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[0])["resource"]["attack"]
		#wattack1_after.text = str(Api.combat.attack_formula_damage(float(atk_value), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		#
	#if FrontGlobal.equip_weapon_id[1] == null:
		#wattack2_after.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[1])["resource"]["attack"]
		#wattack2_after.text = str(Api.combat.attack_formula_damage(float(atk_value), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		#
	#if FrontGlobal.equip_weapon_id[2] == null:
		#wattack3_after.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[2])["resource"]["attack"]
		#wattack3_after.text = str(Api.combat.attack_formula_damage(float(atk_value), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		#
	#if FrontGlobal.equip_weapon_id[3] == null:
		#wattack4_after.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[3])["resource"]["attack"]
		#wattack4_after.text = str(Api.combat.attack_formula_damage(float(atk_value), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
		#
	#if FrontGlobal.equip_weapon_id[4] == null:
		#wattack5_after.text = str(0)
	#else:
		#weapon_resource = Api.weapon.get_weapon_resource(FrontGlobal.equip_weapon_id[4])["resource"]["attack"]
		#wattack5_after.text = str(Api.combat.attack_formula_damage(float(atk_value), weapon_resource["weapon_attack"], weapon_resource["grade_percent"], 1.0, 0.0))
	#var plus_reroll = int((up_luk - up_luk_min) / 5)
	reroll_after.text = str(Game.player.stat._set_final_one_stat("reroll", up_luk - up_luk_min))
	
	if hp_after.text != hp_before.text:
		hp_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		hp_after.add_theme_color_override("font_color", Color.WHITE)
	if eng_after.text != eng_before.text:
		eng_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		eng_after.add_theme_color_override("font_color", Color.WHITE)
	if def_after.text != def_before.text:
		def_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		def_after.add_theme_color_override("font_color", Color.WHITE)
	if sp_after.text != sp_before.text:
		sp_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		sp_after.add_theme_color_override("font_color", Color.WHITE)
	if sp_after.text != sp_before.text:
		speed_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		speed_after.add_theme_color_override("font_color", Color.WHITE)
	if wgt_after.text != wgt_before.text:
		wgt_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		wgt_after.add_theme_color_override("font_color", Color.WHITE)
	if atk_after.text != atk_before.text:
		atk_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		atk_after.add_theme_color_override("font_color", Color.WHITE)
	if absb_after.text != absb_before.text:
		absb_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		absb_after.add_theme_color_override("font_color", Color.WHITE)
	if adp_after.text != adp_before.text:
		adp_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		adp_after.add_theme_color_override("font_color", Color.WHITE)
	if luk_after.text != luk_before.text:
		luk_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		luk_after.add_theme_color_override("font_color", Color.WHITE)
	if wattack1_after.text != wattack1_before.text:
		wattack1_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		wattack1_after.add_theme_color_override("font_color", Color.WHITE)
	if wattack2_after.text != wattack2_before.text:
		wattack2_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		wattack2_after.add_theme_color_override("font_color", Color.WHITE)
	if wattack3_after.text != wattack3_before.text:
		wattack3_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		wattack3_after.add_theme_color_override("font_color", Color.WHITE)
	if wattack4_after.text != wattack4_before.text:
		wattack4_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		wattack4_after.add_theme_color_override("font_color", Color.WHITE)
	if wattack5_after.text != wattack5_before.text:
		wattack5_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		wattack5_after.add_theme_color_override("font_color", Color.WHITE)
	if reroll_after.text != reroll_before.text:
		reroll_after.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		reroll_after.add_theme_color_override("font_color", Color.WHITE)
	
	

func _set_level():
	Game.player._set_level()
	level.text = str(Game.player.level + current_point)
	if current_point > 0:
		level.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		level.add_theme_color_override("font_color", Color.WHITE)

#버튼
func _on_player_apply_button_mouse_entered() -> void:
	playerapply_normal.visible = false
	playerapply_over.visible = true
	playerapply_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))


func _on_player_apply_button_mouse_exited() -> void:
	playerapply_normal.visible = true
	playerapply_over.visible = false
	playerapply_text.add_theme_color_override("font_color", Color.WHITE)


func _on_player_apply_button_pressed() -> void:
	_apply_stat()


func _on_player_reset_button_mouse_entered() -> void:
	playerreset_normal.visible = false
	playerreset_over.visible = true
	playerreset_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))


func _on_player_reset_button_mouse_exited() -> void:
	playerreset_normal.visible = true
	playerreset_over.visible = false
	playerreset_text.add_theme_color_override("font_color", Color.WHITE)


func _on_player_reset_button_pressed() -> void:
	current_point = 0
	_set_pointed(true)
	_set_stat()
	_set_after_stat()
	_get_need_coin()
	
func _apply_stat():
	var data = {
		"hp": up_hp - up_hp_min,
		"eng": up_eng - up_eng_min,
		"def": up_def - up_def_min,
		"sp": up_sp - up_sp_min,
		"wgt": up_wgt - up_wgt_min,
		"atk": up_atk - up_atk_min,
		"absb": up_absb - up_absb_min,
		"adp": up_adp - up_adp_min,
		"luk": up_luk - up_luk_min
	}
	
	Game.player._apply_player_upgrade(data, current_point)
	
	current_point = 0
	_set_pointed(true)
	_set_stat()
	_set_after_stat()
	#get_parent().get_parent().get_parent()._get_coin()
	_get_need_coin()

func _get_need_coin():
	var cost = 0
	if current_point > 0:
		for i in current_point:
			cost += Game.player.currency._player_upgrade_cost(false, Game.player.level + i)
	
	after_coin = Game.player.soulstone - cost
	need_coin = Game.player.currency._player_upgrade_cost(false, Game.player.level + current_point)
	
	coin_after.text = str(after_coin)
	coin_need.text = str(need_coin)


func _on_hp_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_hp += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		
		point_hp_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass


func _on_hp_down_button_pressed() -> void:
	if up_hp > up_hp_min:
		up_hp -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
	else:
		pass


func _on_energy_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_eng += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		point_eng_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass

func _on_energy_down_button_pressed() -> void:
	if up_eng > up_eng_min:
		up_eng -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
	else:
		pass


func _on_defense_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_def += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		point_def_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass


func _on_defense_down_button_pressed() -> void:
	if up_def > up_def_min:
		up_def -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
	else:
		pass


func _on_stamina_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_sp += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		point_sp_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass


func _on_stamina_down_button_pressed() -> void:
	if up_sp > up_sp_min:
		up_sp -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
	else:
		pass


func _on_weight_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_wgt += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		point_wgt_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass


func _on_weight_down_button_pressed() -> void:
	if up_wgt > up_wgt_min:
		up_wgt -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
	else:
		pass


func _on_attack_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_atk += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		point_atk_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass


func _on_attack_down_button_pressed() -> void:
	if up_atk > up_atk_min:
		up_atk -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
	else:
		pass


func _on_absorb_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_absb += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		point_absb_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass


func _on_absorb_down_button_pressed() -> void:
	if up_absb > up_absb_min:
		up_absb -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
	else:
		pass


func _on_adapt_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_adp += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		point_adp_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass


func _on_adapt_down_button_pressed() -> void:
	if up_adp > up_adp_min:
		up_adp -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
	else:
		pass


func _on_luck_up_button_pressed() -> void:
	if after_coin > need_coin:
		up_luk += 1
		current_point += 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()
		point_luk_text.add_theme_color_override("font_color", Color(0.549, 0.451, 0.294))
	else:
		pass


func _on_luck_down_button_pressed() -> void:
	if up_luk > up_luk_min:
		up_luk -= 1
		current_point -= 1
	
		_set_pointed(false)
		_set_after_stat()
		_get_need_coin()


func _on_button_pressed() -> void:
	reset_text.visible = true
	


func _on_reset_yes_pressed() -> void:
	Game.player._reset_player_upgrade()
	current_point = 0
	_set_pointed(true)
	_set_stat()
	_set_after_stat()
	#get_parent().get_parent().get_parent()._get_coin()
	_get_need_coin()
	reset_text.visible = false


func _on_reset_no_pressed() -> void:
	reset_text.visible = false
