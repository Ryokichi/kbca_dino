extends "res://enemy/enemy.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	print ("Mamute criado")
	pass


func _on_Attack_body_shape_entered(body_id, body, body_shape, area_shape):
	print("entrou, aqui JP")
	pass # Replace with function body.


func _on_Attack_body_entered(body):
	print("to no outro")
	pass # Replace with function body.
