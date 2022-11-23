extends Node

func _ready():
	pause_mode = PAUSE_MODE_PROCESS		# global should never be paused

func _unhandled_input(event):
	if event.is_action_pressed("menu"):	# instead of quitting, show the menu
		#get_tree().quit()
		var menu = get_node_or_null("/root/Game//UI/Menu")
		if menu != null:
			if not menu.visible:
				menu.show()
				get_tree().paused = true 	# pause the game while the menu is visible
			else:
				menu.hide()
				get_tree().paused = false
