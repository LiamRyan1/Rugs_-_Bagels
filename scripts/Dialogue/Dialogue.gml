function create_dialogue(_messages){
    if(instance_exists(obj_Dialogue)) return;

    var _inst = instance_create_depth(0, 0, 0, obj_Dialogue);
    _inst.messages = _messages;
    _inst.current_message = 0;
}

char_colors = {
	"Merchant:": c_white,
	"Hero:": c_lime
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
	msg: "Please take a look ..."
},


]
