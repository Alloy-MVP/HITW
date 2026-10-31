extends Control

var options_scene = preload("res://options_menu.tscn")
var new_options_scene
var in_options_menu: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if in_options_menu:
			back()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")
	if new_options_scene and is_instance_valid(new_options_scene):
		new_options_scene.queue_free()

func _on_options_pressed() -> void:
	options()

func _on_quit_pressed() -> void:
	get_tree().quit()

func back():
	if new_options_scene and is_instance_valid(new_options_scene): #stops it possibly deleting itself twice
		new_options_scene.queue_free()
	new_options_scene = null
	
	self.visible = true
	in_options_menu = false

func options():
	new_options_scene = options_scene.instantiate()
	get_tree().root.add_child(new_options_scene)
	
	self.visible = false
	in_options_menu = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
