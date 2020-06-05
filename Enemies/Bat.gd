extends KinematicBody2D

const BatDeathEffect = preload("res://Effects/BatDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum{
	IDLE,
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO
var knockback_speed = 125

var velocity = Vector2.ZERO

var state = IDLE

onready var sprite = $Sprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtBox = $Hurtbox


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seekPlayer()
		
		WANDER:
			pass
		
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = position.direction_to(player.global_position).normalized()
				#(player.global_position - global_position)
				velocity = velocity.move_toward(MAX_SPEED * direction, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	
	velocity = move_and_slide(velocity)
	
			
			
func seekPlayer():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtBox.create_hit_effect()
	var knockback_direction = get_node("Hurtbox").global_position - area.get_parent().global_position
	knockback_direction = knockback_direction.normalized()
	knockback = knockback_direction * knockback_speed


func _on_Stats_no_health():
	queue_free()
	var batDeathEffect = BatDeathEffect.instance()
	get_parent().add_child(batDeathEffect)
	batDeathEffect.global_position = global_position
