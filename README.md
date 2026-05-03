# BethesdaBasher

> _Brief description goes here._

---

## Usage

Drop your mod archives into the `modfiles/` folder, then run the two scripts in order.

**1. Generate the modlist**

```bash
./make-modlist
```

This scans the `modfiles/` folder and generates `modlist.txt`, which defines the order mods will be applied. Open `modlist.txt` and reorder the entries to your liking — mods listed later override files from earlier ones on conflict.

**2. Build the staging folder**

```bash
./make-staging
```

This reads `modlist.txt` and extracts each mod in order into a merged staging folder, ready to be copied into your game's `Data/` directory.

### FOMOD mods

If an archive contains a FOMOD installer, the script will pause and prompt you to select options interactively before continuing.

---

## Install

The only dependency is a Unix environment with `bsdtar` available.

```bash
# Debian/Ubuntu
sudo apt install libarchive-tools

# Arch
sudo pacman -S libarchive
```

Clone the repo and make the scripts executable:

```bash
git clone https://github.com/Hjorthen/BethesdaBasher
cd BethesdaBasher
chmod +x make-modlist make-staging
```
