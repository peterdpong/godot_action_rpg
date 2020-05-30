extends Node2D

func createGrassEffect():
	var GrassEffect = load("res://Effects/GrassEffect.tscn")
	var grassEffect = GrassEffect.instance()
	var world = get_tree().current_scene
		
	#Add grassEffect instance
	world.add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	createGrassEffect()
	queue_free()
	
