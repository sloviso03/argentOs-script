# argentOs-script

Script de post-instalación para dejar Debian configurado con sway como entorno de escritorio (window manager), con un set de configuraciones y aplicaciones predefinidas (alacritty, waybar, ranger, micro, fastfetch, entre otras).

---

## Español

### 1. Requisitos previos

- Un pendrive USB
- Descargar la imagen ISO de Debian desde https://www.debian.org/

### 2. Grabar la ISO en el pendrive

Grabar la ISO descargada en el pendrive usando la herramienta de tu preferencia (balenaEtcher, Rufus, dd, etc).

### 3. Instalación de Debian

Bootear desde el pendrive y seguir los pasos normales del instalador de Debian.

Cuando llegue el paso de selección de software (desktop environment), es importante:

1. Desmarcar todas las opciones que vienen tildadas por defecto (esto incluye GNOME y "Debian desktop environment").
2. Dejar marcadas únicamente estas dos opciones:
   - SSH server
   - Standard system utilities

Esto evita instalar un entorno gráfico que no se va a usar, ya que el entorno gráfico (sway) lo instala el script más adelante.

Continuar con la instalación hasta que finalice y reiniciar el equipo.

### 4. Primer arranque

Al reiniciar, vas a tener una terminal sin entorno gráfico. Seguir estos pasos:

```
# Iniciar sesión con el usuario creado durante la instalación
login: tu-usuario

# Pasar a usuario root
su -

# Instalar sudo y git
apt install sudo git

# Agregar tu usuario al grupo sudo
sudo usermod -aG sudo tu-usuario

# Salir de la sesión de root
exit

# Cerrar la sesión para que el cambio de grupo tome efecto
exit
```

### 5. Ejecutar el script

Iniciar sesión nuevamente con tu usuario y ejecutar:

```
git clone https://github.com/sloviso03/argentOs-script
cd argentOs-script
sudo chmod +x main.sh
./main.sh
```

El script va a instalar todas las dependencias necesarias y copiar las configuraciones a tu carpeta `~/.config`.

### 6. Iniciar sway

Una vez que la instalación termine, levantar la sesión gráfica escribiendo:

```
sway
```

---

### Estructura del script

```
argentOs-script/
├── main.sh
├── packages.sh
├── folders.sh
├── alacritty/
├── fastfetch/
├── sway/
├── waybar/
├── bash/
├── micro/
├── ranger/
└── wallpaper.png
```

**main.sh**
Es el punto de entrada del script. Imprime mensajes informativos por consola y llama, en orden, a `packages.sh` (instalación de paquetes) y `folders.sh` (copiado de configuraciones).

**packages.sh**
Instala con `apt` los paquetes necesarios para el entorno: sway, fuente JetBrains Mono, waybar, alacritty, herramientas de captura de pantalla (grim, slurp, swappy), fzf, wl-clipboard, ranger y udiskie/udisks2 (para el montaje automático de unidades).

**folders.sh**
Se encarga de copiar todas las configuraciones a las carpetas correspondientes dentro de `~/.config`:

- Copia la configuración de sway a `~/.config/sway`
- Copia la configuración de alacritty a `~/.config/alacritty`
- Genera la configuración de waybar reemplazando variables de entorno (como la zona horaria del sistema) con `envsubst`, y copia el archivo de estilos
- Copia la configuración de fastfetch
- Registra ranger como aplicación predeterminada para abrir directorios (`xdg-mime`)
- Reemplaza el `.bashrc` del usuario por el incluido en el repositorio
- Configura `micro` como editor de texto por defecto del sistema con `update-alternatives`
- Copia la configuración de micro a `~/.config/micro`

**sway/config**
Archivo de configuración de sway. Define variables (terminal, navegador, lanzador de aplicaciones, barra, gestor de archivos), atajos de teclado para abrir aplicaciones, controles de brillo y volumen, movimiento y manejo de ventanas, configuración de input (teclado en layout latam, touchpad), apariencia de bordes y gaps, y la barra (waybar).

