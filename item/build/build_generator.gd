class_name BuildGenerator extends Node


static func generate_build(empty_build:bool, def_cc = null) -> Dictionary:
	var bdata = {}
	var added_components = []
	if !empty_build:
		#add case
		var case = Market.get_item('case')
		added_components.append(case)
		#add mobo according to case ffactor
		var mobo = Market.get_item('motherboard')
		added_components.append(mobo)
		#add cpu + cooler
		var cpu = Market.get_item('cpu')
		added_components.append(cpu)
		var cooler = Market.get_item('cooler')
		added_components.append(cooler)
		#add memory
		var mem = Market.get_item('memory')
		added_components.append(mem)
		#add gpu (or nah)
		
		#add storage
		var strg = Market.get_item('storage')
		added_components.append(strg)
		#add psu according to power consumption
		var psu = Market.get_item('psu')
		added_components.append(psu)
	if def_cc:
		for c in added_components:
			if c.class_ == def_cc:
				c.stable = false
	bdata.node = null
	bdata.id = Utils.generate_id()
	bdata.class_ = 'build'
	bdata.name_ = ''
	bdata.required_components = {'case':{}}
	bdata.added_components = added_components
#	bdata.specs = {}
	
	return bdata
