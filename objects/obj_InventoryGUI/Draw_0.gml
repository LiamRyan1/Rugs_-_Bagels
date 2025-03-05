// Draw the sprite first (if needed)
draw_self();

// Set text color
draw_set_color(myColour);

// Adjust the text positions relative to the sprite's bounding box
var textX = bbox_left + textBorder;   // Position relative to sprite's left edge
var textY = bbox_top + textBorder;    // Position relative to sprite's top edge

// Draw the text
draw_text(textX, textY, "Image");
draw_text(textX + 125, textY, "Name");      // Shift to the right for "Name"
draw_text(textX + 225, textY, "Amount");   // Shift further for "Amount"