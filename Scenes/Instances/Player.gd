extends KinematicBody2D

export (int) var maxHealth = 1000
export (int) var speed = 200
export (float) var shootCooldown = 0.06 # Time in seconds in between each shots. Minimum time is one bullet per frame.

var bullet
var velocity = Vector2()
var health = maxHealth
var currentShootCooldown = 0

func _ready():
	get_node("Camera2D").make_current ( )
	bullet = preload("res://Scenes/Instances/bullet.tscn")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		get_node( "Wizo" ).set_flip_h( false )
		velocity.x += 1
	if Input.is_action_pressed("left"):
		get_node( "Wizo" ).set_flip_h( true )
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("shoot"):
		attemptShoot()

func attemptShoot():
	if currentShootCooldown <= 0:
		currentShootCooldown = shootCooldown
		shoot()

func shoot():
	var bull = bullet.instance()
	bull.get_child(0).derecshon = (get_global_mouse_position() - position).normalized()
	bull.position = self.position
	get_parent().add_child(bull)

func takeDamage(dmg):
	print("Player took " +  str(dmg) + " damage")
	health -= dmg
	if health <= 0:
		die()
		
func die():
	print("Player has died")
	# game over screen()
	get_tree().paused = true

func _physics_process(delta):
	if currentShootCooldown > 0:
		currentShootCooldown -= delta
	get_input()
	velocity = move_and_slide(velocity)


func _on_pickup_area_entered(collision):
	if collision.is_in_group("pick_up"):
		collision.targit = self


