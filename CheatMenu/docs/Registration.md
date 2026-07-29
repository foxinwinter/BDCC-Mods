# Mod Menu — Registration API

Any BDCC module can register content with the Mod Menu by placing config files in a `cheatMenu/` folder inside the module's directory. The Mod Menu auto-discovers them at startup — no imperative API calls needed.

## Directory Structure

```
ModuleName/
├── Module.gd
├── cheatMenu/
│   ├── mod_info.gd     # Display name & description (required)
│   ├── locations.gd    # Teleport rooms & aliases (optional)
│   └── items.gd        # Item category/subcategory registrations (optional)
```

## File Formats

### `cheatMenu/mod_info.gd`

```gdscript
static func get_mod_info():
    return {
        "mod_name": "My Mod Name",
        "description": "What this mod adds to the game",
    }
```

This is **required**. The Mod Menu uses `mod_name` as the display name in the Mods teleport list.

---

### `cheatMenu/locations.gd`

```gdscript
static func get_locations():
    return {
        "sub_area_name": "My Mod",
        "rooms": [
            "room_id_1",
            "room_id_2",
        ],
        "aliases": {
            "room_id_1": "Pretty Display Name",
            "room_id_2": "Another Name",
        },
    }
```

All registered rooms appear under **Teleport → Mods → [your sub_area_name]**.

| Field | Type | Description |
|-------|------|-------------|
| `sub_area_name` | String | Group name inside the Mods category |
| `rooms` | Array[String] | Room IDs to add |
| `aliases` | Dictionary | Optional display-name overrides (`roomID → "Name"`) |

---

### `cheatMenu/items.gd`

```gdscript
static func get_items():
    return {
        "Medical": {
            "My Subcategory": ["item_id_1", "item_id_2"],
        },
        "Generic": {
            "Another Sub": ["item_id_3"],
        },
    }
```

Each key is a top-level item category (`Medical`, `Generic`, `BDSM`, `Clothes`, etc.). The sub-dictionary maps subcategory names to arrays of item IDs.

If the category already exists in the Mod Menu, your subcategories are merged in (items are appended to matching subcategory names). If the category is new, it is created.

---

## Legacy API (Deprecated)

The following imperative methods still exist for backward compatibility but are no longer the recommended approach:

```gdscript
var cm = GlobalRegistry.getModule("CheatMenu")
if cm != null:
    cm.registerTeleportCategory("My Area", ["room_1", "room_2"])
    cm.registerRoomAlias("room_1", "Display Name")
```

New mods should use the `cheatMenu/` config-file approach instead.
