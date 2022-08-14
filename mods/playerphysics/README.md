# Player Physics API.

Version: 1.0.1

This mod makes it possible for multiple mods to modify player physics (speed, jumping strength, gravity) without conflict.

## Introduction
### For players
Mods and games in Minetest can set physical attributes of players, such as speed and jump strength. For example, player speed could be set to 200%. But the way this works makes it difficult for multiple mods to *modify* physical attributes without leading to conflicts, problems and hilarious bugs, like speed that changes often to nonsense values.

The Player Physics API aims to resolve this conflict by providing a “common ground” for mods to work together in this regard.

This mod does nothing on its own, you will only need to install it as dependency of other mods.

When you browse for mods that somehow mess with player physics (namely: speed, jump strength or gravity) and want to use more than one of them, check out if they support the Player Physics API. If they don't, it's very likely these mods will break as soon you activate more than one of them, for example, if two mods try to set the player speed. If you found such a “hilarious bug”, please report it to the developers of the mods (or games) and point them to the Player Physics API.

Of course, not all mods need the Player Physics API. Mods that don't touch player physics at all won't need this mod.

The rest of this document is directed at developers.

### For developers
The function `set_physics_override` from the Minetest Lua API allows mod authors to override physical attributes of players, such as speed or jump strength.

This function works fine as long there is only one mod that sets a particular physical attribute at a time. However, as soon as at least two different mods (that do not know each other) try to change the same player physics attribute using only this function, there will be conflicts as each mod will undo the change of the other mod, as the function sets a raw value. A classic race condition occurs. This is the case because the mods fail to communicate with each other.

This mod solves the problem of conflicts. It bans the concept of “setting the raw value directly” and replaces it with the concept of factors that mods can add and remove for each attribute. The real physical player attribute will be the product of all active factors.

## Quick start
Let's say you have a mod `example` and want to double the speed of the player (i.e. multiply it by a factor of 2), but you also don't want to break other mods that might touch the speed.

Previously, you might have written something like this:

`player:set_physics_override({speed=2})`

However, your mod broke down as soon the mod `example2` came along, which wanted to increase the speed by 50%. In the real game, the player speed randomly switched from 50% and 200% which was a very annoying bug.

In your `example` mod, you can replace the code with this:

`playerphysics.add_physics_factor(player, "speed", "my_double_speed", 2)`

Where `"my_double_speed` is an unique ID for your speed factor.

Now your `example` mod is interoperable! And now, of course, the `example2` mod has to be updated in a similar fashion.

## Precondition
There is only one precondition to using this mod, but it is important:

Mods *MUST NOT* call `set_physics_override` directly for numerical values. Instead, to modify player physics, all mods that touch player physics have to use this API.

## Functions
### `playerphysics.add_physics_factor(player, attribute, id, value)`
Adds a factor for a player physic and updates the player physics immediately.

#### Parameters
* `player`: Player object
* `attribute`: Which of the physical attributes to change. Any of the numeric values of `set_physics_override` (e.g. `"speed"`, `"jump"`, `"gravity"`)
* `id`: Unique identifier for this factor. Identifiers are stored on a per-player per-attribute type basis
* `value`: The factor to add to the list of products

If a factor for the same player, attribute and `id` already existed, it will be overwritten.

### `playerphysics.remove_physics_factor(player, attribute, id)`
Removes the physics factor of the given ID and updates the player's physics.

#### Parameters
Same as in `playerphysics.add_physics_factor`, except there is no `value` argument.

## Examples
### Speed changes
Let's assume this mod is used by 3 different mods all trying to change the speed:
Potions, Exhaustion and Electrocution.
Here's what it could look like:

Potions mod:
```
playerphysics.add_physics_factor(player, "speed", "run_potion", 2)
```

Exhaustion mod:
```
playerphysics.add_physics_factor(player, "jump", "exhausted", 0.75)
```

Electrocution mod:
```
playerphysics.add_physics_factor(player, "jump", "shocked", 0.9)
```

When the 3 mods have done their change, the real player speed is simply the product of all factors, that is:

2 * 0.75 * 0.9 = 1.35

The final player speed is thus 135%.

### Speed changes, part 2

Let's take the example above.
Now if the Electrocution mod is done with shocking the player, it just needs to call:

```
playerphysics.remove_physics_factor(player, "jump", "shocked")
```

The effect is now gone, so the new player speed will be:

2 * 0.75 = 1.5

### Sleeping
To simulate sleeping by preventing all player movement, this can be done with this easy trick:

```
playerphysics.add_physics_factor(player, "speed", "sleeping", 0)
playerphysics.add_physics_factor(player, "jump", "sleeping", 0)
```

This works regardless of the other factors because 0 times anything equals 0.





## License
This mod is free software, released under the MIT License.
