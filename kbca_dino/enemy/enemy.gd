extends KinematicBody2D

onready var player = self.get_parent().get_parent().get_node("Player")

var type = "enemy"
var status = "alive"
var vulnerable = true
var damage_time = 0
var hp = 3

func _ready():
	pass # Replace with function body.

func _process(delta):
	if (damage_time > 0):
		damage_time -= delta
		vulnerable = false
	elif (damage_time <= 0):
		damage_time = 0
		vulnerable = true
		
	if (vulnerable):
		var ini_pos = get_position()
		var end_pos = player.get_position()
		
		var dif_pos = Vector2(end_pos.x - ini_pos.x, end_pos.y - ini_pos.y)
		print(dif_pos)
		pass
		
	
func get_type ():
	return type
	pass
	
func take_damage():
	if (!vulnerable):
		return
		
	hp -= 1
	damage_time = 0.3
	if (hp <= 0):
		print("Morri")
		status = "dead"
		print(self.get_parent().i_have_to_kill_you(self))
	pass