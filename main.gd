extends Node2D

@onready var _MainWindow: Window = get_window()
@onready var char_sprite: AnimatedSprite2D = $CanvasLayer/VBoxContainer/Cat/Control/MarginContainer/AnimatedSprite2D
@onready var char_polygon: CollisionPolygon2D = $CanvasLayer/VBoxContainer/Cat/Control/MarginContainer/AnimatedSprite2D/Area2D/CollisionPolygon2D
@onready var checkin_timer: Timer = $Checkin_Timer

var player_size = Vector2i(200, 200)
var CatMenuScene = preload("res://cat_menu.tscn")
var mouse_offset: Vector2i = Vector2i.ZERO
var dragging: bool = false
var selected: bool = false
var taskbar_pos: int = (DisplayServer.screen_get_usable_rect().end.y - player_size.y)
var screen_width: int = DisplayServer.screen_get_usable_rect().size.x
var screen_height: int = DisplayServer.screen_get_usable_rect().size.y
var is_walking: bool = false
var walk_direction: int = 1

var checkin_delay = 69 # randi_range(20*60, 30*60)

const WALK_SPEED = 150
const CHECK_IN = preload("uid://coy2pcijngo1o")

func _ready():
	_MainWindow.min_size = player_size
	_MainWindow.size = _MainWindow.min_size
	_MainWindow.position = Vector2(DisplayServer.screen_get_size().x / 2 - (player_size.x / 2), taskbar_pos)
	_MainWindow.always_on_top = true
	_MainWindow.grab_focus()
	$CanvasLayer/VBoxContainer/Cat.connect("walking", _on_character_walking)
	$CanvasLayer/VBoxContainer/Cat.connect("finished_walking", _on_character_finished_walking)
	checkin_timer.wait_time = checkin_delay
	checkin_timer.start()
	
func _process(delta):
	if dragging:
		drag_window()
	if is_walking:
		walk(delta)


func _input(event):
	if event.is_action_pressed("lmb"):
		dragging = true
		mouse_offset = event.position
	elif event.is_action_released("lmb"):
		dragging = false

func drag_window():
	var global_mouse = DisplayServer.mouse_get_position()
	_MainWindow.position = Vector2(global_mouse - mouse_offset)

func clamp_on_screen_width(pos, player_width):
	return clampi(pos, 0, screen_width - player_width)

func walk(delta):

	_MainWindow.position.x = _MainWindow.position.x + WALK_SPEED * delta * walk_direction

	_MainWindow.position.x = clampi(_MainWindow.position.x, 0
			, clamp_on_screen_width(_MainWindow.position.x, player_size.x))

	if ((_MainWindow.position.x == (screen_width - player_size.x)) or (_MainWindow.position.x == 0)):
		walk_direction = walk_direction * -1
		char_sprite.flip_h = !char_sprite.flip_h

func choose_direction():
	if (randi_range(1, 2) == 1):
		walk_direction = 1
		char_sprite.flip_h = false
	else:
		walk_direction = -1
		char_sprite.flip_h = true

func _on_character_walking():
	is_walking = true
	choose_direction()

func _on_character_finished_walking():
	is_walking = false


func _on_checkin_timer_timeout() -> void:
	var main_win_pos = get_window().position
	var checkin_menu = CHECK_IN.instantiate()
	get_parent().add_child(checkin_menu)
	checkin_menu.position = main_win_pos + Vector2i(50, -50)
	checkin_timer.start()
