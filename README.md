# Finnest

A keyboard layout combining Finnish and UK (PC) keyboards.

## Why?

The Finnish keyboard sucks for programming but I need the umlauts. I liked using [@ruohola](https://github.com/ruohola)'s excellently thought-out [Finner](https://github.com/ruohola/finner) layout but generally like the UK layout more than the US one. And so, here we are.

## Usage

### NixOS

This repo is a flake with both a Nix package and a NixOS module. The easiest way to install the layout is to add the module to your system configuration and then enable it, which adds it to XKB:
```nix
# my-machine.nix
{inputs, ...}: {
    # Add the module…
    imports = [inputs.finnest.nixosModules.default];
    # …and enable the layout in XKB
    finnest.enable = true;
}
```

Afterwards, you can use the string `"finnest"` wherever you'd normally define a keyboard layout, e.g.:
```nix
# my-machine.nix
{
    console.keymap = "finnest";
}
```
```kdl
// ~/.config/niri/config.kdl
input {
    keyboard {
        xkb { layout "finnest,fi"; }
    }
}
```

### Other systems

The layout is generated using [@OneDeadKey](https://github.com/OneDeadKey)'s [Kalamine](https://github.com/OneDeadKey/kalamine/) which is an abandoned project, so expect the generated layouts to be all kinds of broken. But if you want to give it a shot, Kalamine has [instructions on installing layouts on different systems](https://github.com/OneDeadKey/kalamine/?tab=readme-ov-file#using-distributable-layouts). You can download the Finnest layout files for your system from the [releases page](https://github.com/emsknock/finnest/releases/latest).
