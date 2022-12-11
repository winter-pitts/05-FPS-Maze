extends Area


func _on_jewel_body_entered(body):
	if body.name == "Player":
		var exit = get_node_or_null("/root/Game/Maze/Exit")
		if exit != null:
			var sound = get_node_or_null("/root/Game/Jewel")
			if sound != null:
				sound.playing = true
			exit.unlock()
			queue_free()
