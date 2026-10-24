extends CharacterBody3D

@onready var Player_Camera = $Player_Camera

var speed = 3
var accelleration: float
var jump_velocity = 6.26
var sprinting: bool = false
var friction = 20
@onready var crouching: bool = Player_Camera.crouching



func _input(event: InputEvent) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity = velocity * 0.98
		accelleration = 6
		friction = 6
	else:
		accelleration = 20
		friction = 15

	if Input.is_action_just_pressed("sprint"):
		sprinting = not sprinting
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	if sprinting:
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
