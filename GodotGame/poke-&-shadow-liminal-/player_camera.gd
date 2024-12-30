extends Camera2D


@onready var player = get_parent().get_node("Player").get_node("CharacterBody2D")
@onready var target: Node = player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position = self.global_position.lerp(target.global_position, delta*10)
	print(player.position)
