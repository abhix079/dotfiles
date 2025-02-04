sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches

sudo pacman -Rns $(pacman -Qdtq) --noconfirm

sudo paccache -r

sudo rm -rf ~/.cache/*
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

sudo journalctl --vacuum-time=7d

rm -rf ~/.cache/mozilla/firefox/*

sudo sync; sudo sysctl -w vm.drop_caches=3
free -h

sudo pacman -Rns $(pacman -Qdtq)
sudo paccache -r

sudo rm -rf ~/.cache/*
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Google Chrome cache cleanup
rm -rf ~/.cache/google-chrome-stable
rm -rf ~/.config/google-chrome/Default/GPUCache
rm -rf ~/.config/google-chrome/Default/Cache
rm -rf ~/.config/google-chrome/Default/Media\ Cache

# Remove extension cache and service worker data
rm -rf ~/.config/google-chrome/Default/Service\ Worker/*
rm -rf ~/.config/google-chrome/Default/Service\ Worker/CacheStorage/*
rm -rf ~/.config/google-chrome/Default/WebStorage/*

# Cleanup Chromium cache if exists
if [ -d "$HOME/.cache/chromium" ]; then
  rm -rf "$HOME/.cache/chromium"/*
fi

# General cleanup
rm -rf ~/.cache/*

# System logs cleanup
sudo journalctl --vacuum-time=2weeks
#for vs code and discord
# Remove VS Code cache and logs (safe to delete while running)
rm -rf ~/.config/Code/Cache/*
rm -rf ~/.config/Code/CachedData/*
rm -rf ~/.config/Code/logs/*
rm -rf ~/.config/Code/Service Worker/CacheStorage/*
rm -rf ~/.config/Code/User/workspaceStorage/*

# Remove VS Code extensions cache (safe to delete while running)
rm -rf ~/.vscode/extensions/*

# Remove Discord cache and temporary files (safe to delete while running)
rm -rf ~/.config/discord/Cache/*
rm -rf ~/.config/discord/Code Cache/*
rm -rf ~/.config/discord/GPUCache/*
rm -rf ~/.config/discord/logs/*
rm -rf ~/.config/discord/tmp/*

# Remove system-wide temporary files
rm -rf /tmp/*
rm -rf ~/.cache/*

echo "Cleanup complete."

