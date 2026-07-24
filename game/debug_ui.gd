extends GridContainer

@onready var speed_field = %SpeedField
@onready var accel_field = %AccelField
@onready var dist_home_field = %DistHomeField
@onready var amount_change = $DebugButtons/DebugAmountChange

func _physics_process(delta):
	speed_field.text     = "%5.2f km/h" % Game.ship_speed
	accel_field.text     = "%5.2f km/h/h" % Game.ship_accel
	dist_home_field.text = "%10d km"    % Game.home_distance


func _on_debug_speed_change_pressed():
	Game.ship_speed += float(amount_change.text)
	amount_change.text_submitted.emit()

func _on_debug_accel_change_pressed():
	Game.ship_accel += float(amount_change.text)
	amount_change.text_submitted.emit()


func _on_debug_distance_change_pressed():
	Game.home_distance += float(amount_change.text)
	amount_change.text_submitted.emit()
