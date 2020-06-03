extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func createGrassEffect():
	var grassEffect = GrassEffect.instance()
	#Add grassEffect instance
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	createGrassEffect()
	queue_free()
	
