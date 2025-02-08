function PlayerCollision()
{
    var _collision = false;

    // Calculate the perimeter of the player
    var player_left = x;
    var player_right = x + TILE_SIZE - 1;
    var player_top = y;
    var player_bottom = y + TILE_SIZE - 1;

    // Horizontal Collision Check (left and right edges)
    if (sign(hSpeed) == 1) // Moving right
    {
        // 1. (tilemap_get_at_pixel(collisionMap, x + hSpeed, y)) checks if there is a tile at the player's position
        if (tilemap_get_at_pixel(collisionMap, player_right + hSpeed, y)) 
        {
            // 2. x -= x mod TILE_SIZE This moves x back to the nearest tile boundary (so the player doesn't get stuck inside a wall)
			// Snap to the left boundary of the tile
            x = (x div TILE_SIZE) * TILE_SIZE; 
			// Stop horizontal movement
            hSpeed = 0; 
            _collision = true;
        }
    }
    else if (sign(hSpeed) == -1) // Moving left
    {
        if (tilemap_get_at_pixel(collisionMap, player_left + hSpeed, y)) 
        {
            
            // If moving left, stop the player at the right edge of the previous tile
            x = ((x + hSpeed) div TILE_SIZE) * TILE_SIZE + TILE_SIZE; // Snap to the right edge of the tile before the collision
            hSpeed = 0; // Stop horizontal movement
            _collision = true;
        }
    }

    // Horizontal Move Commit
    x += hSpeed;

    // Vertical Collision Check (top and bottom edges)
    if (sign(vSpeed) == 1) // Moving down
    {
        
        if (tilemap_get_at_pixel(collisionMap, x, player_bottom + vSpeed)) 
        {
     
			// Snap to the top boundary of the tile
            y = (y div TILE_SIZE) * TILE_SIZE; 
			// Stop vertical movement
            vSpeed = 0; 
            _collision = true;
        }
    }
    else if (sign(vSpeed) == -1) // Moving up
    {
        
        if (tilemap_get_at_pixel(collisionMap, x, player_top + vSpeed)) 
        {
          
            // If moving up, stop at the bottom edge of the previous tile
			// Snap to the bottom boundary of the tile
            y = ((y + vSpeed) div TILE_SIZE) * TILE_SIZE + TILE_SIZE - 1; 
			// Stop vertical movement
            vSpeed = 0; 
            _collision = true;
        }
    }

    // Vertical Move Commit
    y += vSpeed;

    return _collision;
}
