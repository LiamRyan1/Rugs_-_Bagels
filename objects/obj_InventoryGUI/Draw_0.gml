if instance_number(obj_Player) == 1
{
	gpu_set_scissor(0,0,320, 180);
}
else if instance_number(obj_Player) == 2
{
	gpu_set_scissor(0,0,320/2, 180/2);
}
else if instance_number(obj_Player) == 3
{
	gpu_set_scissor(0,0,320, 180/2);
}
// Get camera position
var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);

// Set inventory UI position relative to the camera
var inventoryX = camX + 50; 
var inventoryY = camY + 50;

// Get sprite width & height for proper text alignment
var inv_width = sprite_get_width(sInventory);
var inv_height = sprite_get_height(sInventory);

// Draw the inventory sprite
if (sprite_exists(sInventory)) {
    draw_sprite(sInventory, 0, inventoryX, inventoryY);
}

// Set the custom font for text (use the fnt_inventory font here)
draw_set_font(fnt_inventory);  // Use your custom font (fnt_inventory)

// Set text properties
draw_set_halign(fa_left);   // Align text to the left
draw_set_valign(fa_top);    // Align text to the top
draw_set_color(myColour);   // Set the text color (myColour can be any color like c_black, etc.)

// Define text padding inside the inventory box
var padding = 10;  // Padding for spacing inside the inventory box
var textX = inventoryX + padding;
var textY = inventoryY + padding;

// Define max text width to prevent overflow
var max_text_width = inv_width - (2 * padding);  // Adjusted for padding

// Draw the text for inventory headers
draw_text((textX - 60), (textY - 50), "Image");
draw_text((textX - 60) + max_text_width * 0.4, (textY - 50), "Name");      // Shift to the right for "Name"
draw_text((textX - 60) + max_text_width * 0.75, (textY - 50), "Amount");   // Shift further for "Amount"

// Calculate starting positions for item names
var itemLeftStart = inventoryX -10;  // X position for items
var itemTopStart = inventoryY - 30;   // Y position for items

// Loop through items in the inventory and draw them
// Loop through items in the inventory and draw
// Loop through items in the inventory and draw
// Loop through items in the inventory and draw
for (i = 0; i < inventoryEndAt; i++) {
    // Correctly fetch item name (column 0), amount (column 1), and sprite (column 3)
    var itemName = ds_grid_get(myItems, 0, i);  // Item name (column 0)
    var itemAmount = ds_grid_get(myItems, 1, i);  // Item amount (column 1)
    var itemSprite = ds_grid_get(myItems, 3, i);  // Item sprite (column 3)

    // Draw the item sprite (scaled or not)
    if (sprite_exists(itemSprite)) {
        var spriteSize = 32; // Adjust sprite size if needed
        draw_sprite(itemSprite, 0, itemLeftStart - 40, itemTopStart + (i * 32));  // Draw sprite to the left of the text
    }

    // Draw the item name and amount (properly aligned)
    draw_text(itemLeftStart, itemTopStart + (i * 32), itemName);  // Draw item name
    draw_text(itemLeftStart + max_text_width * 0.55, itemTopStart + (i * 32), string(itemAmount));  // Draw item amount
}
gpu_set_scissor(0, 0, display_get_width(), display_get_height());