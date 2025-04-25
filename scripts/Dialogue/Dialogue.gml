function create_dialogue(_messages) {
    if (instance_exists(obj_Dialogue)) return;

    var _inst = instance_create_layer(0, 0, "Instances", obj_Dialogue);
    _inst.messages = _messages.messages;
    _inst.current_message = 0;
	 if (variable_struct_exists(_messages, "identifier")) {
		show_debug_message(string(ds_map_find_value(global.dialogue_flags,_messages.identifier)))
        ds_map_replace(global.dialogue_flags, _messages.identifier, true);
		show_debug_message(string(ds_map_find_value(global.dialogue_flags, _messages.identifier)))
    }
}
global.dialogue_flags = ds_map_create();
//gundren
ds_map_add(global.dialogue_flags, "welcome_dialogue",false);
ds_map_add(global.dialogue_flags, "welcome2_dialogue",false);
ds_map_add(global.dialogue_flags, "welcomeNotFoundSildar",false);
ds_map_add(global.dialogue_flags, "welcomeFoundSildar",false);
//sildar
ds_map_add(global.dialogue_flags, "forestEntrance1", false);
ds_map_add(global.dialogue_flags, "forestEntrance2", false);
ds_map_add(global.dialogue_flags, "forestEntranceTalkToSildar", false);
ds_map_add(global.dialogue_flags, "forestEntranceTalkToSildarRepeat", false);
//Qelline
ds_map_add(global.dialogue_flags, "qellinePreFight_done", false);
ds_map_add(global.dialogue_flags, "qellinePostFight_done", false);
ds_map_add(global.dialogue_flags, "qellinePostFightClearedNeverTalked_done", false);
ds_map_add(global.dialogue_flags, "qellinePostForestCleared_done", false);
ds_map_add(global.dialogue_flags, "qellinePostFightNeverTalkedForestCleared_done", false);


char_colors = {
    "Gundren:": c_yellow,
    "Hero:": c_lime,
    "World": c_black,
    "Sildar:": c_yellow,
	"Qelline:": c_purple,
};

//gundren
welcome_dialogue = 
{
	 identifier: "welcome_dialogue",
	 messages:
	 [
    {
        name: "Gundren:",
        msg: "Hail, traveller! Be careful out there!"
    },
    {
        name: "Gundren:",
        msg: "These are troubling times indeed ..."
    },
    {
        name: "Hero:",
        msg: "What can I do to help?"
    },
    {
        name: "Gundren:",
        msg: "You look like someone who can handle themselves in a fight ..."
    },
    {
        name: "Hero:",
        msg: "Err ..."
    },	
    {
        name: "Gundren:",
        msg: "Here take this, I think you'll be needing it"
    },	
    {
        name: "World",
        msg: "You received the Lightning Spell!",
        addSpellToParty: function() {
            for (var i = 0; i < array_length(global.party); i++) {
                var _actions = global.party[i].actions;
                var hasLightning = false;

                for (var j = 0; j < array_length(_actions); j++) {
                    if (_actions[j] == global.actionLibrary.lightning) {
                        hasLightning = true;
                        break;
                    }
                }

                if (!hasLightning) {
                    array_push(global.party[i].actions, global.actionLibrary.lightning);
                }
            }
        }
    },
	{
        name: "Hero:",
        msg: "Hey .. thanks!"
    },	
	{
        name: "Gundren:",
        msg: "If you see my brother Sildar..."
    },	
		{
        name: "Gundren:",
        msg: "Let him know I was looking for him..."
    },	
	{
        name: "Gundren:",
        msg: "He left earlier mumbling something about the forest ..."
    },	
]};

