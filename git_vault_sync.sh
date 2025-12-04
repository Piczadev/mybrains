# ----------------------------------------------------
# Script de Sincronización Rápida para Obsidian Vault
# ----------------------------------------------------

# Ruta de la Vault
VAULT_PATH="/Users/piczadev/thinkvault"

# Navegar a la Vault
if [ ! -d "$VAULT_PATH/.git" ]; then
    echo "🚨 Error: El directorio de la Vault o el repositorio Git no se encuentra en $VAULT_PATH"
    exit 1
fi
cd "$VAULT_PATH"

# Obtener la fecha y hora actual para el mensaje del commit
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Mensaje de commit predeterminado
COMMIT_MESSAGE="chore: Vault autosync @ $TIMESTAMP"

echo "🤖 Sincronizando Vault: $(basename "$VAULT_PATH")..."

# 1. Añadir todos los cambios
git add .
echo "✅ Todos los cambios añadidos."

# 2. Hacer commit
# Se utiliza '|| true' para evitar que el script falle si no hay nada que commitear
git commit -m "$COMMIT_MESSAGE" || true
echo "✅ Commit creado (si hubo cambios)."

# 3. Subir los cambios (asumiendo que 'origin' y 'main' ya están configurados)
# Si tu rama inicial es 'master' (como el hint lo indicó), usa 'git push origin master'
# Por seguridad, usaremos la rama actual
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "☁️ Subiendo cambios a 'origin/$BRANCH_NAME'..."

git push origin $BRANCH_NAME

if [ $? -eq 0 ]; then
    echo "🎉 Sincronización Git completa y exitosa."
else
    echo "❌ Error durante la sincronización (¿Repositorio remoto enlazado?)"
fi
