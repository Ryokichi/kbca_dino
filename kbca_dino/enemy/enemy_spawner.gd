extends Node2D

const dino = preload("res://enemy/dino.tscn")

var enemy_list = []

func _ready():
	pass # Replace with function body.

func spawn ():
	enemy_list.append(dino.instance())
	
	var size = len(enemy_list)
	var pos_x = 150 * size;
	
	enemy_list[size -1].position = Vector2(pos_x, 200);
	get_node(".").add_child(enemy_list[size -1])
	pass
	
func i_have_to_kill_you (son):
	print("size before ", len(enemy_list))
	var i = 0
	while i < len(enemy_list):
		if (enemy_list[i] == son):
			print ("encontrei vc: ", i)
			get_node(".").remove_child(enemy_list[i])
			enemy_list.remove(i)
			pass
		i += 1
		pass
	print("size after ", len(enemy_list))
	print(enemy_list)
	pass