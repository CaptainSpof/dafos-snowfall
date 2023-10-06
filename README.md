# Plus Ultra

<a href="https://nixos.wiki/wiki/Flakes" target="_blank">
	<img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=d8dee9&label=Nix%20Flakes&labelColor=5e81ac&message=Ready&color=d8dee9&style=for-the-badge">
</a>
<a href="https://github.com/snowfallorg/lib" target="_blank">
	<img alt="Built With Snowfall" src="https://img.shields.io/static/v1?logoColor=d8dee9&label=Built%20With&labelColor=5e81ac&message=Snowfall&color=d8dee9&style=for-the-badge">
</a>
<a href="https://jakehamilton.github.io/config" target="_blank">
	<img alt="Frost Documentation" src="https://img.shields.io/static/v1?logoColor=d8dee9&label=Frost&labelColor=5e81ac&message=Documentation&color=d8dee9&style=for-the-badge">
</a>

<p>
<!--
	This paragraph is not empty, it contains an em space (UTF-8 8195) on the next line in order
	to create a gap in the page.
-->
  
</p>

> ✨ Go even farther beyond.

- [Screenshots](#screenshots)
- [Overlays](#overlays)

## Screenshots

![clean](./assets/clean.png)

![busy](./assets/busy.png)

![firefox](./assets/firefox.png)

## Overlays

See the following example for how to apply overlays from this flake.

```nix
{
	description = "";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
		unstable.url = "github:nixos/nixpkgs";

		snowfall-lib = {
			url = "github:snowfallorg/lib";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		dafos = {
			url = "github:jakehamilton/config";
			inputs.nixpkgs.follows = "nixpkgs";
			inputs.unstable.follows = "unstable";
		};
	};

	outputs = inputs:
		inputs.snowfall-lib.mkFlake {
			inherit inputs;

			src = ./.;

			overlays = with inputs; [
				# Get all of the packages from this flake by using the main overlay.
				dafos.overlays.default

				# Individual overlays can be accessed from
				# `dafos.overlays.<name>`.

				# These overlays pull packages from nixos-unstable or other sources.
				dafos.overlays.bibata-cursors
				dafos.overlays.chromium
				dafos.overlays.comma
				dafos.overlays.default
				dafos.overlays.deploy-rs
				dafos.overlays.discord
				dafos.overlays.firefox
				dafos.overlays.flyctl
				dafos.overlays.freetube
				dafos.overlays.gamescope
				dafos.overlays.gnome
				dafos.overlays.kubecolor
				dafos.overlays.linux
				dafos.overlays.lutris
				dafos.overlays.nordic
				dafos.overlays.obs
				dafos.overlays.pocketcasts
				dafos.overlays.prismlauncher
				dafos.overlays.tmux
				dafos.overlays.top-bar-organizer
				dafos.overlays.yt-music

				# Individual overlays for each package in this flake
				# are available for convenience.
				dafos.overlays."package/at"
				dafos.overlays."package/bibata-cursors"
				dafos.overlays."package/cowsay-plus"
				dafos.overlays."package/doukutsu-rs"
				dafos.overlays."package/firefox-nordic-theme"
				dafos.overlays."package/frappe-books"
				dafos.overlays."package/hey"
				dafos.overlays."package/infrared"
				dafos.overlays."package/kalidoface"
				dafos.overlays."package/list-iommu"
				dafos.overlays."package/nix-get-protonup"
				dafos.overlays."package/nix-update-index"
				dafos.overlays."package/nixos-option"
				dafos.overlays."package/nixos-revision"
				dafos.overlays."package/steam"
				dafos.overlays."package/titan"
				dafos.overlays."package/twitter"
				dafos.overlays."package/wallpapers"
				dafos.overlays."package/xdg-open-with-portal"
			];
		};
}
```
