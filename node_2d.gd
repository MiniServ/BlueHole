extends Node2D

var dic: Dictionary
var inst = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#dic = Game.player._set_final_all_stat()
	#print(dic)
	inst = Game.player.currency._reset_player_upgrade_cost()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
