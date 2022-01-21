extends Area2D

var laser_Speed = 500

func _ready():
	set_process(true)

func _process(delta):
	var speed_x = 1
	var speed_y = 0
	
	if laser_Speed<0:
		$Sprite.flip_h=true
	
	var motion = Vector2(speed_x,speed_y)*laser_Speed
	
	translate(motion * delta)

func _on_VisibilityNotifier2D_screen_exited():
	#Kills Himspelf
	#free()
	queue_free()

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	print('hit')
	body.damage(10)
	
	print(body.get_name() + 'Blev Skuten')
	#body.queue_free()
	
	
	