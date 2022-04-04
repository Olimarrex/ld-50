extends HBoxContainer



func _process(delta):
	$EnemyCounters/Gobbo/Count.text = str(len(get_tree().get_nodes_in_group("Globbo")))
	$EnemyCounters/Ghosto/Count.text = str(len(get_tree().get_nodes_in_group("Ghost")))
	$EnemyCounters/Zombo/Count.text = str(len(get_tree().get_nodes_in_group("Zombo")))
	$EnemyCounters/EyeO/Count.text = str(len(get_tree().get_nodes_in_group("Eyeo")))
