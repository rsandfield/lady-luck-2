extends Control

var tutorial_state = 0 


const help_dialog = [ 
	"Welcome to Lady Luck's Door!" ,
	"Pull the lever to get pieces to play" ,
	"Pick up tiles or bombs from this area" ,
	"Drop tiles here to make a path to my door" ,
	"If you are lucky then I might help you" ,
	"If you are unlucky then, well... boom!" ,
	"Calculate your risk carefully!" 
]


func _ready() -> void:
	_set_button_highlighted()
	
	pass

func _process(_delta: float) -> void:
	
	if tutorial_state != 0 && !self.visible: 
		tutorial_state = 0
		#_set_dialog_visible()
		#print_debug("tutorial state reset: " + str(tutorial_state) )
	
	pass

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("ui_right"): 
		#print_debug("tutorial: ui_right...")
		
		tutorial_state += 1
		if self.visible: _on_change_tutorial_state( tutorial_state )
		
		pass
	
	if Input.is_action_just_pressed("ui_left"): 
		#print_debug("tutorial: ui_left...")
		
		tutorial_state -= 1
		if self.visible: _on_change_tutorial_state( tutorial_state )
		
		pass
	
	pass

func _on_show_self() -> void:
	#print_debug("_on_show_self, state: " + str(tutorial_state) )
	
	self.show()
	
	_on_change_tutorial_state(0)
	
	pass

func _on_change_tutorial_state( new_state : int ) -> void: 
	#print_debug("_on_change_tutorial_state, old: " + str(tutorial_state) )
	#print_debug("_on_change_tutorial_state, new: " + str(new_state) )
	
	tutorial_state = new_state
	
	if tutorial_state < 0 : 
		tutorial_state = 0 
	
	#print_debug("_on_change_tutorial_state, after: " + str(tutorial_state) )
	
	if tutorial_state > 6 : 
		self.hide()
		return 
	
	_set_button_highlighted()
	_set_panel_visibility()
	_set_dialog_visible()
	
	pass

func _set_button_highlighted(): 
	#print_debug("_set_button_highlighted, state: " + str(tutorial_state) )
	
	$Help1/Panel.visible = tutorial_state == 1
	$Help2/Panel.visible = tutorial_state == 2
	$Help3/Panel.visible = tutorial_state == 3
	$Help4/Panel.visible = tutorial_state == 4
	$Help5/Panel.visible = tutorial_state == 5
	$Help6/Panel.visible = tutorial_state == 6
	
	pass

func _set_dialog_visible(): 
	#print_debug("_set_dialog_visible, state: " + str(tutorial_state) )
	
	$Dialog0/RichTextLabel.text = help_dialog[ tutorial_state ]
	
	#%Dialog0.visible = tutorial_state == 0 
	#%Dialog1.visible = tutorial_state == 1 
	#%Dialog2.visible = tutorial_state == 2 
	#%Dialog3.visible = tutorial_state == 3 
	#%Dialog4.visible = tutorial_state == 4 
	#%Dialog5.visible = tutorial_state == 5
	
	pass

func _set_panel_visibility(): 
	
	$Panel2.visible = true
	$Panel3.visible = true 
	
	$Panel1.visible = tutorial_state != 1
	
	$PanelSlots.visible = tutorial_state != 2
	$PanelGrid.visible  = tutorial_state != 3
	$PanelLuck.visible  = tutorial_state != 4
	
	$HighlightLever.visible = tutorial_state == 1
	$HighlightSlots.visible = tutorial_state == 2
	$HighlightGrid.visible  = tutorial_state == 3
	$HighlightLuck.visible  = tutorial_state == 4
	
	pass

func _on_button_pressed() -> void:
	#print_debug("_on_button_pressed...")
	
	tutorial_state += 1
	_on_change_tutorial_state( tutorial_state )
	
	pass
