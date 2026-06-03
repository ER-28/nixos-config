# 🖥️ NixOS Auto-Config Dev Repo

Ce dépôt contient une configuration NixOS basée sur les **Flakes**, conçue pour être auto-hébergée sur GitHub et mise à jour automatiquement.

## 🚀 Fonctionnement

Le système est configuré pour être "auto-géré" :
1. **Stockage GitHub** : Toute la configuration est versionnée sur GitHub.
2. **Auto-Update (CI)** : Un workflow GitHub Actions (`.github/workflows/update.yml`) met à jour les dépendances du flake quotidiennement.
3. **Auto-Pull & Rebuild** : Le système possède un timer systemd qui tire les derniers changements depuis GitHub et déclenche une mise à jour du système.

## 🛠️ Configuration Dev

Pour faciliter le déploiement en environnement de développement :
- **Utilisateur** : `admin`
- **Mot de passe** : `admin`

## 📋 Installation Rapide

Pour appliquer cette configuration sur une machine NixOS :

1. Clonez le dépôt dans `/etc/nixos` :
   ```bash
   sudo git clone https://github.com/ER-28/nixos-config /etc/nixos
   ```
2. Appliquez la configuration :
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#nixos-main
   ```

## 📂 Structure du Repo

- `flake.nix` : Point d'entrée et définition des entrées.
- `hosts/nixos-main/` : Configuration spécifique à la machine.
- `modules/common/` : Modules partagés (réseau, boot, auto-update).
- `home/admin/` : Configuration Home Manager pour l'utilisateur admin.
- `.github/workflows/` : Automatisation GitHub Actions.
