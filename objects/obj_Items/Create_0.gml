/// @description Master Item Object

// Item Properties
enum Item{
	Name,
	Sprite,
	Amount,
	Type,
	Price,
	Object,
	Height
}

enum Type{
	Weapon,
	Armor,
	Consumable
}

enum sortType{
	Name,
	Amount,
	Type,
	Price,
	Height
}

//Creating ds grid
global.AllItems = ds_grid_create(0, Item.Height);

//when called adds the item to master list
AddItemToMasterList(["Dragon Slayer", sDragonSlayer, 1, Type.Weapon, 5, obj_Dragon_Slayer,10]);