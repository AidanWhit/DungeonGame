### TODO
* ~~Create an explosion radius that is triggered when the explosion bullet hits a wall~~
	- This would be used to deal damage to enemies/damagable environment
* ~~Create homing behavior~~
* Create slowing/freeze behavior
* ~~Reload Timer for Weapons~~
* Figure out how to structure weapons that have a certain amount of upgrade slots
* direction and velocity should be seperated as a bullet's direction will not necessarily always be the same as velocity
	- When using the flight path modifiers, the bullets overall path is much different than its direction
	- However in instances like homing and following the mouse, the direction should be identical 
	- If this is the case, every physics process, the velocity of the bullet would have to be set to the move_speed * direction

# Known Bugs
* ~~When rolling, the enemies bullet can get stuck in the player causing it to disappear. The character collider still collides with the bullet
and not the hurtbox~~
	- Fixed but, seems like a hacky fix to me

# Inventory Ideas
* The player has an inventory that they can use to hold modular upgrades (dmg, pierce, homing, shot type, etc.)
* The current gun then has its own inventory that allows these upgrades to be applied

# Different Gun idea
* There are different guns that will have randomized base stats / upgrades already applied
* Has a random amount of room for modular upgrades
* Could have different rarities that determine what range of stats they could have / number of slots for upgrades
