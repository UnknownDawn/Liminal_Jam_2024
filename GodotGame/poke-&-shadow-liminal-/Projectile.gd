extends Sprite2D

@export  var sprite : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	sprite.position.x = (sprite.position.x + delta*10000)
