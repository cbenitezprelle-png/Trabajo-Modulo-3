# Guía: Cómo Clonar un Repositorio y Subir Cambios a GitHub

## 1. Requisitos Previos

- Tener Git instalado en tu máquina ([Descargar Git](https://git-scm.com/))
- Una cuenta de GitHub activa
- Acceso de escritura al repositorio

## 2. Clonar un Repositorio

### Paso 1: Obtener la URL del repositorio
1. Accede a [GitHub](https://github.com/)
2. Dirígete al repositorio que deseas clonar
3. Haz clic en el botón verde **"Code"**
4. Copia la URL (HTTPS o SSH)

### Paso 2: Abrir terminal/CMD
- **Windows**: Abre PowerShell o CMD
- **Mac/Linux**: Abre Terminal

### Paso 3: Ejecutar el comando de clonación

```bash
git clone https://github.com/usuario/nombre-repo.git
```

### Paso 4: Acceder a la carpeta
```bash
cd nombre-repo
```

## 3. Subir Cambios a GitHub

### Paso 1: Verificar el estado
```bash
git status
```

### Paso 2: Agregar archivos
Para agregar un archivo específico:
```bash
git add nombre-archivo.sql
```

Para agregar todos los cambios:
```bash
git add .
```

### Paso 3: Crear un commit
```bash
git commit -m "Descripción breve de los cambios"
```

**Ejemplos de mensajes útiles:**
- `git commit -m "Agregar script SQL del módulo 3"`
- `git commit -m "Actualizar documentación"`
- `git commit -m "Añadir archivos iniciales"`

### Paso 4: Subir los cambios (Push)
```bash
git push origin main
```

*Nota: Si usa rama diferente, reemplace `main` por el nombre de su rama*

## 4. Configuración Inicial (si es la primera vez)

Si es la primera vez usando Git, configure sus datos:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu-email@ejemplo.com"
```

## 5. Flujo Completo de Trabajo

```bash
# 1. Clonar el repositorio
git clone https://github.com/usuario/nombre-repo.git

# 2. Entrar en la carpeta
cd nombre-repo

# 3. Hacer cambios en los archivos...

# 4. Ver los cambios
git status

# 5. Agregar cambios
git add .

# 6. Crear commit
git commit -m "Descripción de cambios"

# 7. Subir a GitHub
git push origin main
```

## 6. Comandos Útiles Adicionales

| Comando | Descripción |
|---------|-------------|
| `git log` | Ver historial de commits |
| `git pull origin main` | Descargar cambios del repositorio remoto |
| `git branch` | Ver ramas disponibles |
| `git checkout -b nueva-rama` | Crear una nueva rama |
| `git diff` | Ver diferencias en los archivos |

## 7. Solución de Problemas

### Error: "Permission denied"
**Solución**: Verifica que tengas acceso al repositorio o usa SSH en lugar de HTTPS

### Error: "fatal: Not a git repository"
**Solución**: Asegúrate de estar dentro de la carpeta del repositorio clonado

### Error: "Your branch is behind"
**Solución**: Ejecuta `git pull origin main` para actualizar tu rama local

## 8. Mejores Prácticas

✅ **Haz commits frecuentes** - Con cambios pequeños y bien descritos
✅ **Escribe mensajes claros** - Que describan qué cambios se hicieron
✅ **Actualiza antes de trabajar** - Ejecuta `git pull` al empezar
✅ **Revisa los cambios** - Usa `git status` antes de hacer commit
✅ **Usa ramas** - Para features o fixes importantes

---

**¿Necesitas ayuda?** Consulta la [documentación oficial de Git](https://git-scm.com/doc)
