function create_dialogue(_messages){
    if(instance_exists(obj_Dialogue)) return;

    var _inst = instance_create_depth(0, 0, 0, obj_Dialogue);
    _inst.messages = _messages;
    _inst.current_message = 0;
}

char_colors = {
	"Merchant:": c_white,
	"Hero:": c_lime,
	"World": c_silver
}

welcome_dialogue = [
{
	name: "Merchant:",
	msg: "Hail traveller! Welcome to my shop!"
},

{
	name: "Hero:",
	msg: "What have you got for sale ?"
},
{
	name: "Merchant:",
	msg: "Please take a look ...But first heres a lightning spell as a Gift",
},
{
	name:"World",
	msg: "You Recieved Lightning Spell",
	addSpellToParty: 
	function() 
		{
			for (var i = 0; i < array_length(global.party); i++) 
			{
				var _actions = global.party[i].actions;
				var hasLightning = false;
				for (var j = 0; j < array_length(_actions); j++) 
				{
					if (_actions[j] == global.actionLibrary.lightning) {
					hasLightning = true;
					break;
					}
				}
				if (!hasLightning)
				{
					 array_push(global.party[i].actions, global.actionLibrary.lightning);
				}				
			}
		}
		
},
]
