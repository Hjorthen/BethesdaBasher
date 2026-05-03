# BethesdaBasher

> a barebones, simple mod manager for Bethesda games. Download the mod archive files, define the order they should be applied and generate a folder ready to be dropped into the games Data folder. It doesn't do anything fancy but makes small-scale modding on Linux trivial. 
---

## Usage

Drop your mod archives into the `modfiles/` folder, then run the two scripts in order.

**1. Generate the modlist**

```bash
./make-modlist
```

This scans the `modfiles/` folder and generates `modlist.txt`, which defines the order mods will be applied. Open `modlist.txt` and reorder the entries to your liking — mods listed later override files from earlier ones.

**2. Build the staging folder**

```bash
./make-staging
```

This reads `modlist.txt` and extracts each mod in order into a merged staging folder, ready to be copied into your game's `Data/` directory.

### FOMOD mods

If an archive contains a FOMOD installer, the script will pause and wait for you to manually sort the files to be merged.

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
## What it doesn't do
This setup is meant to be stupidly simple for when you just want to play with the community patch and a few QoL mods, without having to juggle archive files and extraction ordering. As such I want to be straight forward about what not to expect. 

- Removing a mod from Data requires you to revalidate the game as we don't keep track of overwritten files.
- No nexus integration (Mod-manager download, new version checks)
- Mod load ordering (not to be confused with extract ordering) has to be done manually. It may be possible to handle load ordering as well but I'm not sure how it would tie in with creation content. 

## Improvements
Working with FOMOD files is a pain. I would like for the script to store how a FOMOD mod was 'solved' in a cache location. If make-staging is applied again, it can check the cache and retrieve the modfiles. Would save the user from the pain of having to apply their work once again. 
