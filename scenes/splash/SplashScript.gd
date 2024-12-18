extends Control

@export var main_menu: PackedScene
@export var in_time: float = 0.5
@export var fade_in_time: float = 1.5
@export var pause_time: float = 1.5
@export var fade_out_time: float = 1.5
@export var out_time: float = 0.5
@export var splash_screen_container : Node

var splash_screens: Array

func _ready() -> void:
	get_screens()
	fade()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print("click")
	if event.is_pressed():
		get_tree().change_scene_to_packed(main_menu)

func get_screens() -> void:
	splash_screens = splash_screen_container.get_children()
	for screen in splash_screens:
		screen.modulate.a = 0.0

func fade() -> void:
	for s in splash_screens:
		var tween = self.create_tween()
		tween.tween_interval(in_time)
		tween.tween_property(s, "modulate:a", 1.0, fade_in_time)
		tween.tween_interval(pause_time)
		tween.tween_property(s, "modulate:a", 0.0, fade_out_time)
		tween.tween_interval(out_time)
		await tween.finished
	get_tree().change_scene_to_packed(main_menu)
