extends Resource

class_name Dialogue

@export var dialogue: Array[String]
@export var speaking: Array[String]
@export var player: Texture2D
@export var speaker: Texture2D
@export var player_input: Array[String]

#Create Resources as Scenes and use a seperate script like a Manager script
#In the Manager script, create variables such as a SceneKey(Integer) and 
#const array of the Dialogue class which will contain the preloads of scenes you create
