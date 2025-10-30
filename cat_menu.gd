class_name CatMenu extends Window

@onready var timer_button: Button = $HBoxContainer/TimerButton
@onready var notepad_button: Button = $HBoxContainer/NotepadButton
@onready var settings_button: Button = $HBoxContainer/SettingsButton
@onready var quit_button: Button = $HBoxContainer/QuitButton

const SETTINGS_MENU = preload("uid://cdfa60da6u4va")
const NOTEPAD_MENU = preload("uid://d0hq8g0sdxsgp")
const TIMER_MENU = preload("uid://wxn3ut7dsfck")

func _on_timer_button_pressed() -> void:
	var main_win_pos = get_window().position
	var has_timer = false
	var timer
	for child in get_parent().get_children():
		if child is TimerMenu:
			has_timer = true
			timer = child
	if not has_timer:
		var timer_menu = TIMER_MENU.instantiate()
		get_parent().add_child(timer_menu)
		timer_menu.position = main_win_pos + Vector2i(50, -50)
	else:
		timer.visible = true
		timer.position = main_win_pos + Vector2i(50, -50)
	queue_free()

func _on_notepad_button_pressed() -> void:
	var has_notepad = false
	var notepad
	var main_win_pos = get_window().position

	for child in get_parent().get_children():
		if child is NotepadMenu:
			has_notepad = true
			notepad = child
	if not has_notepad:
		var notepad_menu = NOTEPAD_MENU.instantiate()
		get_parent().add_child(notepad_menu)
		notepad_menu.position = main_win_pos + Vector2i(50, -50)
	else:
		notepad.visible = true
		notepad.position = main_win_pos + Vector2i(50, -50)
	queue_free()


func _on_settings_button_pressed() -> void:
	var main_win_pos = get_window().position
	var settings_menu = SETTINGS_MENU.instantiate()
	get_parent().add_child(settings_menu)
	settings_menu.position = main_win_pos + Vector2i(50, -50)

	queue_free()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_close_requested() -> void:
	queue_free()
