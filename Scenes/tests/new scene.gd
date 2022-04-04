extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var score_id = yield(SilentWolf.Scores.persist_score("player_name2", 13), "sw_score_posted")
	print("Score persisted successfully: " + str(score_id))
	
	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	print("Scores: " + str(SilentWolf.Scores.scores))
	SilentWolf.Scores.wipe_leaderboard()
	
