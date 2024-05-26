extends Spatial


func _input(event):
	if event is InputEventKey && event.pressed:
		if event.scancode == KEY_TAB:
			$"%InventoryUI".visible = !$"%InventoryUI".visible
		
		if event.scancode == KEY_ESCAPE:
			var mmode = Input.get_mouse_mode()
			mmode = 0 if mmode == 2 else 2
			Input.set_mouse_mode(mmode)
			$"%Button".visible = !$"%Button".visible


func _on_Button_pressed():
	get_tree().quit()
