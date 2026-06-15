# 9router-custom

Patches untuk 9router — GitLab OAuth + MiMo Code Free.

## MiMo Code Free

Provider built-in di 9router. Tambah alias di DB:

```sql
INSERT INTO kv (scope, key, value) VALUES ('modelAliases', 'mimo-auto', '"mmf/mimo-auto"');
```

Model: `mimo-auto` (Xiaomi MiMo V2.5 Pro, 1T MoE)

- Free tier, no auth
- Context: ~1M tokens
- Hanya `mimo-auto` yang support di free

## GitLab OAuth

Tambah `"gitlab"` ke `OAUTH_PROVIDERS` di `src/cli/menus/providers.js`.

## DB Setup

```sql
-- MiMo alias
INSERT INTO kv (scope, key, value) VALUES ('modelAliases', 'mimo-auto', '"mmf/mimo-auto"');

-- Combo models
UPDATE combos SET models = '["Nara/deepseek-v4-pro","N/nr/claude-sonnet-4.5","mmf/mimo-auto"]' WHERE name='Combo';
```

## Error: "No active credentials for provider: XXXX"

Provider node palsu dihapus dari DB. Hapus MiMo provider node dari `providerNodes` table.
