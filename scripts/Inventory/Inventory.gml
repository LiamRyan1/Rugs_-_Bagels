/// @description Add Items to Master List
/// @param attributes The array of attributes to add
function AddItemToMasterList(attributes){
	
	//Resize the grid every time item is added by adding 1 to width/x value
	ds_grid_resize(global.AllItems, ds_grid_width(global.AllItems) + 1, ds_grid_height(global.AllItems));
	for(var i = 0; i < array_length(attributes); i++){
		/*add item to the correct slot in the grid, -1 to account for +1 done prior,
		has to be done in this order as the slot need to be available before item is being pushed up*/	
		global.AllItems[# ds_grid_width(global.AllItems) -1, i] = attributes[i];
	}
}