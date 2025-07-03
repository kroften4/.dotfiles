# Set Hyprland layout (US/RU + normal CapsLock)
hyprctl keyword input:kb_options "grp:alt_shift_toggle"

# Enable Tab/P swap in keyd
sudo sed -i '/^\[main\]/a tab = p\np = tab' /etc/keyd/default.conf
sudo systemctl restart keyd

