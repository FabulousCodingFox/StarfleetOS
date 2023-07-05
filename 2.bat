docker run --rm -v %cd%:/root/env starfleetos-buildenv
qemu-system-x86_64 -hda ./bin/boot.bin