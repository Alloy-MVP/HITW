extends CanvasLayer

@onready var pause_menu = $"Pause Menu"
@onready var OptionsMenu

var paused: bool = false
var options_menu: bool = false
var options_scene: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pause_menu.visible = false
	options_scene = preload("res://options_menu.tscn").instantiate()
	get_tree().root.add_child(options_scene)
	options_scene.visible = false
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if options_menu:
			back()
		else:
			pause()

func pause():
	paused = not paused
	if paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu.visible = true
		get_tree().paused = true

	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pause_menu.visible = false
		get_tree().paused = false
		options_menu = false
	
func back():
	OptionsMenu.visible = false
	pause_menu.visible = true
	options_menu = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_pressed() -> void:
	pause()


func _on_options_pressed() -> void:
	OptionsMenu = get_tree().get_first_node_in_group("Options")
	print(OptionsMenu)
	if paused:
		pause_menu.visible = false
		OptionsMenu.visible = true
		options_menu = true
