#!/bin/bash
# Apply 9router custom patches
# Run as root

set -e

ROUTER_DIR="/usr/lib/node_modules/9router"
DB_PATH="$HOME/.9router/db/data.sqlite"

echo "=== Applying 9router custom patches ==="

# 1. Add gitlab to CLI providers (if not present)
PROVIDERS_FILE="$ROUTER_DIR/src/cli/menus/providers.js"
if ! grep -q '"gitlab"' "$PROVIDERS_FILE" 2>/dev/null; then
    echo "Adding gitlab to CLI providers..."
    # This requires manual edit - see patch file
    echo "Manual edit needed: $PROVIDERS_FILE"
    echo 'Add "gitlab" to OAUTH_PROVIDERS array'
fi

# 2. Add MiMo alias to DB
echo "Adding MiMo alias to DB..."
sqlite3 "$DB_PATH" "INSERT OR IGNORE INTO kv (scope, key, value) VALUES ('modelAliases', 'mimo-auto', '\"mmf/mimo-auto\"');"

# 3. Verify
echo ""
echo "=== Verification ==="
echo "MiMo aliases:"
sqlite3 "$DB_PATH" "SELECT key, value FROM kv WHERE scope='modelAliases' AND key='mimo-auto';"

echo ""
echo "Provider nodes:"
sqlite3 "$DB_PATH" "SELECT name FROM providerNodes;"

echo ""
echo "Done! Restart 9router: systemctl restart 9router"
