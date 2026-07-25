class_name PickupStats
extends Resource

@export_category("Metadata")
@export var name : String

@export_category("SFX")
@export var pickup_sound : AudioStream
@export var drop_sound : AudioStream
@export var deposit_sound : AudioStream
@export var burn_sound_loop : AudioStream

@export_category("Stats")
@export var burn_time : float
@export var acceleration_given : float
@export var mass : float
