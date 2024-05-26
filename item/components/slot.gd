extends Area

signal component_installed(component)

onready var pos := $Position3D
var installed: Component setget set_installed
var placeholder
var class_
export (bool) var disabled = false setget set_disabled


func _ready():
	set_disabled(disabled)


func set_installed(value):
	installed = value
	set_disabled(installed!=null)

func set_disabled(value):
	disabled = value
	$CollisionShape.disabled = disabled


func _on_slot_area_entered(area):
	var p = area.owner
	if p is Player && p.equipped && class_==str("s-",p.equipped.data.class) && !installed:
		placeholder = p.equipped.placeholder_v
		p.equipped.placeholder_v.global_transform = pos.global_transform
		placeholder.show()


func _on_slot_area_exited(area):
	if placeholder:
		placeholder.hide()


func install(component:Component):
	if !installed:
		installed = component
		component.is_installed = true
		installed.placeholder_v.hide()
		Utils.change_parent(component,pos)
		component.disable_collision(false)
		emit_signal("component_installed",component)
		return true
	print(get_parent().name,' has a component installed already')


func uninstall_component(cmp):
	self.installed = null
