# Hades _"RoomSecretIndicator"_ Mod
## _A mod for lazy and forgettable people... like me_

I often have that moment where I leave a room and see a chaos gate _just_ as I'm walking through the door. Or maybe, I completely miss a fishing point during combat and didn't hear the _ping_ afterwards because I was playing on low sound. **To fix this, this mod simply shows you the secrets of a room as a text popup before you leave and forget them again.** It can also show you the rewards contained in an Infernal Trove so you waste less time.

![Test](https://i.imgur.com/ozUY0Hz.jpg)


## Secrets shown are:

- Fishing Points
- Infernal Troves
- Well of Charon Shops
- Selling Trait Shops
- Chaos Gates
- Erebus Gates

Because showing the reward type of the Infernal Trove before you actually walk over to them could be considered a _"cheat"_, you have to manually enable that feature in the config. There, you can also disable showing certain secrets if you prefer. These are the options you can control within the config:
```lua
local config = {
    showGates = true,
    showFishingPoint = true,
    showInfernalTrove = true,
    revealTroveReward = false,
    showWellShop = true,
    showSellShop = true,
}
```

The config is located right at the top of the `RoomSecretIndicator.lua` script.

This project is always up-to-date on the GitHub: https://github.com/DeepQuantum/HadesRoomEventIndicatorMod

This mod requires [__ModImporter__](https://github.com/SGG-Modding/sgg-mod-modimporter) and [__ModUtil__](https://www.nexusmods.com/hades/mods/27).

If you have any bug reports or questions, please message me on my discord: __DeepQuantum#3603__
