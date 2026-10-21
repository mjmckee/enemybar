# enemybar

An addon for Windower 4 (FFXI) that draws a big, easy-to-see health bar for your target, plus a smaller bar for your sub-target.

## Features

- **Target bar:** a wide bar at the top of the screen showing the target's name and HP%. While you are in combat, a lighter trailing segment slowly shrinks to show recent damage.
- **Sub-target bar:** a smaller blue bar under the target bar that shows the sub-target's name and HP. It only appears when the sub-target is a different mob than your target.
- **Claim colors:** the name changes color so you can tell at a glance who owns a mob.
- **Drag to move:** click and drag any part of either bar to move the whole thing. The new position is saved when you let go. Clicks on the bars don't reach the game, and the bars are only visible (and draggable) while you have a target.
- Both bars hide automatically when you have no target.

## Name colors

| Color  | Meaning                                                            |
|--------|--------------------------------------------------------------------|
| Yellow | Unclaimed mob                                                      |
| Pink   | Claimed by you, your party, or your alliance                       |
| Purple | Claimed by someone outside your party and alliance                 |
| Cyan   | A party member (other than you)                                    |
| White  | A player character                                                 |
| Gray   | The target is dead (0% HP)                                         |

## Installation

1. Download the latest `enemybar-vX.Y.Z.zip` from the [Releases](../../releases) page.
2. Unzip it so the folder ends up at `Windower4/addons/enemybar`. It should contain `enemybar.lua` and the `.png` files directly inside it.
3. In game, run `//lua load enemybar`.

To load it automatically at startup, add this line to `Windower4/scripts/init.txt`:

```
lua load enemybar
```

After updating the files, run `//lua reload enemybar` to pick up the changes.

## Settings

A settings file is created the first time the addon loads, at `Windower4/addons/enemybar/data/settings.xml`. Dragging the bars updates the position here for you. You can also edit it by hand, then reload the addon.

| Setting     | Default | Description                                                                 |
|-------------|---------|-----------------------------------------------------------------------------|
| `font`      | `Arial` | Font used for the names.                                                    |
| `font_size` | `14`    | Font size for the names.                                                    |
| `pos` `x`   | `400`   | Horizontal position of the bar. A negative value centers it on the screen.  |
| `pos` `y`   | `50`    | Vertical position of the bar. The sub-target bar sits 15 pixels below it.   |

The target bar is 598 pixels wide and the sub-target bar is 198 pixels wide. The sub-target bar lines up with the right end of the target bar.

## Files

| File               | Purpose                                                          |
|--------------------|------------------------------------------------------------------|
| `enemybar.lua`     | Addon entry point; registers the events.                         |
| `targetBar.lua`    | Draws and updates the target bar.                                |
| `subtargetBar.lua` | Draws and updates the sub-target bar.                            |
| `gui_settings.lua` | Bar sizes, positions, colors, settings loading and claim checks. |
| `drag.lua`         | Click-and-drag handling that moves both bars together.           |
| `*.png`            | Textures for the bar background, end caps and fill.              |

## License

See the license notice at the top of the source files.
