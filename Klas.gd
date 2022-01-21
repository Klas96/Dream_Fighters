extends KinematicBody2D

const LASER = preload("Laser.tscn")

var laser_Speed = 500

onready var timer = get_node("Timer")

onready var spawn = get_node("Position2D")

onready var healthBar = get_node("HealthBar")

const UP = Vector2(0,-1)

var health = 100

var motion = Vector2()

var max_Speed = 200

var accel = 50

var friction = false

var laser_Ready= true

var left = true

func _ready():
	restart_timer()
	set_process(true)

func _process(delta):
	motion.y += 5
	
	if Input.is_action_pressed("ui_right"):
		left = false
		laser_Speed = 500
		motion.x = min(motion.x + accel,max_Speed)
		$Sprite.flip_h=false
		$Sprite.play('Run')
	elif Input.is_action_pressed("ui_left"):
		left = true
		laser_Speed = -500
		motion.x = max(motion.x - accel,-max_Speed)
		$Sprite.flip_h=true
		$Sprite.play('Run')
	else:
		friction = true
		$Sprite.play('Front')
		
	if is_on_floor():
		motion.y = 10
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -300
		if friction:
			motion.x = lerp(motion.x,0,0.3)
	else:
		#$Sprite.play('Jump')
		friction = false
	
	if Input.is_action_just_pressed('ui_accept'):
		if laser_Ready:
			create_Laser()
			restart_timer()
			laser_Ready= false
	
	move_and_slide(motion,UP)
#	pass
func create_Laser():
	var laser = LASER.instance()
	laser.laser_Speed = laser_Speed
	get_parent().add_child(laser)
	if left:
		laser.set_position(get_node("Left_pos").get_global_position())
	if !left:
		laser.set_position(get_node("Right_pos").get_global_position())
	
func restart_timer():
	timer.set_wait_time(1)
	#timer.set_active(true)
	timer.start()
	
func _on_Timer_timeout():
	print('Timer Signal')
	laser_Ready= true
	#timer.set_active(false)
	
func damage(damage):
	#ta och animera skada
	health -= damage
	if health <= 0:
		respawn()
	healthBar.current_Health = health
	print(healthBar.current_Health)
	#healthBar.current_Health = health
	#healthBar.current_Health = health
	healthBar.update()
	#$sprite
	
func dead():
	#Förlora ett liv och respawna
	print('sdsad')
func respawn():
	#Gå till respawn plats
	print('respawn')
	health = 100
	healthBar.update()
	set_position(Vector2(400,150))
	
	