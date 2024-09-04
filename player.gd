extends Area2D
signal hit

@export var speed = 400;
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size;
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velociy = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velociy.y += 1
	if Input.is_action_pressed("move_up"):
		velociy.y -= 1
	if Input.is_action_pressed("move_left"):
		velociy.x -= 1
	if Input.is_action_pressed("move_right"):
		velociy.x += 1
		
	if velociy.length() > 0:
		velociy = velociy.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velociy * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	$AnimatedSprite2D.flip_v = velociy.y > 0
	if velociy.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velociy.x < 0
	elif velociy.y != 0:
		$AnimatedSprite2D.animation = "up"


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", false)
	pass # Replace with function body.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
