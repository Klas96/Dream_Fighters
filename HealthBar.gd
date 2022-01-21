extends Node

var Max_Health=100.0
var current_Health = 100.0

var precentige = 1.0

onready var health = get_node('Health')

func _ready():
	
	#health.set_under_texture(0)
	#health.set_over_texture(100)
	#set_progress_texture(50)
	pass

func update():
	precentige = current_Health/Max_Health
	print(precentige)
	#health.set_scale(Vector2(current_Health,1))
	health.set_scale(Vector2(precentige,1))
	#health.set_progress_texture(current_Health)
	
#func _process(delta):
	
	#update()
	
