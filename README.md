# The Chocolate Stuff Mod

[![ContentDB](https://content.minetest.net/packages/lazerbeak12345/chocolatestuff/shields/downloads/)](https://content.minetest.net/packages/lazerbeak12345/chocolatestuff/)

Adds edible chocolate armor and tools. Pairs well with
[the edible swords mod][the_edible_swords_mod].

When equipped, the player will eat some of their chocolate armor if their
saturation (or health in absence of a hunger mod) is below 85%. This reduces the
durability of a random armor piece.

[the_edible_swords_mod]: https://content.minetest.net/packages/GamingAssociation39/edible_swords/

## Requires

- MineTest <!--TODO what version?-->
- [Farming redo](https://content.minetest.net/packages/TenPlus1/farming/)
	- Alternativly [mtfoods](https://forum.minetest.net/viewtopic.php?f=9&t=10187) should work.
- `instant_ores`
- [`ediblestuff_api`](https://github.com/Lazerbeak12345/ediblestuff_api)

### A note about "moarmor"

Shortly after doing everything short of hitting the "publish" button on
contentdb, I discoverd that the mod moarmor has chocolate armor already. My
compromise is thus:

1. This mod will still register the chocolate armor exactly as before if moarmor
is absent.
2. If present, this mod will alias to moarmor in such a manner as to prefer
moarmor for stats, sounds and textures.
3. This mod will register _only_ the chocolate armor in the ediblestuff_api as
it does its own chocolate armor - using the same saturation values.

> I won't be registering the other "food armor" as edible - even though I
> could - because it feels out-of-scope of this mod.

This means that if both this and moarmor are present you get:

- All of the chocolate tools
- Slightly different armor balancing.
- Better armor textures.
- Better armor sounds.
- You can eat the armor, even while wearing it. (you can't do either with
theirs)

## TODO

- [ ] Upstream better toolranks integration.
  - [x] PR made [pr here](https://notabug.org/Piezo_/instant_ores/pulls/1)
  - [ ] PR accepted
- [ ] Upstream better pick_axe_tweaks integration.
  - [x] PR made [pr here](https://notabug.org/Piezo_/instant_ores/pulls/3)
  - [ ] PR accepted
- [ ] Upstream better handholds_redo integration.
  - [x] PR made [pr_here](https://notabug.org/Piezo_/instant_ores/pulls/4)
  - [ ] PR accepted
- [ ] Upstream support for MineClone2 as base game
  - [x] PR made [pr here](https://notabug.org/Piezo_/instant_ores/pulls/5)
  - [ ] PR accepted
- [ ] Upstream complete custom textures in instant_ores
- [ ] Upstream better item metadata to be found with other armor and tools.
- [ ] better sounds
- [ ] better textures
- [ ] Settings?

## Legal

Copyright 2021-2 Lazerbeak12345

### Credit

- The YourLand players for a bunch of questionable ideas for this questionable mod. Original idea was from "Bla."
- The creator of [the obsidianstuff redo mod](https://github.com/OgelGames/obsidianstuff). This takes inspiration from that repo.
- The creator of [the edible swords mod][the_edible_swords_mod]. I took inspiration from this repo as well.

### Licence

Due to the dependancy on instant_ores, this mod _must_ be gpl 3 or later compatible. Thus, this mod is under GPL 3.0 or later.
