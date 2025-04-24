function addItem(gridToAddTo, newItemName, newItemAmount, newItemDescription, newItemSprite, newItemScript,newItemConsumable) {
    
	
	// Ensure the grid exists before using it
    if (is_undefined(gridToAddTo)) {
        show_debug_message("ERROR: gridToAddTo is undefined!");
        return false;
    }

    // Scenario 1 - Item is already in inventory
    for (var i = 0; i < ds_grid_height(gridToAddTo); ++i) {
        if (ds_grid_get(gridToAddTo, 0, i) == newItemName) {
            ds_grid_set(gridToAddTo, 1, i, ds_grid_get(gridToAddTo, 1, i) + newItemAmount);
            return true;
        }
    }

    // Scenario 2 - Item is not in inventory
    if (ds_grid_get(gridToAddTo, 0, 0) != 0) {
        // Resize grid to add a new row
        ds_grid_resize(gridToAddTo, ds_grid_width(gridToAddTo), ds_grid_height(gridToAddTo) + 1);
    }

    // Add new item to the inventory
    var newItemSpot = ds_grid_height(gridToAddTo) - 1;
    ds_grid_set(gridToAddTo, 0, newItemSpot, newItemName);
    ds_grid_set(gridToAddTo, 1, newItemSpot, newItemAmount);
    ds_grid_set(gridToAddTo, 2, newItemSpot, newItemDescription);
    ds_grid_set(gridToAddTo, 3, newItemSpot, newItemSprite);
    ds_grid_set(gridToAddTo, 4, newItemSpot, newItemScript);
	ds_grid_set(gridToAddTo, 5, newItemSpot, newItemConsumable);
	//get the each key
	var _keys = variable_struct_get_names(global.actionLibrary);
	for(var i = 0; i < array_length(_keys); i++)
	{
		//current key
		var _key = _keys[i]
		//check if action exists then add to player
		if(_key == newItemScript)
		{
			AddActionToPlayer(newItemScript,newItemName);
			show_debug_message("action added");
			break;
		}
	}
	show_debug_message("added to inventory");
    return true;
}
function ItemAmount(inventory,itemName)
{
	for (var i = 0; i < ds_grid_height(inventory); ++i) {
        if (ds_grid_get(inventory, 0, i) == itemName) {
			//return item amount
            return ds_grid_get(inventory, 1, i); 
        }
    }
	//no items;
	return 0;
}
function ItemConsume(inventory,action)
{
	
	for (var i = 0; i < ds_grid_height(inventory); ++i) {
        if (ds_grid_get(inventory, 0, i) == action.name) {
			//lowering amount from grid
			show_debug_message("old amount" + string(ds_grid_get(inventory, 1, i)));
			show_debug_message("is item consumable: " + string(ds_grid_get(inventory,5, i)));
			if(ds_grid_get(inventory,5, i) == true)
			{
				var _newAmount = ds_grid_get(inventory, 1, i) -1;
				show_debug_message("amount " + string(_newAmount));
				if(_newAmount > 0)
				{
					ds_grid_set(inventory, 1, i, _newAmount);
					//show_debug_message("new amount" + string(ds_grid_get(inventory, 1, i)));
				}
				else if(_newAmount <= 0)
				{
					playerInv = GridRemoveRow(inventory, i);
					for(var j = 0; j < array_length(global.party[0].actions); j++)
					{
						if(global.party[0].actions[j] == action)
						{
						
							array_delete(global.party[0].actions,j,1);
						}
					}
				}
				break;
			}
		}
	}
}

function GridRemoveRow(OldInventory, rowToRemove) {
    var cols = ds_grid_width(OldInventory);
    var rows = ds_grid_height(OldInventory);
    
	//create new inventory with 1 less row
    var newGrid = ds_grid_create(cols, rows - 1);
    var newRow = 0;
		
	//go through each row of the old inventory
    for (var oldRow = 0; oldRow < rows; oldRow++) {
		//if the row is not the one the deleted item was on
        if (oldRow != rowToRemove) {
			//go through each coloum in the row and copy its contents over to the new inventory
            for (var col = 0; col < cols; col++) {
                var val = ds_grid_get(OldInventory, col, oldRow);
                ds_grid_set(newGrid, col, newRow, val);
            }
			//move to next row in the new inventory
            newRow++;
        }
    }

    //delete old inventory
    ds_grid_destroy(OldInventory);

    return newGrid;
}
function AddActionToPlayer(action,itemName) {
	//get player1's action list 
	var actions = global.party[0].actions;
    var alreadyAdded = false;

	//check if player already has the item as an action
    for (var i = 0; i < array_length(actions); ++i) {
        if (actions[i].name == itemName) {
            alreadyAdded = true;
            break;
        }
    }
	//if the player doesnt already have the action add it 
	if (!alreadyAdded) {
		var actionData = variable_struct_get(global.actionLibrary, action);
        array_push(actions,actionData);
        show_debug_message(itemName + " action added to player!");
    }
}