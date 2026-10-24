extends CanvasLayer

@onready var pause_menu = $"Pause Menu"

var paused: bool = false
var options_menu: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pause_menu.visible = false
	

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
	if paused:
		pause_menu.visible = false
		OptionsMenu.visible = true
		options_menu = true
