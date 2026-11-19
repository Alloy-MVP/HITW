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
	Fragile_collision.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
