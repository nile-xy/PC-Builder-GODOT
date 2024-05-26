class_name Motherboard extends Component

func update():
	var cooler_slt
	for s in slots:
		if s.class_ == "s-CPU Cooler":
			cooler_slt = s
	for i in installed_components:
		if i.data.class == "CPU":
			cooler_slt.disabled = false
			return
	cooler_slt.disabled = true