welcome2_dialogue = 
{
	 identifier: "welcome2_dialogue",
	 messages:
	 [
    {
        name: "Hero:",
        msg: "Are you perhaps Gundren?"
    },
    {
        name: "Gundren:",
        msg: "Who's asking ,These are troubling times..."
    },
    {
        name: "Hero:",
        msg: "Sildar told me to talk to you"
    },
	 {
        name: "Hero:",
        msg: "Hes just at the entrance to the forest"
    },
    {
        name: "Gundren:",
        msg: "Hes back safe ,Thank the Seven"
    },
    {
        name: "Hero:",
        msg: "Err ..."
    },	
    {
        name: "Gundren:",
        msg: "Here take this, you've been a great help"
    },	
    {
        name: "World",
        msg: "You received the Lightning Spell!",
        addSpellToParty: function() {
            for (var i = 0; i < array_length(global.party); i++) {
                var _actions = global.party[i].actions;
                var hasLightning = false;

                for (var j = 0; j < array_length(_actions); j++) {
                    if (_actions[j] == global.actionLibrary.lightning) {
                        hasLightning = true;
                        break;
                    }
                }

                if (!hasLightning) {
                    array_push(global.party[i].actions, global.actionLibrary.lightning);
                }
            }
        }
    },
	{
        name: "Hero:",
        msg: "Thanks!"
    },	
]};
welcomeNotFoundSildar_dialogue = 
{
	 identifier: "welcomeNotFoundSildar",
	 messages:
	 [
	 {
        name: "Gundren:",
        msg: "Have you seen my brother Sildar Yet?"
	},	
	{
        name: "Hero:",
        msg: "Not yet"
    },	
	{
        name: "Gundren:",
        msg: "Hes an illusive fellow, Please tell me when you do"
	},	
	]
};
welcomeFoundSildar_dialogue = 
{
	 identifier: "welcomeFoundSildar",
	 messages:
	 [
	 {
        name: "Gundren:",
        msg: "I can rest easy knowing sildars safe"
	},	
	{
        name: "Gundren:",
        msg: "Good luck out there traveller"
	},	
	]
};


forestEntrance1_dialogue = {
	 identifier: "forestEntrance1",
	 messages: [
    {
        name: "Sildar:",
        msg: "Hello, traveller!"
    },
    {
        name: "Sildar:",
        msg: "This place can be strange sometimes..."
    },
    {
        name: "Hero:",
        msg: "What do you mean? ...."
    },
    {
        name: "Sildar:",
        msg: "There have been reports of skeletons in the woods!"
    },
    {
        name: "Hero:",
        msg: "Thanks for the warning..."
    },
	{
        name: "Sildar:",
        msg: "Wait! Before you go..."
    },
	{
        name: "Sildar:",
        msg: "My brother Gundren may have something to help you ..."
    },
	{
        name: "Hero:",
        msg: "You must be Sildar then..."
    },
	{
        name: "Hero:",
        msg: "Gundren has been looking for you ..."
    },
	{
        name: "Hero:",
        msg: "He said you left earlier? ..."
    },
	{
        name: "Hero:",
        msg: "You were mumbling something about the forest ..."
    },
	{
        name: "Hero:",
        msg: "Don't worry about me he gave me some extra firepower ..."
    },
	{
        name: "Sildar:",
        msg: "I see you can take care of yourself. Good luck out there ..."
    },
]
};
forestEntrance2_dialogue ={
	 identifier: "forestEntrance2",
	 messages:[ 
	{
        name: "Sildar:",
        msg: "Hello, traveller!"
    },
    {
        name: "Sildar:",
        msg: "This place can be strange sometimes..."
    },
    {
        name: "Hero:",
        msg: "What do you mean? ...."
    },
    {
        name: "Sildar:",
        msg: "There have been reports of skeletons in the woods!"
    },
    {
        name: "Hero:",
        msg: "Thanks for the warning..."
    },
	{
        name: "Sildar:",
        msg: "Wait! Before you go..."
    },
	{
        name: "Sildar:",
        msg: "My brother Gundren may have something to help you ..."
    },
	{
        name: "Hero:",
        msg: "Where?"
    },
	{
        name: "Sildar:",
        msg: "In the center of the village you can't miss him."
    },
	{
        name: "Sildar:",
        msg: "He was muttering something about his spell finally working."
    },
	{
        name: "Sildar:",
        msg: "Some extra fire power would help you"
    },
	{
        name: "Hero:",
        msg: "Thanks i'll be sure to check him out"
    },
]
};
forestEntranceTalkToSildar_dialogue = {
	 identifier: "forestEntranceTalkToSildar",
	 messages: [
    {
        name: "Sildar:",
        msg: "I really do think you should talk with my brother!"
    },
	{
        name: "Sildar:",
        msg: "The skeletons dont take prisoners!"
    }]
};
forestEntranceTalkToSildarRepeat_dialogue = {
	 identifier: "forestEntranceTalkToSildarRepeat",
	 messages: [
    {
        name: "Sildar:",
        msg: "Good Luck Traveler you'll need it"
    },]
};


