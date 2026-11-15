extends AudioStreamPlayer

@onready var wind = preload("res://textures/windv1.wav")

var wind_sound: bool = false
var Player
var GUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wind_sound = false
	Player = $"../.."
	GUI = $"../CanvasLayer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Player and GUI:
		if not wind_sound:
			if Player.falling:
				wind_sound = true
				stream = wind
				self.volume_linear = 0.0
				play()
				
				var wind_fade_in = create_tween()
				wind_fade_in.set_ease(Tween.EASE_IN)
				wind_fade_in.tween_property(self, "volume_linear", 1.0, 2.0)
				
		if wind_sound and GUI.dead:
			await get_tree().create_timer(1.0, false).timeout
			stop()
			
		
		
