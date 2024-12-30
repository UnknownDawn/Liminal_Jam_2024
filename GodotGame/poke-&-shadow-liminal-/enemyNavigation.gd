extends CharacterBody2D

@onready var nav : NavigationAgent2D = $NavigationAgent2D

const speed = 300
const accel = 7
var prep

@onready var Area = $Area2D

var state = "wander"
@onready var supprise_icon = $Supprise

func _ready():
	prep = true
	supprise_icon.visible = false
func _physics_process(delta):

	if ready:
		var direction = Vector3()
		
		if state == "chase":
			nav.target_position = $"../Player".get_node("CharacterBody2D").global_position
		
		
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * speed, accel * delta)
		
		
		move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		if state != "chase":
			print(state)
			state = "supprise"
			supprise_icon.visible = true
			await get_tree().create_timer(1).timeout
			state = "chase"
			supprise_icon.visible = false
