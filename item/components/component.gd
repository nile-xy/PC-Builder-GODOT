class_name Component extends Item

export (Color) var placeholder_albedo

onready var collision_shape: StaticBody = find_node("StaticBody")
var placeholder_v  #model Spatial
var slots = []  #slot nodes
var installed_components = []  #nodes
var is_installed := false

func _ready():
	# get data from component_database using node's name
	for cdata in ItemDatabase.components_database:
		if self.name == str(cdata.class,"-",cdata.name):
			data = cdata
	collision_shape.owner = self  #ease access to component from the staticBody
	
	_init_placeholder_v()
	
	for s in $slots.get_children():
		for ss in s.get_children():
			slots.append(ss)
			ss.class_ = s.name
			ss.connect("component_installed",self,"_on_slot_component_installed")


func _on_slot_component_installed(cmp:Component):
	installed_components.append(cmp)
	update()


func uninstall():
	is_installed = false
	get_parent().get_parent().uninstall_component(self)


func disable_collision(disable:bool):
	 collision_shape.get_node("CollisionShape").disabled = disable


func _init_placeholder_v():
	placeholder_v = get_node("visual").duplicate()
	get_tree().root.call_deferred("add_child",placeholder_v)
	var meshInst:MeshInstance = placeholder_v.get_child(0).get_child(0)
	for sb in meshInst.get_children():
		sb.queue_free() #remove staticBody #for some reason creates 2
	
	var mat = SpatialMaterial.new()
	mat.flags_transparent = true
	mat.albedo_color = placeholder_albedo
	
	meshInst.material_override = mat
	placeholder_v.hide()

func update():
	pass
