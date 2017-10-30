extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dialog = ["covfefe", "the greatest"]
var page = 0
export var isTalkable = 1
var textBox
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	textBox = self.get_parent().get_node("PlayerOverworld/Camera2D/Polygon2D/RichTextLabel")
	print("F\n")
	textBox.set_bbcode(dialog[page])
	textBox.set_visible_characters(0)
	set_process_input(true)
func _input(event):
	print("input")
	if(Input.is_action_pressed("ui_accept") ):
		print("accept")
		if(textBox.get_visible_characters() > textBox.get_total_character_count()):
			if(page < dialog.size() - 1):
				page+=1
				textBox.set_bbcode(dialog[page])
				textBox.set_visible_characters(0)
func _on_timer_timeout():
	textBox.set_visible_characters(textBox.get_visible_characters()+1)