**waybar/config.jsonc**
Configuración de la barra superior (waybar). Define los módulos que se muestran: menú de energía, espacios de trabajo, reloj, red, audio (pulseaudio), brillo, batería y perfil de energía.

**alacritty/**, **fastfetch/**, **micro/**, **ranger/**
Carpetas con archivos de configuración propios de cada aplicación, que se copian tal cual a sus respectivas ubicaciones en `~/.config` (o `~/.local/share/applications` en el caso de ranger).

**wallpaper.png**
Imagen de fondo de pantalla, usada por sway al iniciar sesión (`swaybg`).

---

## English

### 1. Prerequisites

- A USB pendrive
- Download the Debian ISO image from https://www.debian.org/

### 2. Flash the ISO to the pendrive

Flash the downloaded ISO to the pendrive using the tool of your choice (balenaEtcher, Rufus, dd, etc).

### 3. Installing Debian

Boot from the pendrive and follow the regular Debian installer steps.

When you reach the software selection step (desktop environment), it is important to:

1. Uncheck every option that comes checked by default (this includes GNOME and "Debian desktop environment").
2. Leave only these two options checked:
   - SSH server
   - Standard system utilities

This avoids installing a graphical environment that won't be used, since the graphical environment (sway) is installed later by the script.

Continue the installation until it finishes and reboot the machine.

### 4. First boot

After rebooting, you will land on a terminal with no graphical environment. Follow these steps:

```
# Log in with the user created during installation
login: your-username

# Switch to the root user
su -

# Install sudo and git
apt install sudo git

# Add your user to the sudo group
sudo usermod -aG sudo your-username

# Exit the root session
exit

# Log out so the group change takes effect
exit
```

### 5. Run the script

Log in again with your user and run:

```
git clone https://github.com/sloviso03/argentOs-script
cd argentOs-script
sudo chmod +x main.sh
./main.sh
```

The script will install all the required dependencies and copy the configuration files into your `~/.config` folder.

### 6. Start sway

Once the installation finishes, start the graphical session by typing:

```
sway
```

---

### Script structure

```
argentOs-script/
├── main.sh
├── packages.sh
├── folders.sh
├── alacritty/
├── fastfetch/
├── sway/
├── waybar/
├── bash/
├── micro/
├── ranger/
└── wallpaper.png
```

**main.sh**
Entry point of the script. Prints informational messages to the console and calls, in order, `packages.sh` (package installation) and `folders.sh` (configuration copying).

**packages.sh**
Installs the required packages for the environment with `apt`: sway, the JetBrains Mono font, waybar, alacritty, screenshot tools (grim, slurp, swappy), fzf, wl-clipboard, ranger and udiskie/udisks2 (for automatic drive mounting).

**folders.sh**
Handles copying all configuration files into the corresponding folders under `~/.config`:

- Copies the sway configuration to `~/.config/sway`
- Copies the alacritty configuration to `~/.config/alacritty`
- Generates the waybar configuration by substituting environment variables (such as the system timezone) with `envsubst`, and copies the stylesheet
- Copies the fastfetch configuration
- Registers ranger as the default application for opening directories (`xdg-mime`)
- Replaces the user's `.bashrc` with the one included in the repository
- Sets `micro` as the system's default text editor via `update-alternatives`
- Copies the micro configuration to `~/.config/micro`

**sway/config**
Sway's configuration file. Defines variables (terminal, browser, application launcher, bar, file manager), keybindings to launch applications, brightness and volume controls, window movement and handling, input configuration (latam keyboard layout, touchpad), border and gap appearance, and the bar (waybar).

**waybar/config.jsonc**
Configuration for the top bar (waybar). Defines the modules shown: power menu, workspaces, clock, network, audio (pulseaudio), backlight, battery and power profile.

**alacritty/**, **fastfetch/**, **micro/**, **ranger/**
Folders containing each application's own configuration files, copied as-is to their respective locations under `~/.config` (or `~/.local/share/applications` in the case of ranger).

**wallpaper.png**
Wallpaper image, used by sway on session start (`swaybg`).
