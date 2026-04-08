{
	description = "A keyboard layout combining Finnish and UK (PC) keyboards";

	inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	outputs = {
		nixpkgs,
		self,
		...
	}: let
		system = "x86_64-linux";
		pkgs = import nixpkgs {inherit system;};
	in {
		devShell.${system} =
			pkgs.mkShell {
				packages = [pkgs.kalamine];
			};

		packages.${system} = rec {
			default = finnest;
			finnest = pkgs.callPackage (import ./src) {version = "1.0.0";};
		};

		nixosModules = rec {
			default = finnest;
			finnest = {
				pkgs,
				lib,
				config,
				...
			}: let
				cfg = config.finnest;
			in {
				options.finnest = {
					enable = lib.mkEnableOption "the Finnest keyboard layout";
					package = lib.mkPackageOption self.packages.${system} "finnest" {};
					languages =
						lib.mkOption {
							description = "The language codes to install the layout under";
							default = ["fin" "eng"];
							type = lib.types.listOf lib.types.str;
						};
				};
				config =
					lib.mkIf cfg.enable {
						services.xserver.xkb.extraLayouts."finnest" = {
							inherit (cfg) languages;
							description = "Finnest";
							symbolsFile = "${cfg.package}/finnest.xkb_symbols";
						};
					};
			};
		};
	};
}
