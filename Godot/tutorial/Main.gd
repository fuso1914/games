extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position) #PlayerノードからStartPsitionのpositionを取得）
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$HUD.update_score(score)
	$Music.play()

func game_over(): #PlyarノードのHitにConnectしている
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.game_over()
	$Music.stop()
	$DeathSound.play()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	

