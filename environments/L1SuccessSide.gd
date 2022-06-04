extends Area


var AvailableAreas = [Vector3(8, 0.01, 0), Vector3(16, 0.01, 0), Vector3(8, 0.01, -8), Vector3(16, 0.01, -8), ];
var RandomGenerator = RandomNumberGenerator.new()
var SuccessCount = 0
var TargetCount = 5


func _on_SuccessSide_body_entered(body):
	if body.name == "Player":
		SuccessCount += 1
		if SuccessCount == TargetCount:
			$AudioStreamPlayer_End.play(0)
			yield(get_tree().create_timer(0.5), "timeout")
			$AudioStreamPlayer_End.stop()
			get_tree().change_scene("res://environments/Level02.tscn")
			return
		$AudioStreamPlayer_Success.play(0)
		yield(get_tree().create_timer(0.5), "timeout")
		$AudioStreamPlayer_Success.stop()


		var areas = AvailableAreas.duplicate()
		areas.erase(self.global_transform.origin)
		var old_position = self.global_transform.origin
		self.global_transform.origin = areas[RandomGenerator.randi_range(0, len(areas) - 1)]
		get_parent().change_last_position(old_position)
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().change_target_position(self.global_transform.origin)
		
	
		
