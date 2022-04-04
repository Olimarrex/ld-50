extends KinematicBody2D

export (int) var speed = 100
export (float) var shootCooldown = 0.06 # Time in seconds in between each shots. Minimum time is one bullet per frame.

var bullet
var velocity = Vector2()
var currentShootCooldown = 0
var playerUI
var deathScreenUI

func _ready():
	Autoload.gameScore = 0
	get_node("Camera2D").make_current ( )
	bullet = preload("res://Scenes/Instances/bullet.tscn")
	deathScreenUI = preload("res://Scenes/Instances/deathScreen.tscn")
	playerUI = get_tree().get_current_scene().get_node("CanvasLayer/playerUI")
	if playerUI == null:
		print("Error: Player could not find its playerUI")

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
	velocity = velocity.normalized() * speed * (1 + countPassives("Movement+") / 25.0);
	if Input.is_action_pressed("shoot"):
		attemptShoot()

	if Input.is_action_pressed("ability"):
		attemptAbility()

func countPassives(passiveName):
	var playerUI = get_tree().get_current_scene().get_node("CanvasLayer/playerUI")
	var count = 0;
	for passive in playerUI.currentPassives:
		if passive == passiveName:
			count += 1;
	return count;

func attemptShoot():
	if currentShootCooldown <= 0:
		currentShootCooldown = shootCooldown / (1 + float(countPassives("Attack Speed+") / 3.0));
		shoot()

func shoot():
	var bull = bullet.instance()
	bull.get_child(0).damage = 50 * (1 + float(countPassives("Damage+")));
	bull.get_child(0).derecshon = (get_global_mouse_position() - position).normalized()
	bull.position = self.position
	get_parent().add_child(bull)
	i += 1;
	$SoundShoot.pitch_scale = 0.4 + sin(i / 3.0) / 10.0;
	$SoundShoot.play();
var i = 0;

func attemptAbility():
	get_node("Abilities").attemptShoot()

var redness = 0.0;

func takeDamage(dmg):
	redness = 1.0;
	if playerUI != null:
		playerUI.updateTime(-(dmg / 10.0));

func _process(delta):
	if playerUI != null and playerUI.currentTime != null and playerUI.currentTime <= 0:
		die()
	if redness > 0:
		var r = 255 - ((255 - 225) * redness);
		var gb = 255 - ((255 - 53) * redness);
		playerUI.get_node("timerBackground").set_modulate(Color8(r, gb, gb));
		redness -= 0.05;

func die():
	print("Player has died")
	get_tree().change_scene("res://Scenes/Instances/deathScreen.tscn")

func _physics_process(delta):
	if currentShootCooldown > 0:
		currentShootCooldown -= delta
	get_input()
	velocity = move_and_slide(velocity)


func _on_pickup_area_entered(collision):
	if collision.is_in_group("pick_up"):
		collision.target = self
		



