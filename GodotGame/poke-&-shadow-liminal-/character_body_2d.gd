extends CharacterBody2D

@onready var player_sprite = $PlayerSprite

@onready var Animation_Player_Bob = $"../PlayerBobber"

@onready var projectile = preload("res://projectile.tscn")


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var angle_to_mouse



#Where all physics updates happen.
func _physics_process(delta):

	if Input.is_action_just_pressed("Shoot"):
		shot()
	#Calculate angle from player to mouse 
	#This is used for shooting direction and flashlight ange.
	
	angle_to_mouse = self.get_angle_to(get_global_mouse_position())

	$PlayerSprite/FlashlightRotationPoint.look_at(get_global_mouse_position())


	#MOVEMENT SECTION
	
	#UP DOWN DIRECTION MOVEMENT
	
	var directiony = Input.get_axis("ui_up", "ui_down")

	
	if directiony < 0:
		player_sprite.frame = 1
	
	elif directiony > 0:
		player_sprite.frame = 0
	
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	#LEFT RIGHT DIRECTION MOVEMENT
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction < 0:
		player_sprite.frame = 2
		player_sprite.flip_h = false
	elif direction > 0:
		player_sprite.frame = 2
		player_sprite.flip_h = true
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	if velocity != Vector2(0,0):
		if !Animation_Player_Bob.is_playing():
			Animation_Player_Bob.play("bob")
	elif velocity == Vector2(0,0):
		Animation_Player_Bob.play("RESET")
		
	velocity = velocity.normalized()*SPEED
	
	move_and_slide()


func shot():
	print("Shoot")
	

	move_and_slide()
	var instance = projectile.instantiate() 
	instance.rotation = get_angle_to(get_global_mouse_position())
	add_child(instance)
