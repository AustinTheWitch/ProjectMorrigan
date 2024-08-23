extends Node
var character_affinity: Dictionary = {"Spongebob": 0, "TestRandom": 0}
#Character affinty is added from the resouces. These are then added together in the DialogueUI script.
#The affinty and writing needs to take into account that the next scene affinity
#For example, if dialogue A is supposed to have 0 gain until a decision is chosen.
#And decision X = -2 and decison Y ends the conversation but is +2
#The affinty variable is then then used like the following:
#dialogue A will have +2 and followup dialogue tied to decision Y negative will have -4.
