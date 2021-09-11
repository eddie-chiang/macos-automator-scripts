# 1. Create an Automator Application.
# 2. Add an action "Run Shell Script" with /bin/zsh.
# 3. Paste the script below.
# 4. Save as an Application, e.g. RamDisk.app.
if [ ! -d "/Volumes/RamDisk" ]; then
	# NOTE: Using this method to create a RamDisk may have a problem with system hibernate.
	# Creating RamDisk, with a default size of 4GB (4 * 1024 * 1024 * 2).
	ramdisk_size=$((4*1024*1024*2))

	# If the memory size is greater than or equal to 32GB, then create a 16GB RamDisk.
	if [ $(sysctl -n hw.memsize) -ge $((32*1024*1024*1024)) ]; then
		ramdisk_size=$((16*1024*1024*2))
	fi

  	diskutil erasevolume HFS+ RamDisk `hdiutil attach -nomount ram://$ramdisk_size`

	cd "/Volumes/RamDisk"
	mkdir "Downloads"
	mkdir -p "Temp/Screenshots"
	mkdir -p "Library/Caches/Google/Chrome"
fi

# One off set up after the RamDisk has been created:
# 
# 1. Set up symbolic links.
# sudo rm -r ~/Downloads
# ln -s /Volumes/RamDisk/Downloads ~/Downloads
# sudo rm -r ~/Library/Caches/Google/Chrome
# ln -s /Volumes/RamDisk/Library/Caches/Google/Chrome/ ~/Library/Caches/Google/Chrome
#
# 2. Change screenshots default location.
# defaults write com.apple.screencapture location /Volumes/RamDisk/Temp/Screenshots
# killall SystemUIServer
#
# 3. Add RamDisk.app to Login Items in the Users & Groups, to set up RamDisk at start up. 
