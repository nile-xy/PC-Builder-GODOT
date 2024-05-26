extends Node

var file_path = "res://item_database.json"
var components = [
	{'class':"Case",'manufactor':"Sentinel",'model':"XX"},
	{'class':"Case Cover",'manufactor':"Sentinel",'model':"XX"},
	{'class':"Motherboard",'manufactor':"MEGABYTE",'model':"Z99 GH-08"},
	{'class':"PSU",'manufactor':"VEGA",'model':"UnlimitedPower2"},
	{'class':"CPU",'manufactor':"Ino",'model':"G7-4779k"},
	{'class':"CPU Cooler",'manufactor':"Fujin",'model':"Black"},
	{'class':"Memory",'manufactor':"Striker",'model':"D"},
	{'class':"Storage",'manufactor':"Striker",'model':"HS"},
	{'class':"Graphics Card",'manufactor':"Asmon",'model':"Razor"},
	]
var components_database: Array

func _init():
	randomize()
#	save_components_data()
	load_components_data()
#func _ready():


func get_item(idx=-1):
	if idx >= 0:
		return components_database[idx]
	return components_database[randi()%components_database.size()]


func save_components_data():
	var file = File.new()
	file.open(file_path, File.WRITE)
	for c in components:
		c.id = randi()%999999
		c.name = str(c['manufactor'],' ',c['model'])
		c.price = randi()%200
	file.store_line(to_json(components))
	file.close()


func load_components_data():
	var file = File.new()
	if !file.file_exists(file_path):
		print('no file')
		return
	file.open(file_path, File.READ)
	components_database = parse_json(file.get_as_text())
