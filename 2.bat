docker run --rm -v %cd%:/root/env starfleetos-buildenv
qemu-system-x86_64 -hda ./build/boot.bin