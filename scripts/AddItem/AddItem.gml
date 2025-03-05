/// @function addItem
/// @description add item to grid
/// @argument0 DSGrid Grid_To_Add
/// @argument1 String Item Name
/// @argument2 Int Item_Amount
/// @argument3 String Item_Description
/// @argument4 Sprite Item_Sprite
/// @argument5 Script Item_Script

gridToAddTo = argument0;
newItemName = argument1;
newItemAmount = argument2;
newItemDescription = argument3;
newItemSprite = argument4;
newItemScript = argument5;

//Scenario 1 - Item is already in inventory
for (i = 0; i < ds_grid_height(gridToAddTo); i++){
	if(ds_grid_get(gridToAddTo, 0, i) == newItemName) {
		ds_grid_set(gridToAddTo, 1, i, ds_grid_get(gridToAddTo, 1, i) + newItemAmount);
		return true;
	}
};

//Scenario 2 - Item is not in inventory
if(ds_grid_get(gridToAddTo, 0 , 0) != 0)
	//if first grid is not equal to 0 (Contains an Item) resize grid +1
	ds_grid_resize(gridToAddTo, playerInvWidth, ds_grid_height(gridToAddTo) + 1);
	
newItemSpot = ds_grid_height(gridToAddTo) -1;
ds_grid_set(gridToAddTo, 0, newItemSpot, newItemName);
ds_grid_set(gridToAddTo, 1, newItemSpot, newItemAmount);
ds_grid_set(gridToAddTo, 2, newItemSpot, newItemDescription);
ds_grid_set(gridToAddTo, 3, newItemSpot, newItemSprite);
ds_grid_set(gridToAddTo, 4, newItemSpot, newItemScript);

return true;