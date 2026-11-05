extends Node2D

@onready var Black_Fade = $"CanvasLayer/Black Fade"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	var fade_in = create_tween()
	fade_in.tween_property(Black_Fade, "modulate:a", 0.0, 2)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_respawn_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_quit_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://title_screen.tscn")
