extends CharacterBody3D

@onready var Player_Camera = $Player_Camera
@onready var crouching: bool = Player_Camera.crouching
@onready var Main_Game = $".."
@onready var Nausea = $Player_Camera/CanvasLayer/Nausea

var speed = 3
var accelleration: float
var jump_velocity = 7.26
var sprinting: bool = true
var friction = 20
var sliding: bool = false
var fly: bool = false
var falling: bool = false
var random_roll_direction

func _ready() -> void:
	Player_Camera.mouse_disabled = false
	Nausea.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		fly = not fly

func _physics_process(delta: float) -> void:
	crouching = Player_Camera.crouching
	sliding = Player_Camera.sliding
	
	if not is_on_floor() and not fly:
		velocity += get_gravity() * delta
		velocity = velocity * 0.98
		accelleration = 4
		friction = 6
		
	elif fly:
		speed = 20
		friction = 20
		accelleration = 20
	else:
		accelleration = 20
		friction = 15

	# Traps
	if Main_Game.ice:
		friction = 2
		accelleration = 5
	
	if Main_Game.nausea:
		Nausea.visible = true
	else:
		Nausea.visible = false

	if Input.is_action_just_pressed("sprint"):
		sprinting = not sprinting

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_pressed("slide"):
		sliding = true
	
	if sliding and is_on_floor():
		speed = 8
		
	elif sprinting and crouching:
		speed = 1
	elif crouching:
		speed = 1
	elif sprinting:
		speed = 4
	else:
		speed = 2.5
	
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var vx = direction.x * speed
	var vz = direction.z * speed
	
	if direction:
		velocity.x = move_toward(velocity.x, vx, delta * accelleration)
		velocity.z = move_toward(velocity.z, vz, delta * accelleration)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, delta * friction)
		velocity.z = move_toward(velocity.z, 0, delta * friction)

	move_and_slide()


	for i in get_slide_collision_count():
		var bounce = get_slide_collision(i)
		if bounce:
			var fake_raycast = bounce.get_collider()
			if fake_raycast and fake_raycast.is_in_group("Walls"):
				var wall_direction = bounce.get_normal()
				self.velocity = wall_direction * 7
				self.velocity.y = 3
	
	if self.global_position.y < 0 and not falling:
		falling = true
		print("♬Free Fallin♬")
		random_roll_direction = Vector3(randf_range(-10.0, 10.0),randf_range(-10.0, 10.0),randf_range(-10.0, 10.0))
		Player_Camera.mouse_disabled = true
		
		var camera_roll_tween = create_tween()
		camera_roll_tween.tween_property(Player_Camera, "rotation", Player_Camera.rotation + random_roll_direction, 3.5)
		


func _on_sea_body_entered(body: Node3D) -> void:
	print("Splash!!")
	pass # audio splash
