extends Node

class_name FiniteStateMachine

@export var currentState : State

func _ready():
	changeState(currentState)

func changeState(newState: State):
	if currentState is State:
		currentState._exitState()
	newState._enterState()
	currentState = newState

