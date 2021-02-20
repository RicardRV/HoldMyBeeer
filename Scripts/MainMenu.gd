extends Control
var scene_path_to_load=""

func _ready():
	#keyboard selection available
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	
	#change scene when click a button, patch scene added at the editor inspector
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed",self,"on_Button_pressed", [button.scene_to_load])


	#fade in when a scene is selected  
func on_Button_pressed(scene_to_load):
	if(scene_to_load == ""):
		get_tree().quit()
	
	else:
		scene_path_to_load = scene_to_load
		$FadeIn.show()
		$FadeIn.fade_in()
	
	#when the fade in finished, show the selected scene
func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
