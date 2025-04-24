inventoryEndAt = min(ds_grid_height(myItems), floor((sprite_height - (textBorder * 3)) / 16));
if(ds_grid_get(myItems, 0, 0) == 0){
	inventoryEndAt = 0;
	isEmpty = true;
}


