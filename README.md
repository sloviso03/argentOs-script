# argentOs-script

Script de post-instalación para dejar Fedora Server configurado con niri como entorno de escritorio (window manager), con un set de configuraciones y aplicaciones predefinidas (alacritty, waybar, micro, fastfetch, entre otras).

---

## Español

### 1. Requisitos previos

* Un pendrive USB
* Descargar la imagen ISO de Fedora Server desde [https://fedoraproject.org/server/download/](https://fedoraproject.org/server/download/)

### 2. Grabar la ISO en el pendrive

Grabar la ISO descargada en el pendrive usando la herramienta de tu preferencia (balenaEtcher, Rufus, dd, etc).

### 3. Instalación de Fedora Server

Bootear desde el pendrive y seguir los pasos normales del instalador de Fedora (Anaconda).

Cuando llegue el paso de selección de software (Software Selection), es importante:

1. Seleccionar la instalación base como "Fedora Server Edition".
2. No marcar ningún entorno de escritorio adicional en el panel derecho.

Esto evita instalar un entorno gráfico que no se va a usar, ya que el entorno gráfico (niri) lo instala el script más adelante.

Continuar con la instalación hasta que finalice y reiniciar el equipo.

### 4. Primer arranque

Al reiniciar, vas a tener una terminal sin entorno gráfico. Seguir estos pasos:

```
# Iniciar sesión con el usuario creado durante la instalación
login: tu-usuario
password: tu-password

# Instalar git
sudo dnf install git

```

### 5. Ejecutar el script

Ejecutar los siguientes comandos en la terminal:

```
git clone https://github.com/sloviso03/argentOs-script
cd argentOs-script
sudo chmod +x main.sh
./main.sh

```

El script va a instalar todas las dependencias necesarias y copiar las configuraciones a tu carpeta `~/.config`.

### 6. Iniciar niri

Una vez que la instalación termine, levantar la sesión gráfica escribiendo:

```
niri

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
├── niri/
├── waybar/
├── bash/
├── micro/
└── wallpaper.png

```

**main.sh**
Es el punto de entrada del script. Imprime mensajes informativos por consola y llama, en orden, a `packages.sh` (instalación de paquetes) y `folders.sh` (copiado de configuraciones).

**packages.sh**
Instala con `dnf` los paquetes necesarios para el entorno: niri, fuente JetBrains Mono, waybar, alacritty, herramientas de captura de pantalla (grim, slurp, swappy), fzf, wl-clipboard, thunar, swaybg y udiskie/udisks2 (para el montaje automático de unidades).

**folders.sh**
Se encarga de copiar todas las configuraciones a las carpetas correspondientes dentro de `~/.config`:

* Copia la configuración de niri a `~/.config/niri/config.kdl`
* Copia la configuración de alacritty a `~/.config/alacritty`
* Genera la configuración de waybar reemplazando variables de entorno (como la zona horaria del sistema) con `sed`, y copia el archivo de estilos
* Copia la configuración de fastfetch
* Registra thunar como aplicación predeterminada para abrir directorios (`xdg-mime`)
* Reemplaza el `.bashrc` del usuario por el incluido en el repositorio
* Copia la configuración de micro a `~/.config/micro`

**niri/config.kdl**
Archivo de configuración de niri. Define variables y atajos de teclado para abrir aplicaciones (terminal alacritty, navegador firefox, lanzador fuzzel, gestor de archivos thunar), controles de brillo y volumen, movimiento y manejo de ventanas en columnas infinitas, configuración de input (teclado en layout latam, touchpad) y la ejecución de servicios al inicio (waybar, swaybg, udiskie, kanshi).

**waybar/config.jsonc**
Configuración de la barra superior (waybar). Define los módulos que se muestran adaptados para niri: menú de energía, espacios de trabajo de niri, reloj, red, audio (pulseaudio), brillo, batería y perfil de energía.

**alacritty/**, **fastfetch/**, **micro/**
Carpetas con archivos de configuración propios de cada aplicación, que se copian tal cual a sus respectivas ubicaciones en `~/.config`.

**wallpaper.png**
Imagen de fondo de pantalla, usada por swaybg al iniciar sesión.

---

## English

### 1. Prerequisites

* A USB pendrive
* Download the Fedora Server ISO image from [https://fedoraproject.org/server/download/](https://fedoraproject.org/server/download/)

### 2. Flash the ISO to the pendrive

Flash the downloaded ISO to the pendrive using the tool of your choice (balenaEtcher, Rufus, dd, etc).

### 3. Installing Fedora Server

Boot from the pendrive and follow the regular Fedora installer (Anaconda) steps.

When you reach the software selection step, it is important to:

1. Select "Fedora Server Edition" as the base environment.
2. Do not check any additional desktop environments on the right-hand side panel.

This avoids installing a graphical environment that won't be used, since the graphical environment (niri) is installed later by the script.

Continue the installation until it finishes and reboot the machine.

### 4. First boot

After rebooting, you will land on a terminal with no graphical environment. Follow these steps:

```
# Log in with the user created during installation
login: your-username
password: your-password

# Install git
sudo dnf install git

```

### 5. Run the script

Run the following commands in your terminal:

```
git clone https://github.com/sloviso03/argentOs-script
cd argentOs-script
sudo chmod +x main.sh
./main.sh

```

The script will install all the required dependencies and copy the configuration files into your `~/.config` folder.

### 6. Start niri

Once the installation finishes, start the graphical session by typing:

```
niri

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
├── niri/
├── waybar/
├── bash/
├── micro/
└── wallpaper.png

```

**main.sh**
Entry point of the script. Prints informational messages to the console and calls, in order, `packages.sh` (package installation) and `folders.sh` (configuration copying).

**packages.sh**
Installs the required packages for the environment with `dnf`: niri, the JetBrains Mono font, waybar, alacritty, screenshot tools (grim, slurp, swappy), fzf, wl-clipboard, thunar, swaybg and udiskie/udisks2 (for automatic drive mounting).

**folders.sh**
Handles copying all configuration files into the corresponding folders under `~/.config`:

* Copies the niri configuration to `~/.config/niri/config.kdl`
* Copies the alacritty configuration to `~/.config/alacritty`
* Generates the waybar configuration by substituting environment variables (such as the system timezone) with `sed`, and copies the stylesheet
* Copies the fastfetch configuration
* Registers thunar as the default application for opening directories (`xdg-mime`)
* Replaces the user's `.bashrc` with the one included in the repository
* Copies the micro configuration to `~/.config/micro`

**niri/config.kdl**
Niri's configuration file. Defines variables and keybindings to launch applications (alacritty terminal, firefox browser, fuzzel launcher, thunar file manager), brightness and volume controls, window movement and handling across infinite columns, input configuration (latam keyboard layout, touchpad), and background services to spawn at startup (waybar, swaybg, udiskie, kanshi).

**waybar/config.jsonc**
Configuration for the top bar (waybar). Defines the modules shown adapted for niri: power menu, niri workspaces, clock, network, audio (pulseaudio), backlight, battery and power profile.

**alacritty/**, **fastfetch/**, **micro/**
Folders containing each application's own configuration files, copied as-is to their respective locations under `~/.config`.

**wallpaper.png**
Wallpaper image, used by swaybg on session start.
