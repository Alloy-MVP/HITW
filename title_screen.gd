extends Control

@onready var Play_Menu = $"Play Menu"
@onready var title_screen_elements = $"title screen elements"

var options_scene = preload("res://options_menu.tscn")
var new_options_scene
var in_options_menu: bool = false

var config = ConfigFile.new()
var config_path = "user://Config.cfg"
var master_config_path = "res://Config.cfg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	
	if not FileAccess.file_exists(config_path):
		DirAccess.copy_absolute(master_config_path, config_path)
	config.load(config_path)
	
	Play_Menu.visible = false
	title_screen_elements.visible = true

func menu_toggle():
	Play_Menu.visible = not Play_Menu.visible
	title_screen_elements.visible = not title_screen_elements.visible

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if in_options_menu:
			back()
		if not in_options_menu and Play_Menu.visible:
			menu_toggle()

func _on_play_pressed() -> void:
	menu_toggle()

func _on_options_pressed() -> void:
	options()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")
	if new_options_scene and is_instance_valid(new_options_scene):
		new_options_scene.queue_free()

func _on_back_play_pressed() -> void:
	menu_toggle()

func Levels():
	config.set_value("LEVEL OPTIONS", "infinite", false)
	config.set_value("LEVEL OPTIONS", "levels", true)

func Infinite():
	config.set_value("LEVEL OPTIONS", "infinite", true)
	config.set_value("LEVEL OPTIONS", "levels", false)

func _on_difficulty_item_selected(index: int) -> void:
	config.set_value("LEVEL OPTIONS", "difficulty", index)
	Infinite()
	if index == 0:
		print("Easy")
	elif index == 1:
		print("Medium")
	elif index == 2:
		print("Hard")
	elif index == 3:
		print("Impossible")



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
