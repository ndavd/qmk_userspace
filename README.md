# QMK Userspace

Install `qmk`. With Nix, you can use my devShell:

```bash
nix develop
```

Set it up with [Keychron's firmware](https://github.com/Keychron/qmk_firmware).

Flash with the custom keymap:

```bash
qmk flash -kb keychron/q60_max/ansi -km ndavd
```
