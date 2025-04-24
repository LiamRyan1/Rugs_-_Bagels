function create_dialogue(_messages) {
    if (instance_exists(obj_Dialogue)) return;

    var _inst = instance_create_layer(0, 0, "Instances", obj_Dialogue);
    _inst.messages = _messages;
    _inst.current_message = 0;
}

char_colors = {
    "Gundren:": c_yellow,
    "Hero:": c_lime,
    "World": c_black,
    "Sildar:": c_yellow
};

welcome_dialogue = [
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
];

forestEntrance1_dialogue = [
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
];
