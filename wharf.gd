extends Node3D

@onready var fake_animation_player = $AnimationPlayer
@onready var animation_player = $RealAnimationPlayer
@onready var animation_library = preload("res://models/wharf_animation.res")

var all_animations: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in animation_library.get_animation_list():
		all_animations.append(i)
	print(all_animations)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		animation_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
