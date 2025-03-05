function addItem(gridToAddTo, newItemName, newItemAmount, newItemDescription, newItemSprite, newItemScript) {
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

    return true;
}