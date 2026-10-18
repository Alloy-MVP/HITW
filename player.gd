extends CharacterBody3D

@onready var Player_Camera = $Player_Camera

var SPEED = 3
var ACCELERATION: float
var JUMP_VELOCITY = 6.26
var sprinting: bool = false
var FRICTION = 20

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		ACCELERATION = 4
		FRICTION = 6
	else:
		ACCELERATION = 20
		FRICTION = 20

	if Input.is_action_just_pressed("sprint"):
		sprinting = not sprinting
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if sprinting:
		SPEED = 5
	else:
		SPEED = 3
	
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var vx = direction.x * SPEED
	var vz = direction.z * SPEED
	
	if direction:
		velocity.x = move_toward(velocity.x, vx, delta * ACCELERATION)
		velocity.z = move_toward(velocity.z, vz, delta * ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, delta * FRICTION)
		velocity.z = move_toward(velocity.z, 0, delta * FRICTION)

	move_and_slide()


	for i in get_slide_collision_count():
		var bounce = get_slide_collision(i)
		if bounce:
			var fake_raycast = bounce.get_collider()
			if fake_raycast and fake_raycast.is_in_group("Walls"):
				var wall_direction = bounce.get_normal()
				self.velocity = wall_direction * 7
				self.velocity.y = 3
