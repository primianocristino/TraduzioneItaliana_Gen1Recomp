# pokemon_red_italiano

A Italiano translation of the game.

Generated with `python3 tools/modkit.py translation pokemon_red_italiano`. See
`TRANSLATING.md` for how to work on it.

## Status

Nothing is translated yet: 3656 strings are waiting in `lang/`.

| Catalog | Entries |
|---|---|
| `lang/dialogue.lua` | 2581 |
| `lang/strings.lua` | 555 |
| `lang/species_names.lua` | 151 |
| `lang/move_names.lua` | 165 |
| `lang/item_names.lua` | 152 |
| `lang/trainer_names.lua` | 47 |
| `lang/status_labels.lua` | 5 |

## Layout

- `manifest.json` - identity and the engine version range
- `main.lua` - registers whatever is filled in and skips whatever is not
- `lang/` - the catalogs; this is the whole job
- `assets/font/` - your glyph sheet
