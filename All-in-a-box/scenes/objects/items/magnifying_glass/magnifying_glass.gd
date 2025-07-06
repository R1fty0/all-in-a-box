class_name MagnifyingGlass
extends RigidBody3D

@onready var viewport = $LensMesh/SubViewport
@onready var lens = $LensMesh

func _ready():
	viewport.world_3d = get_viewport().world_3d
	var tex = viewport.get_texture()
	var mat = lens.get_active_material(0)

	if mat is ShaderMaterial:
		mat.set_shader_parameter("magnify_tex", tex)
