/// @desc - makes a menu, options provided in the form [["name",function,argument,available],[...]]
function Menu(_x,_y,_options,_description =-1,_width = undefined,_height = undefined)
{
	with(instance_create_depth(_x,_y,-99999,obj_Menu))
	{
		options = _options;
		description = _description;
		var _optionsCount = array_length(_options);
		visibleOptionsMax = _optionsCount;
		
		//set up size
		xMargin = 10;
		yMargin = 10;
		draw_set_font(Fnt_Battle_Screen);
		heightLine = 15;
		
		//atuo width
		if(_width == undefined)
		{
			width = 1;
			if(description != -1) width = max(width, string_width(_description));
			for(var i = 0; i < _optionsCount; i++)
			{
				width = max(width, string_width(_options[i][0]));
			}
			widthFull = width + xMargin * 2;
		}else widthFull = _width;
		
		//auto height
		if(_height == undefined)
		{
			height = heightLine * (_optionsCount + (description != -1));
			heightFull = height + yMargin * 2;
		}
		else
		{
			heightFull = _height;
			//scroll
			if(heightLine *(_optionsCount +  (description != -1)) > _height - (yMargin*2))
			{
				scrolling = true;
				//div = divide to rounded down integer: so in this case divide by heightline
				visibleOptionsMax = (_height - yMargin * 2)div heightLine;
			}
		}
	}
}
function SubMenu(_options)
{
	optionsAbove[subMenuLevel] = options;
	subMenuLevel++;
	options = _options;
	hover = 0;
}
function MenuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}
function MenuSelectAction(_user,_action)
{
	with(obj_Menu) active = false;
	with (obj_Battle) BeginAction(_user,_action,_user);
	with(obj_Menu) instance_destroy();
}