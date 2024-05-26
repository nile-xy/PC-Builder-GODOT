class_name Cpu extends Component


var cores: int
var cache: int
var base_frequency: float
var max_frequency: float
var threads: int


#func set_data(_data):
#	data = _data
#	cores = data.cores
#	cache = data.cache
#	base_frequency = data.base_frequency
#	max_frequency = data.max_frequency
#	threads = data.threads

func apply_thermal_paste():
	print('applying thermal pse')
