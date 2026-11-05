extends CheckButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toggled(toggled_on: bool) -> void:
	var state
	if toggled_on:
		state = "checked"
	else:
		state = "unchecked"
	var animation = get_theme_icon(state)
	
	if animation:
		animation.current_frame = 0
		animation.pause = false
