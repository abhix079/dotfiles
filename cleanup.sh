#!/bin/bash

echo "🔄 Starting deep system cleanup and optimization for Arch + Hyprland..."


echo "🧠 Cleaning RAM..."
sudo sync
echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
sudo sysctl -w vm.drop_caches=3 > /dev/null
echo "✅ RAM caches dropped."


echo "📦 Removing orphaned packages and old package cache..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm 2>/dev/null
sudo paccache -rk1
echo "✅ Package cleanup done."


echo "🗑️ Cleaning user & system caches..."
rm -rf ~/.cache/*
rm -rf ~/.config/*/*Cache*
rm -rf ~/.local/share/Trash/*
rm -rf /tmp/*
sudo rm -rf /var/tmp/*
echo "✅ Cache and temp files removed."

# 🌐 Browser specific cleanup
echo "🌐 Cleaning Chrome/Chromium cache..."
rm -rf ~/.config/google-chrome*/Default/{Cache,Media\ Cache,GPUCache,Service\ Worker,WebStorage}
rm -rf ~/.cache/chromium/* 2>/dev/null
echo "✅ Chrome/Chromium cleanup done."

echo "🦊 Cleaning Firefox cache..."
rm -rf ~/.cache/mozilla/firefox/*
echo "✅ Firefox cache removed."

# 🧾 Clean journal logs
echo "🧾 Vacuuming journal logs..."
sudo journalctl --vacuum-time=2weeks
echo "✅ Logs cleaned."

# 💀 Kill zombie or defunct processes
echo "💀 Killing zombie processes..."
ps -A -ostat,ppid | grep -e '[zZ]' | awk '{ print $2 }' | xargs -r kill -9
echo "✅ Zombie processes killed."

# 🔊 Restart pipewire (audio) and other services
echo "🔊 Restarting audio and media services..."
systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service
echo "✅ Media services restarted."

# ⚙️ SSD optimization (TRIM)
echo "💽 Trimming SSD (if applicable)..."
sudo fstrim -v /
echo "✅ SSD trimmed."

# 🧠 Reduce swappiness for better RAM usage
echo "🔧 Setting vm.swappiness to 10..."
echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-swappiness.conf
sudo sysctl -p /etc/sysctl.d/99-swappiness.conf
echo "✅ Swappiness reduced."

# 🎨 Rebuild icon & font cache
echo "🎨 Rebuilding icon and font cache..."
sudo fc-cache -fv > /dev/null
sudo gtk-update-icon-cache /usr/share/icons/* -f -t 2>/dev/null
echo "✅ Icon & font cache rebuilt."

# 🎯 Remove Flatpak junk (if using Flatpak)
if command -v flatpak &> /dev/null; then
  echo "🧽 Removing unused Flatpak data..."
  flatpak uninstall --unused -y
  echo "✅ Flatpak cleanup complete."
fi

# ✅ Final status
echo ""
echo "🎉 Cleanup and performance boost complete!"
echo "📊 Disk usage after cleanup:"
df -h
echo ""
echo "📈 Memory status:"
free -h
