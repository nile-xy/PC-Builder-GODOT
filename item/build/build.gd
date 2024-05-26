class_name Build extends Component

var case:Case
var psu:Psu
var motherboard:Motherboard
var cpu:Cpu
var cooler:Cooler
var gpu
var memory:Memory
var storage:Storage
var req_cmp = []

var added_components = [] setget initBuild  #dicts
func initBuild(value):
	added_components = value
	for c in added_components:
		install_component(c,self)
var running


func _ready():
	if !data.added_components.empty():
		self.added_components = data.added_components


func startup():
	req_cmp = [case,psu,motherboard,cpu,memory,storage]
	for rc in req_cmp:
		if !rc: 
			Events.emit_signal("cmp_missing")
			print('Missing component!')
			return false
	
	for i in installed_components:
		if !i.data.stable:
			print('Error in component ', i.data.class_.to_upper())
			return false
		i._init_()
		print(i.data.class_,'-',psu.supply_left)
	
	print('errthangs ok')
	running = true
	return true


func shutdown():
	running = false
	print('shutting down...')

func reset():
	print('rebooting')


func is_completed() -> bool:
	for rc in req_cmp:
		if !installed_components.has(rc):
			return false
	return true


func uninstall_component(cdata):
	for ac in added_components:
		if ac.id == cdata.id:
			cdata.installed = false
			cdata.parent_build = null
			self[cdata.class_] = null
			added_components.remove(added_components.find(ac))
			# remove from build
			Events.emit_signal("cmp_uninstalled",ac)
