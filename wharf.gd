extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var Fragile = $Fragile
@onready var Solid = $Solid
@onready var Fragile_collision = $Fragile/CollisionShape3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fragile_collision.disabled = false
	
func Snap_Floor():
	print("snapped floor")
	animation_player.play("break")
	await get_tree().create_timer(0.9, false).timeout
	Fragile_collision.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
