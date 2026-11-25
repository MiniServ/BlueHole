extends Node

var player = preload("res://AutoLoad/Player/player.gd").new()
var save = preload("res://AutoLoad/SaveLoad/savemanager.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save._load_all()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
