class_name FadeTransition
extends ColorRect

@export var animation_player : AnimationPlayer

enum State {
	Idle,
	FadingIn,
	FadingOut
}
var current_state : State = State.Idle

func fade_in():
	if current_state != State.Idle:
		print_debug("Attempted to fade_in FadeTransition while already fading in/out!")
		return
	
	current_state = State.FadingIn
	show()
	animation_player.play("fade_in")
	await animation_player.animation_finished

func fade_out():
	if current_state != State.Idle:
		print_debug("Attempted to fade_out FadeTransition while already fading in/out!")
		return
	
	current_state = State.FadingOut
	color.a = 0
	show()
	animation_player.play("fade_out")
	await animation_player.animation_finished
