extends KinematicBody2D

export (int) var speed = 200
var bullet

func _ready():
	get_node("Camera2D").make_current ( )
	bullet = preload("res://Scenes/Instances/bullet.tscn")

var velocity = Vector2()

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
	if Input.is_action_pressed("pause"):
		self.get_parent().get_parent().get_node("CanvasLayer/playerUI/Shop").show()
		get_tree().paused = true
	if Input.is_action_pressed("shoot"):
		var bull = bullet.instance()
		bull.get_child(0).derecshon = (get_global_mouse_position() - position).normalized()
		bull.position = self.position
		get_parent().add_child(bull)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
