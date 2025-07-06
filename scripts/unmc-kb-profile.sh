# Set Hyprland layout (US/RU + Caps=Esc)
hyprctl keyword input:kb_options "grp:alt_shift_toggle,caps:escape"

# Disable Tab/P swap in keyd
sudo sed -i '/^tab = p/d; /^p = tab/d' /etc/keyd/default.conf
sudo systemctl restart keyd

