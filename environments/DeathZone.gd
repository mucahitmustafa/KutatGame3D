extends Area


func _on_DeathZone_body_entered(body):
	if body.name == "Player":
		$AudioStreamPlayer_Lost.play(0.9)
		yield(get_tree().create_timer(1.2), "timeout")
		$AudioStreamPlayer_Lost.stop()
		get_tree().reload_current_scene()
	
