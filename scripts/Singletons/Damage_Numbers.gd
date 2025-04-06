extends Node

#Damage is stored as a float but will be displayed as a float
func display_number(value: float, pos: Vector2):
	var number = Label.new()
	number.text = str(value)
	number.global_position = pos
	number.label_settings = LabelSettings.new()

	number.label_settings.font_color = Color.WHITE
	number.label_settings.outline_color = Color.BLACK
	number.label_settings.font_size = 10
	number.label_settings.outline_size = 4

	get_tree().root.add_child(number)

	# makes the label move about this location
	number.pivot_offset = Vector2(number.size / 2)
	var tween = get_tree().create_tween()
	# makes the animations run in parallel
	tween.set_parallel(true)
	var rand_dir : int = randi_range(-25, 25)
	# TODO: Create consts so that the durations are more readable
	tween.tween_property(number, "position:x", number.position.x + rand_dir, 1.0)
	tween.tween_property(number, "position:y", number.position.y - 24, 0.25).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(number, "position:y", number.position.y, 0.5).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)

	await tween.finished
	number.queue_free()
