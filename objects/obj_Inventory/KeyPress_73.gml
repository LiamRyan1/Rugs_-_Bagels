if(!instance_exists(obj_InventoryGUI))
{
		var inventoryDisplay = instance_create_depth(0, 0, depth - 110, obj_InventoryGUI)
		with (inventoryDisplay) {
			// Set Position (Top-Left Corner)
			x = sprite_get_xoffset(sprite_index);
			y = 180 - sprite_get_yoffset(sprite_index);
	    }
	} 
	else
	{
	gpu_set_scissor(0, 0, display_get_width(), display_get_height());
	instance_destroy(obj_InventoryGUI)
	}