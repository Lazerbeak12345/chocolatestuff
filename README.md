# The Chocolate Stuff Mod

Adds edible chocolate armor and tools. Pairs well with
[the edible swords mod][the_edible_swords_mod].

When equipped, the player will eat some of their chocolate armor if their
saturation (or health in absence of a hunger mod) is below 85%. This reduces the
durability of a random armor piece.

[the_edible_swords_mod]: https://content.minetest.net/packages/GamingAssociation39/edible_swords/

## Requires

- MineTest <!--TODO what version?-->
- [Farming redo](https://content.minetest.net/packages/TenPlus1/farming/)
- `instant_ores`

## TODO

- [x] Upstream better toolranks integration. [pr here](https://notabug.org/Piezo_/instant_ores/pulls/1)
- [x] Upstream better pick_axe_tweaks integration. [pr here](https://notabug.org/Piezo_/instant_ores/pulls/3)
- [x] Upstream better handholds_redo integration. [pr_here](https://notabug.org/Piezo_/instant_ores/pulls/4)
- [ ] Upstream complete custom textures in instant_ores
- [ ] Upstream better item metadata to be found with other armor and tools.
- [ ] Upstream bug in 3d_armor with `get_weared_armor_elements`
- [ ] make a way to actually use the tool (shift? no shift?)
  - Doesn't seem possible. Can't tell MT engine to eat the tool but not use tool (except hoe, which is a type defined in farming)
- [ ] delete functions after mods loaded (using event - not timer)
- [ ] better sounds
- [ ] better textures
- [ ] Settings?

## Legal

Copyright 2021-2 Lazerbeak12345

### Credit

- The YourLand players for a bunch of questionable ideas for this questionable mod. Original idea was from "Bla."
- The creator of [the obsidianstuff redo mod](https://github.com/OgelGames/obsidianstuff). This takes inspiration from that repo.
- The creator [the edible swords mod][the_edible_swords_mod]. I took inspiration from this repo as well.

### Licence

Due to the dependancy on instant_ores, this mod _must_ be gpl 3 or later compatible. Thus, this mod is under GPL 3.0 or later.
