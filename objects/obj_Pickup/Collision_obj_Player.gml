
addItem(playerInv, myItemName, myItemAmount, myItemDescription, myItemSprite, myItemScript,myItemConsumable);
instance_destroy();
show_debug_message("Name:" + myItemName);
show_debug_message("Consumable: " +  string(myItemConsumable));