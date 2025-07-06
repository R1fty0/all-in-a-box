class_name SelectionHighlighter
extends StaticBody3D

@export var parent: Node3D
@export var mesh: MeshInstance3D
@export var outline_material: Material

# NOTE: collision_layer must be set to mouse in order for outline to work 

func _on_mouse_entered():
	mesh.material_overlay = outline_material
	
func _on_mouse_exited():
	mesh.material_overlay = null 
