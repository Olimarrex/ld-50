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

func _process(_delta):
	var dir = global_position.direction_to(get_parent().get_parent().get_node("Player/KinematicBody2D").get_position());
	velocity += ((dir * speed) / 10);
	velocity /= 1.05;
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("player"):
			inflictDamage(collision)
	get_node(spright).set_flip_h(dir[0] < 0);

func inflictDamage(_entity):
	get_parent().get_parent().get_node("Player/KinematicBody2D").takeDamage(damage)

func takeDamage(dmg):
	health -= dmg;
	var playerUI = get_tree().get_current_scene().get_node("CanvasLayer/playerUI")
	playerUI.get_node('SoundHitHurt').pitch_scale = rand_range(0.8, 1.2);
	playerUI.get_node('SoundHitHurt').play();
	$enemyHealthBar.value = health
	if health <= 0:
		call_deferred("die")

func die():
	pickupScene.time = pickUpTime
	pickupScene.get_node("Area2D").set_position(position + get_parent().position)
	get_parent().get_parent().add_child(pickupScene)
	get_parent().free()
