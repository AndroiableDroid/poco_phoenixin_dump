#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery:134217728:1401adf1a8cee423d10167843030144a980aa094; then
  applypatch  \
          --patch /system/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot:134217728:362b5606f7c37bfa6e318b5e34d2076cbb2fa9c9 \
          --target EMMC:/dev/block/bootdevice/by-name/recovery:134217728:1401adf1a8cee423d10167843030144a980aa094 && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
