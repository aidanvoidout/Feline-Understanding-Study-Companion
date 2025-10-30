class_name SettingsMenu extends Window

@onready var alpha_slider: HSlider = $VBoxContainer/AlphaOption/AlphaSlider
@onready var movement_button: CheckButton = $VBoxContainer/MovementOption/MovementButton
@onready var smaller_button: CheckButton = $VBoxContainer/SmallerOption/SmallerButton
@onready var char_sprite: AnimatedSprite2D = $'../CanvasLayer/VBoxContainer/Cat/Control/MarginContainer/AnimatedSprite2D'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_requested() -> void:
	queue_free()
	
func _on_alpha_slider_value_changed(value: float) -> void:
	char_sprite.modulate.a = value
	
func _on_smaller_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		char_sprite.scale = 0.6 * Vector2(6.838, 6.838)
	else:
		char_sprite.scale = Vector2(6.838,6.838)
