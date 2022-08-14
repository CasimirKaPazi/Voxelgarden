Voxelgarden 5.0.0
==================

A classic game for the Minetest engine, to explore, survive and build.

Compatible with most mods for Minetest Game.


Getting Started
---------------

Open your inventory and take a look at the **craftguide** in the top left.

You need to find crumbled stone to craft your first stone tools.


Contribute
----------

Issues use the system of:

    bugs >> cleanups >> features >> nice to haves

Which means bugs should be done first, then cleanups, than new features, than the things nice to have. Every issue should be labeled with one of those.

This has the downside of having only few features, but the upside of having a stable and mostly bug free base to work with and little maintenance. I prefer to have a few well done features working over many not working.

Bigger additions should work as a mod on their own. This allows easier testing, benefits a modular design and ensure that they can still be used as a mod if the feature does not get merged.


Goals/aesthetics/concept
------------------------

Voxelgarden is meant as a survival and building game, complete with all basic features one might expect. All storyline, lore and specialized behavior should be kept out of it. Eventually there might be a separate modpack for the story of Voxelgarden. Think of it as the physical world in which different cultures can life in different ages having different stories playing out.

It is meant to be compatible with mods written for Minetest Game and therefor includes a lot of content from MTG when several mods depend on it. Likewise VG is also meant as a basic platform for mods, but also as a complete game in itself.

The game should offer a continuous progression from "stone age" technology to basic machines. Further more complex technology is left to mods like mesecons.  
It takes the aesthetics that make Minetest different from "other open world voxel mining and crafting games" and maybe a romanticized retro gaming look.

What not to add:

* Anything that is just decoration. New content should always have a personality, some unique behavior and properties. There is no use in adding a new tree type if it only differs in shape and textures.
* Exploding complexity. Think about traffic regulations. They are a set of rules easy enough for a human to learn, but the code needed to run traffic lights exceeds the volume of traffic regulations by orders of magnitude. If we can build roads without traffic light, we should.
* Anything that is not easy to maintain. I personally can't Blender, and I don't care enough to learn. That's why there are only 2D entities.

Voxelgarden should be (in that order):

    a complete game >> easy to maintain >> compatible with minetest game


License of source code:
-----------------------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

http://www.gnu.org/licenses/lgpl-2.1.html

For every mod applies the original license. See list below.
All other media is licenced under Creative Commons BY-SA license.

beds (LGPL), bones (LGPL), bucket (LGPL), conifer (LGPL), creative (LGPL), default (LGPL), doors (LGPL), dye (LGPL), game_commands(MIT), farming (LGPL), fire (LGPL), flowers (LGPL), footsteps (LGPL), hunger (LGPL), inventory\_plus (GPL), mobs (MIT), mobs\_flat (LGPL), physics (LGPL), player_api (LGPL), playerphysics (MIT), sprint (CC0), stairs (LGPL), stairsplus (zlib/libpng), walls (LGPL) wool (LGPL), zcg (LGPL), xpanes (LGPL)

Mods equivalent to and mirroring Minetest Game:
binoculars (MIT), boats (MIT) (except burntime), carts (MIT), dungeon_loot (MIT), env_sounds (MIT), fireflies (MIT), map (MIT), screwdriver (LGPL) (except texture), tnt (MIT) (except textures), vessels (LGPL), weather (MIT)
