extends Node2D

const dino = preload("res://enemy/dino.tscn")
const mamute = preload("res://enemy/mamute.tscn")
const porco = preload("res://enemy/porco.tscn")

var enemy_list = [dino, mamute, porco]
var enemy_on_screen = []

func _ready():
	pass # Replace with function body.

func spawn ():
	var index = randi() % len(enemy_list)
	enemy_on_screen.append(enemy_list[index].instance())
	
	var size = len(enemy_on_screen)
	var pos_x = 150 * size;
	
	enemy_on_screen[size -1].position = Vector2(1300, 500);
	get_node(".").add_child(enemy_on_screen[size -1])
	pass
	
func i_have_to_kill_you (son):
	print("size before ", len(enemy_on_screen))
	var i = 0
	while i < len(enemy_on_screen):
		if (enemy_on_screen[i] == son):
			print ("encontrei vc: ", i)
			get_node(".").remove_child(enemy_on_screen[i])
			enemy_on_screen.remove(i)
			pass
		i += 1
		pass
	print("size after ", len(enemy_on_screen))
	print(enemy_on_screen)
	pass