//qelline
qellinePreFight_dialogue = {
    identifier: "qellinePreFight_done",
    messages: [
        {
            name: "Qelline:",
            msg: "Help traveller!"
        },
        {
            name: "Qelline:",
            msg: "One of those monsters is in the village!"
        }
    ]
};


qellinePostFight_dialogue = {
	 identifier: "qellinePostFight_done",
	 messages: [
    {
        name: "Qelline:",
        msg: "Thank you traveller!"
    },
    {
        name: "Qelline:",
        msg: "Please check the Forest for more of them..."
    },

]
};

qellinePostFightNeverTalked_dialogue =
{
	 identifier: "qellinePostFightClearedNeverTalked_done",
	 messages: [
    {
        name: "Qelline:",
        msg: "Thank you traveller!!"
    },
    {
        name: "Qelline:",
        msg: "You saved me from a gruesome death"
    },
	 {
        name: "Qelline:",
        msg: "Please Clear the forest of these abominations"
    },
	{
        name: "Qelline:",
        msg: "I'll have a reward waiting for you,"
    },
	{
        name: "Hero:",
        msg: "Sure i was going that way anyways"
    },
	{
        name: "Qelline:",
        msg: "I pray to the seven for your success ,Good luck"
    },
]
};
qellinePostForestCleared_dialogue = {
	 identifier: "qellinePostForestCleared_done",
	 messages: [
    {
        name: "Qelline:",
        msg: "By the Seven I knew you could do it!"
    },
    {
        name: "Qelline:",
        msg: "Here take this axe, it belonged to my late husband"
    },
	{
        name: "World",
        msg: "You received Widowers Axe!",
		addSpellToParty: function() {
			myItemName = "Axe";
			myItemAmount = 1;
			myItemDescription = "An axe gifted by a widower";
			myItemSprite = sManaPotion;
			myItemScript = undefined;
			myItemConsumable = true;
				addItem(playerInv, myItemName, myItemAmount, myItemDescription, myItemSprite, myItemScript,myItemConsumable);
		}
	},
	 {
        name: "Qelline:",
        msg: "It should help clear the way through the forest"
    },
	{
        name: "Qelline:",
        msg: "Please rid this world of the necromancer for me..."
    },
]
};
qellinePostFightNeverTalkedForestCleared_dialogue = {
	 identifier: "qellinePostFightNeverTalkedForestCleared_done",
	 messages: [
    {
        name: "Qelline:",
        msg: "By the Seven ,you must be the one who cleared the forest!"
    },
    {
        name: "Qelline:",
        msg: "Here take this axe, it belonged to my late husband"
    },
	{
        name: "World",
        msg: "You received Widowers Axe!",
		addSpellToParty: function() {
			myItemName = "Axe";
			myItemAmount = 1;
			myItemDescription = "An axe gifted by a widower";
			myItemSprite = sManaPotion;
			myItemScript = undefined;
			myItemConsumable = true;
				addItem(playerInv, myItemName, myItemAmount, myItemDescription, myItemSprite, myItemScript,myItemConsumable);
		}
	},
	
	 {
        name: "Qelline:",
        msg: "It should help clear the way through the forest"
    },
	{
        name: "Qelline:",
        msg: "Please rid this world of the necromancer for me...",
    },
]
};
DestroyTree_dialogue = {
	 identifier: "DestroyTree_dialogue",
	 messages: [
    {
        name: "World:",
        msg: "Maybe if you had an axe you could destroy this tree"
    },
   
]
};