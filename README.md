# GENERAL
- All races all classes
- No more trainers. Spells get learned on level up
- Transmog system. NPC needs to be added all around the world, but for now he's in Stormwind near AH.

# CHAT
- World chat using `#w` in Chat - cross-faction btw

# BALANCING
- Raids/Dungeons balanced to player level/player count/player power
- LFG works solo
### CLASS SPECIFIC
- **DEATH KNIGHT**
    - Nathanos Blightcaller is taking increased damage, turning him into a solo-able encounter

# GEARING
- Basic starter gear command with `#starterGear classType weaponType`. Possible values:
	- for classType:
		- `empty`   (gives heirloom armors for current class) (`weaponType` empty)
		-	`physical` (needs to be paired with `weaponType`)
		-	`caster` (needs to be paired with `weaponType`)
		-	`trinkets` (needs no `weaponType`)
	- for weaponType:
		-	`physical`
		-	`caster`
		-	`ranged `(works only for `physical`)
Example (We're a lv1 Hunter):
- `#starterGear` - gives hunter armor heirlooms
- `#starterGear physical ranged` - gives ranged heirlooms
- `#starterGear trinkets` - gives trinkets
