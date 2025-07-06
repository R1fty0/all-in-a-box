extends Camera3D

@export var target: Node3D

# Make the camera move with the lens mesh 
func _process(delta):
	if target == null:
		return
		print("no mesh lens")
	else:
		position = target.position
	print(position)
	print(rotation)
