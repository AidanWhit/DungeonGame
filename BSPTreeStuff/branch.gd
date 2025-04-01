extends Node

class_name Branch

var left_child: Branch # top / left child
var right_child : Branch # bottom / right child
var position: Vector2i
var size: Vector2i

func _init(position, size) -> void:
	self.position = position
	self.size = size

func get_leaves() -> Array:
	# If the current node does not have children
	if not (left_child && right_child):
		# return itself as an array
		return [self]
	else:
		# Get the leaves from the children
		return left_child.get_leaves() + right_child.get_leaves()

func split(remaining, paths) -> void:
	var rand = RandomNumberGenerator.new()
	var split_percent = rand.randf_range(0.3, 0.7)
	# will be true if the height is greater than the width
	var split_horizontal : bool = size.y >= size.x
	if (split_horizontal):
		var left_height = int(size.y * split_percent)
		var right_height = size.y - left_height
		#width will stay the same
		left_child = Branch.new(position, Vector2i(size.x, left_height))
		right_child = Branch.new(Vector2i(position.x, position.y + left_height), Vector2i(size.x, right_height))
	else: # if width > height (split vertically)
		var left_width = int(size.x * split_percent)
		var right_width = size.x - left_width
		
		left_child = Branch.new(position, Vector2i(left_width, size.y))
		right_child = Branch.new(Vector2i(position.x + left_width, position.y), Vector2i(right_width, size.y))
	
	paths.append({'left': left_child.get_center(), 'right': right_child.get_center()})
	#if there are more splits to go
	if (remaining - 1 > 0):
		left_child.split(remaining - 1, paths)
		right_child.split(remaining - 1, paths)

func get_center() -> Vector2i:
	return Vector2i(position.x + size.x / 2, position.y + size.y / 2)
