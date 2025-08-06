extends CharacterBody2D

@export var speed = 400
var screen_size
@onready var nav_agent = $NavigationAgent2D
var target_node : Node2D

func _ready() -> void:
	screen_size = get_viewport_rect().size
	# Wait one frame to ensure navigation is ready
	await get_tree().process_frame
	# Find the target node in the scene tree
	var nav_region = get_parent()
	target_node = nav_region.get_node_or_null("Target")
	if target_node:
		nav_agent.target_position = target_node.global_position

func _physics_process(delta):
	if target_node:
		# Update target position in case the target moves
		nav_agent.target_position = target_node.global_position
	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		return
		
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = (next_path_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
