### Basic Mechanics
Weapons have slots for projectiles and modifications, collectively called "chips". An empty weapon doesn't do anything, it must have at least one projectile chip slotted in. 

Weapons have limited slots, and a separate limit on the number of projectile chips that can be slotted in. The default pistol, for example, can has 3 slots and can only have one projectile chip.

When weapons are fired, they operate in 3 steps. The first step is just reading the leftmost enabled chip (and other slots if applicable). If the chip is a passive chip, it gets ignored. The second step is "staging" the read chip(s), which involves "disabling" the chip so it can't be reused until the weapon refreshes. The third step is activating all staged chips. Once the third step is finished, the weapon moves to the leftmost enabled chip and repeats the process.

Some chips are considered "passive". This means they apply effects to active chips. For example, a Damage Boost chip is passive, and would boost the damage of the closest Active chip to the right of it, which is normally a projectile chip. Generally, passive chips will apply their effect to the closest active chip to their right, though some may work on multiple or all active chips in the weapon.

### Multi-chips
Some mods will activate multiple chips at once. These chips are called "multis". We'll use a double chip as an example. When a double is activated, it reads the two chips to the right of it (skipping over passive chips), stages the chosen chips, and activates them simultaneously. The weapon then moves to the next unused chip as normal. If a multi-trigger activates another multi-trigger, the child multi will take its pick of chips, then it'll return to the parent multi and the parent will pick however many chips remain to fill its counter, counting the child multi as only one chip.

### Projectiles
Projectile chips will come in many variants. There will be two major classes: hitscan and physcial. Hitscan projectiles send out a raycast and immediately damage whatever is underneath the crosshair. Physical projectiles create an object with a hitbox and velocity.

### Weapon Attributes
Weapons each have their own built in attributes. All weapons have the following attributes: Damage, Slot Count, Projectile Limit, Reload Time, Cycles, and Fire Delay
- Damage: This is a flat number that is added to the damage of a projectile chip for the total damage.
- Slot Count: How many slots the weapon has for chips
- Projectile Limit: The maximum number of projectile chips that can be slotted into the weapon
- Reload Time: How long the weapon takes to reload. This may be modified by chips.
- Cycles: How many times the weapon will rotate through its chips before reloading (How many times it will make a full left-to-right read).
- Fire Delay: How long the weapon waits before activating the next chip. This is added to the delay of the chip previously activated, if it has one.

Notably, weapons themselves do not have an accuracy penalty. For the sake of faster and more precise gameplay, chips, especially ones that increase fire rate or shoot multiple projectiles, may have an accuracy penalty, but the majority of chips do not.