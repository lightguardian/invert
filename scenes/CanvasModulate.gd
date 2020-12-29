extends CanvasModulate

onready var = $Pl
func _draw():
	draw_line($"./".position, $GravityPoints/GravityPointA.position, Color(255, 0, 0), 1)
