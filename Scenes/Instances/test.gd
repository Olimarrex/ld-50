extends Node2D

func death():
	$CanvasLayer/playerUI/Time.text = "00:00"
	print("dead")
