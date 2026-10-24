extends Camera3D

@onready var Player = $".."
@onready var fps = $CanvasLayer/FPS
@onready var Collision_Shape = $"../CollisionShape3D"


var sensitivity = 0.2
var crouching: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("crouch") and not crouching:
		Collision_Shape.shape.size = Vector3(0.5, 1.4, 0.5)
		self.position.y -= 0.4
		crouching = true
	
	elif Input.is_action_just_released("crouch") and crouching:
		Collision_Shape.shape.size = Vector3(0.5, 1.8, 0.5)
		self.position.y += 0.4
		crouching = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event.is_action_pressed("ui_accept"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Player.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
