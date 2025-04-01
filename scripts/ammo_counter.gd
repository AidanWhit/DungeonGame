extends RichTextLabel

var max_width : int = 0
var message : String = "Error Somthing Went Wrong"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_direction = TEXT_DIRECTION_RTL
	var player : player_refactor = get_tree().get_first_node_in_group("player")
	if (player):
		for child in player.get_children():
			if (child is gun):
				var child_gun = child as gun
				child_gun.shoot.connect(change_ammo_count)
				message = str(child_gun.current_ammo,"/",child_gun.max_ammo)
	
	text = "[font_size=50]%s[/font_size]" % message

func change_ammo_count(current_ammo: int, max_ammo: int) -> void:
	var message = str(current_ammo, "/", max_ammo)
	text = "[font_size=50]%s[/font_size]" % message
