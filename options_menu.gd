extends Control

@onready var ui = $CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.visible = false
	self.visible = false

func Hide():
	ui.visible = false

func Show():
	ui.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	var pause_menu_exists = get_tree().get_first_node_in_group("Pause")
	if pause_menu_exists and pause_menu_exists.paused:
		get_tree().get_first_node_in_group("Pause").back()
	else:
		get_tree().get_first_node_in_group("Title Screen").back()
