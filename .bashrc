# ===================================================================
#  .bashrc PERSONALIZADO PARA PROXMOX VE
#  Estilo: Powerlevel10k con colores oficiales Proxmox
#  Idioma: Español (comandos y alias)
# ===================================================================

############################
# 💡 ALIAS PERSONALES
############################
alias cls='clear'
alias revote='source ~/.bashrc'
alias perfil='nano /root/.bashrc'
alias apagar='poweroff'
alias reiniciar='reboot now'

############################
# ⚙️ FUNCIONES PARA EL PROMPT
############################
_get_proxmox_version() {
    if command -v pveversion >/dev/null 2>&1; then
        pveversion | head -n1 | awk -F'/' '{print $2}' | awk '{print $1}'
    elif [ -f /etc/pve/.version ]; then
        cat /etc/pve/.version | tr -d ' \n'
    else
        echo "N/A"
    fi
}

_get_lan_ip() {
    ip route get 8.8.8.8 2>/dev/null | sed -n 's/.*src \([0-9.]\+\).*/\1/p' | head -n1
}

_update_prompt_vars() {
    PVE_VER=$(_get_proxmox_version)
    PROMPT_IP=$(_get_lan_ip)
    PROMPT_DATE=$(date '+%Y-%m-%d')
    PROMPT_TIME=$(date '+%I:%M:%S %p')
}

PROMPT_COMMAND='_update_prompt_vars'

############################
# 🎨 COLORES (ESQUEMA PROXMOX)
############################
ORANGE="\[\e[38;5;208m\]"   # Naranja Proxmox
WHITE="\[\e[1;37m\]"
GRAY="\[\e[0;37m\]"
BLUE="\[\e[1;34m\]"
CYAN="\[\e[1;36m\]"
GREEN="\[\e[1;32m\]"
RED="\[\e[1;31m\]"
RESET="\[\e[0m\]"

############################
# 💻 PROMPT PERSONALIZADO
############################
PS1="\n${ORANGE}╭─${WHITE}{${ORANGE} PROXMOX:${GRAY}\${PVE_VER}${WHITE} }${ORANGE}--"\
"${WHITE}{${CYAN}\u${WHITE}@${CYAN}\h${WHITE}}${ORANGE}--"\
"${WHITE}{${GREEN}\w${WHITE}}${ORANGE}--"\
"${WHITE}{${CYAN}\${PROMPT_IP}${WHITE}}${ORANGE}--"\
"${WHITE}{${GRAY}\${PROMPT_DATE} \${PROMPT_TIME}${WHITE}}\n"\
"${ORANGE}╰─>${RESET}> "

############################
# 🧠 ALIAS ÚTILES EN ESPAÑOL
############################
alias recargar='source ~/.bashrc'
alias editarbash='nano ~/.bashrc'
alias actualizar='apt update && apt full-upgrade -y && apt autoremove -y'
alias limpiar='apt clean && apt autoclean && apt autoremove -y'
alias version='pveversion'
alias kernel='uname -r'
alias info='neofetch || hostnamectl'
alias fecha='date "+%Y-%m-%d %I:%M:%S %p"'
alias tiempo='uptime -p'
alias buscar='apt search'
alias instalar='apt install'
alias borrar='apt remove'
alias limpiar_cache='sync &B& echo 3 > /proc/sys/vm/drop_caches'
alias usuario_actual='whoami'

alias vmlist='qm list'
alias lxc_listar='pct list'
alias iniciar_vm='qm start'
alias detener_vm='qm stop'
alias reiniciar_vm='qm reboot'
alias eliminar_vm='qm destroy'
alias iniciar_ct='pct start'
alias detener_ct='pct stop'
alias reiniciar_ct='pct reboot'
alias eliminar_ct='pct destroy'
alias consola_vm='qm terminal'
alias consola_ct='pct attach'
alias backup_vm='vzdump --dumpdir /mnt/datos/backups --compress zstd'
alias restaurar_vm='qmrestore'
alias migrar_vm='qm migrate'
alias info_vm='qm config'
alias info_ct='pct config'
alias crear_vm='qm create'
alias crear_ct='pct create'
alias snapshot_vm='qm snapshot'
alias snapshot_ct='pct snapshot'
alias eliminar_snapshot_vm='qm delsnapshot'
alias eliminar_snapshot_ct='pct delsnapshot'

alias mi_ip='hostname -I | awk "{print \$1}"'
alias red_ip='ip -4 addr show'
alias puertos='ss -tuln'
alias conexiones='ss -tunap'
alias tabla_rutas='ip route show'
alias dns='cat /etc/resolv.conf'
alias reiniciar_red='systemctl restart networking'
alias prueba_ping='ping -c 4 8.8.8.8'
alias escanear_red='nmap -sn 192.168.1.0/24'
alias interfaz_red='ip link show'
alias cortar_red='ifconfig eth0 down'
alias activar_red='ifconfig eth0 up'

alias discos='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL'
alias espacio='df -hT --total'
alias uso_disco='du -h --max-depth=1'
alias montaje='mount | column -t'
alias desmontar='umount'
alias discos_usb='lsblk -S'
alias salud_disco='smartctl -H /dev/sd* 2>/dev/null | grep "SMART overall-health"'
alias temperatura_disco='hddtemp /dev/sd* 2>/dev/null'
alias ver_zfs='zpool status && zfs list'
alias limpiar_snapshots='zfs list -t snapshot && echo "Ejemplo: zfs destroy nombre@snapshot"'

alias usuarios='cut -d: -f1 /etc/passwd'
alias grupos='cut -d: -f1 /etc/group'
alias logins='last -a | head'
alias fallos_login='grep "Failed password" /var/log/auth.log'
alias ssh_reiniciar='systemctl restart ssh'
alias ssh_estado='systemctl status ssh'
alias permisos='ls -lah'
alias firewall_estado='pve-firewall status'
alias firewall_reiniciar='pve-firewall restart'
alias firewall_log='journalctl -u pve-firewall --since "1 hour ago"'

alias backup_config='tar czvf /mnt/datos/backup-config-$(date +%F).tar.gz /etc/pve /etc/network /etc/hosts'
alias listar_backups='ls -lh /mnt/datos/backups'
alias restaurar_config='tar xzvf /mnt/datos/backup-config*.tar.gz -C /'
alias verificar_backup='vzdump --dry-run'
alias backup_lxc='vzdump --mode snapshot --compress zstd --all 1 --dumpdir /mnt/datos/backups'

alias uso_cpu='top -n 1 | grep "Cpu(s)"'
alias uso_memoria='free -h'
alias top_procesos='ps aux --sort=-%mem | head -15'
alias ver_log='tail -f /var/log/syslog'
alias log_pve='journalctl -u pvedaemon -u pveproxy -u pve-cluster -n 50'
alias log_kernel='dmesg | tail -30'
alias monitoreo='htop || top'
alias estado_servicios='systemctl list-units --type=service --state=running'

alias copiar='cp -v'
alias mover='mv -v'
alias eliminar='rm -iv'
alias crear='mkdir -p'
alias editar='nano'
alias ver='cat'
alias buscar_texto='grep -Ri'
alias hora='date "+%I:%M:%S %p"'
alias ruta='pwd'
alias salir='exit'

############################
# ⚙️ CONFIGURACIONES EXTRA
############################
HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
export EDITOR=nano

# Locales configuradas correctamente
export LANG=es_NI.UTF-8
export LANGUAGE=es_NI.UTF-8

if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# ===================================================================
#   FIN DEL ARCHIVO PERSONALIZADO
# ===================================================================
