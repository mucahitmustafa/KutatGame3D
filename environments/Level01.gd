extends Spatial


func change_target_position(position: Vector3):
	position.y = -0.1
	$TargetSide.global_transform.origin = position

func change_last_position(position):
	position.y = -0.1
	$LastSide.global_transform.origin = position
