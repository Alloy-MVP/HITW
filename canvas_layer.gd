extends CanvasLayer

@onready var pause_menu = $"Pause Menu"
@onready var player_camera = $".."
@onready var Main_Game = $"../../.."

var paused: bool = false
var options_scene = preload("res://options_menu.tscn")
var new_options_scene
var in_options_menu: bool = false
var dead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pause_menu.visible = false
	$"Black Fade".modulate.a = 0.0
	await get_tree().create_timer(2.0).timeout

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if new_options_scene:
			options_back()
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

func back():
	pause_menu.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_camera.global_position.y < -20 and not dead:
		print(player_camera.global_position.y)
		dead = true
		var fade_out = create_tween()
		fade_out.tween_property($"Black Fade", "modulate:a", 1.0, 1)
		if get_tree().paused:
			get_tree().paused = false
		await fade_out.finished
		get_tree().change_scene_to_file("res://death_screen.tscn")

func _on_resume_pressed() -> void:
	pause()


func _on_options_pressed() -> void:
	options()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://title_screen.tscn")

func options_back():
	if new_options_scene and is_instance_valid(new_options_scene): #stops it possibly deleting itself twice
		new_options_scene.queue_free()
	new_options_scene = null
	
	self.visible = true
	in_options_menu = false

func options():
	new_options_scene = options_scene.instantiate()
	new_options_scene.options_update.connect(player_camera.update)
	get_tree().root.add_child(new_options_scene)
	
	self.visible = false
	in_options_menu = true
