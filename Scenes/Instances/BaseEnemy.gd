extends KinematicBody2D

export (int) var speed = 200
export (int) var damage = 1
export (int) var maxHealth = 100
export (int) var pickUpTime = 1
export (NodePath) var spright = null


var velocity = Vector2()
var health;
var pickupScene

func _ready():
	pickupScene = load("res://Scenes/Instances/clock.tscn").instance()
	health = maxHealth;
	get_node("enemyHealthBar").max_value = maxHealth;
	get_node("enemyHealthBar").value = maxHealth;

func _physics_process(_delta):
	var dir = global_position.direction_to(get_parent().get_parent().get_node("Player/KinematicBody2D").get_position());
	velocity = move_and_slide(dir * speed)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("player"):
			inflictDamage(collision)
	if dir[0]>0:
		get_node(spright).set_flip_h( false )
	else:
		get_node(spright).set_flip_h( true )

func inflictDamage(_entity):
	get_parent().get_parent().get_node("Player/KinematicBody2D").takeDamage(damage)
	get_parent().get_parent().get_node("CanvasLayer").get_node("playerUI").get_node("healthBar").value -= damage
	
func takeDamage(dmg):
	health -= dmg
	$enemyHealthBar.value = health
	if health <= 0:
		call_deferred("die")

func die():
	pickupScene.time = pickUpTime
	pickupScene.get_node("Area2D").set_position(position + get_parent().position)
	get_parent().get_parent().add_child(pickupScene)
	get_parent().free()
