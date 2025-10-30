class_name TimerMenu extends Window

@onready var timer_lineedit: LineEdit = $VBoxContainer/HBoxContainer/Timer_Lineedit
@onready var timer_label: Label = $VBoxContainer/HBoxContainer/Timer_Label
@onready var timer_start: Button = $VBoxContainer/HBoxContainer2/Timer_Start
@onready var timer_stop: Button = $VBoxContainer/HBoxContainer2/Timer_Stop
@onready var mode_button: Button = $VBoxContainer/HBoxContainer3/Mode_Button
@onready var pomodoro_button: Button = $VBoxContainer/HBoxContainer3/Pomodoro_Button
@onready var status_label: Label = $VBoxContainer/StatusLabel

var countdown_time := 0
var stopwatch_time := 0
var countdown_timer: Timer
var is_timer_running := false
enum TimerMode { COUNTDOWN, STOPWATCH, POMODORO }
var current_timer_mode = TimerMode.COUNTDOWN
var pomodoro_work_time := 25 * 60
var pomodoro_break_time := 5 * 60
var pomodoro_session_count := 0
var is_pomodoro_work_session := true

func _ready() -> void:
	countdown_timer = Timer.new()
	countdown_timer.wait_time = 1.0
	countdown_timer.one_shot = false
	countdown_timer.timeout.connect(_on_timer_tick)
	add_child(countdown_timer)


func _on_mode_button_pressed() -> void:
	match current_timer_mode:
		TimerMode.COUNTDOWN:
			current_timer_mode = TimerMode.STOPWATCH
			stopwatch_time = 0
			timer_lineedit.text = "00:00"
		TimerMode.STOPWATCH:
			current_timer_mode = TimerMode.POMODORO
			_reset_pomodoro()
		TimerMode.POMODORO:
			current_timer_mode = TimerMode.COUNTDOWN
			timer_lineedit.text = "00:05"
	_stop_timer()
	_update_timer_display()

func _on_pomodoro_button_pressed() -> void:
	if current_timer_mode == TimerMode.POMODORO:
		_start_pomodoro_session()
	else:
		status_label.text = "Switch to Pomodoro mode first!"

func _reset_pomodoro():
	pomodoro_session_count = 0
	is_pomodoro_work_session = true
	countdown_time = pomodoro_work_time
	timer_lineedit.text = _format_time(countdown_time)

func _start_pomodoro_session():
	if is_pomodoro_work_session:
		countdown_time = pomodoro_work_time
		status_label.text = "Work Session " + str(pomodoro_session_count + 1) + " - Focus!"
	else:
		countdown_time = pomodoro_break_time
		status_label.text = "Break Time - Relax!"
	timer_lineedit.text = _format_time(countdown_time)
	_start_timer()

func _start_timer():
	is_timer_running = true
	countdown_timer.start()
	timer_start.text = "running..."
	timer_start.disabled = true

func _stop_timer():
	is_timer_running = false
	countdown_timer.stop()
	timer_start.text = "start"
	timer_start.disabled = false

func _on_timer_start_pressed() -> void:
	match current_timer_mode:
		TimerMode.COUNTDOWN:
			var time_text = timer_lineedit.text.strip_edges()
			var parts = time_text.split(":")
			if parts.size() == 2:
				var minutes = int(parts[0])
				var seconds = int(parts[1])
				countdown_time = minutes * 60 + seconds
				if countdown_time > 0:
					_start_timer()
					status_label.text = "Timer running..."
		TimerMode.STOPWATCH:
			stopwatch_time = 0
			_start_timer()
			status_label.text = "Stopwatch running..."
		TimerMode.POMODORO:
			_start_pomodoro_session()

func _on_timer_stop_pressed() -> void:
	_stop_timer()
	match current_timer_mode:
		TimerMode.COUNTDOWN, TimerMode.POMODORO:
			status_label.text = "Timer stopped"
		TimerMode.STOPWATCH:
			status_label.text = "Stopwatch stopped at " + timer_lineedit.text

func _on_timer_tick() -> void:
	match current_timer_mode:
		TimerMode.COUNTDOWN:
			if countdown_time > 0:
				countdown_time -= 1
				timer_lineedit.text = _format_time(countdown_time)
			else:
				_stop_timer()
				status_label.text = "Time's up!"
		TimerMode.STOPWATCH:
			stopwatch_time += 1
			timer_lineedit.text = _format_time(stopwatch_time)
		TimerMode.POMODORO:
			if countdown_time > 0:
				countdown_time -= 1
				timer_lineedit.text = _format_time(countdown_time)
			else:
				_stop_timer()
				if is_pomodoro_work_session:
					pomodoro_session_count += 1
					is_pomodoro_work_session = false
					status_label.text = "Work session " + str(pomodoro_session_count) + " done! Take a break!"
				else:
					is_pomodoro_work_session = true
					status_label.text = "Break over! Ready for work session " + str(pomodoro_session_count + 1)

func _on_close_requested() -> void:
	visible = false
	
func _format_time(seconds: int) -> String:
	var min = seconds / 60
	var sec = seconds % 60
	return "%02d:%02d" % [min, sec]
	
func _update_timer_display():
	match current_timer_mode:
		TimerMode.COUNTDOWN:
			mode_button.text = "Countdown"
			timer_label.text = "duration"
			status_label.text = "Set time and press start"
		TimerMode.STOPWATCH:
			mode_button.text = "Stopwatch"
			timer_label.text = "elapsed"
			status_label.text = "Press start to begin"
		TimerMode.POMODORO:
			mode_button.text = "Pomodoro"
			timer_label.text = "session"
			if is_pomodoro_work_session:
				status_label.text = "Work Session " + str(pomodoro_session_count + 1)
			else:
				status_label.text = "Break Time!"
