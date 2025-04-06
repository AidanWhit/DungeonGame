extends Node2D
class_name Reload_Timer

@export var offset : float = 50.0
var timer : float
var elpased_time : float = 0.0
var radius : float = 5
var player : player_refactor
signal end_of_reload 

func _init(p: player_refactor, time: float) -> void:
    top_level = true
    timer = time
    player = p

func _process(delta: float) -> void:
    elpased_time += delta
    if elpased_time > timer:
        end_of_reload.emit()
        queue_free()
    queue_redraw()

func _draw() -> void:
    var current_frame = player.sprite2D.frame
    var sprite_frames := player.sprite2D.sprite_frames

    var texture : AtlasTexture = sprite_frames.get_frame_texture(player.sprite2D.animation, current_frame)
    var y = texture.region.size.y
    draw_arc(player.global_position + Vector2(0, y - offset), radius, deg_to_rad(0.0), -deg_to_rad((elpased_time / timer) * 360), 100, Color.WHITE, 3)

