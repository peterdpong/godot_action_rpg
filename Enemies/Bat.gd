extends KinematicBody2D

var knockback = Vector2.ZERO
var knockback_frict = 200
var knockback_speed = 125

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_frict * delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	var knockback_direction = get_node("Hurtbox").global_position - area.global_position
	knockback_direction = knockback_direction.normalized()
	knockback = knockback_direction * knockback_speed
