# The Chocolate Stuff Mod

Adds edible chocolate armor and tools. Pairs well with [the edible swords mod][the_edible_swords_mod].

[the_edible_swords_mod]: https://content.minetest.net/packages/GamingAssociation39/edible_swords/

## Requires

- MineTest <!--TODO what version?-->
- [Farming redo](https://content.minetest.net/packages/TenPlus1/farming/)
- `instant_ores`

## TODO

- [ ] Upstream better toolranks integration.
- [ ] Upstream better pick_axe_tweaks integration.
- [ ] Upstream better handholds_redo integration https://content.minetest.net/packages/TestificateMods/handholds_redo/
- [ ] Upstream complete custom textures in instant_ores
- [ ] Upstream better item metadata to be found with other armor and tools.
	- This is actually just a need for better 3d_armor integration
- [ ] make a way to actually use the tool (shift? no shift?)
  - Doesn't seem possible. Can't tell MT engine to eat the tool but not use tool (except hoe, which is a type defined in farming)
- [ ] Update readme
- [ ] delete functions after mods loaded (using event - not timer)
- [ ] better sounds
- [ ] better textures
- [ ] Settings?

## Legal

Copyright 2021 Lazerbeak12345

### Credit

- The YourLand players for a bunch of questionable ideas for this questionable mod. Original idea was from "Bla."
- The creator of [the obsidianstuff redo mod](https://github.com/OgelGames/obsidianstuff). This takes inspiration from that repo.
- The creator [the edible swords mod][the_edible_swords_mod]. I took inspiration from this repo as well.

### Licence

Due to the dependancy on instant_ores, this mod _must_ be gpl 3 or later compatible. Thus, this mod is under GPL 3.0 or later.
