extends Control

var options_scene
var options_menu: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_options_scene = get_tree().get_first_node_in_group("Options")
	if current_options_scene:
		options_scene = current_options_scene
	else:
		options_scene = preload("res://options_menu.tscn").instantiate()
		options_scene.add_to_group("Options")
		get_tree().root.add_child.call_deferred(options_scene)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if options_menu:
			back()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_options_pressed() -> void:
	options()


func _on_quit_pressed() -> void:
	get_tree().quit()

func back():
	options_scene.Hide()
	self.visible = true
	options_menu = false

func options():
	options_scene.Show()
	self.visible = false
	options_menu = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
