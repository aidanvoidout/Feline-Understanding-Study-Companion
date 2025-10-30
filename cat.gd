extends Node2D

@onready var sprite = $Control/MarginContainer/AnimatedSprite2D
@onready var timer = $Timer

var pet_state: int = STATE.IDLE

signal walking
signal finished_walking

enum STATE { IDLE, WALK, SLEEP, PLAY }

var CatMenuScene = preload("res://cat_menu.tscn")

func _ready():
	pet_state = STATE.IDLE
	sprite.play("default")
	timer.start()

func _on_timer_timeout():
	if pet_state == STATE.WALK:
		finished_walking.emit()

	await change_state()

	match pet_state:
		STATE.IDLE:
			timer.set_wait_time(randi_range(20, 100))
			sprite.play("default")
		STATE.WALK:
			timer.set_wait_time(randi_range(5, 20))
			sprite.play("walk")
		STATE.SLEEP:
			timer.set_wait_time(randi_range(20, 100))
			sprite.play("sleep")
		STATE.PLAY:
			timer.set_wait_time(randi_range(10, 15))
			sprite.play("play")

	timer.start()

func change_state():
	pet_state = randi_range(0, 3)
	if pet_state == STATE.WALK:
		walking.emit()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if pet_state == STATE.WALK:
			finished_walking.emit()
		sprite.play("default")
		open_menu()

func open_menu():
	for child in get_parent().get_parent().get_parent().get_children():
		if child is CatMenu or child is SettingsMenu:
			return
	
	var menu_scene = CatMenuScene.instantiate()
	get_parent().get_parent().get_parent().add_child(menu_scene)
	menu_scene.name = "CatMenu"
	var main_win_pos = get_window().position
	menu_scene.position = main_win_pos + Vector2i(50, -50)
