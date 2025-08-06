extends NavigationRegion2D

func _ready():
	# Wait one frame to ensure all children are ready
	await get_tree().process_frame
	# Force navigation update
	navigation_polygon = NavigationServer2D.bake_from_navigation_polygon(navigation_polygon)
	
func add_tower(tower_instance: Node2D):
	add_child(tower_instance)
	# Update navigation after adding tower
	navigation_polygon = NavigationServer2D.bake_from_navigation_polygon(navigation_polygon)
