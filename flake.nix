{
  description = "My professional NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... }@inputs:
    let
      system = "x86_64-linux";
      
      # Define hosts here for easy expansion
      hosts = {
        nixos-main = {
          username = "admin";
        };
        # Example: laptop-work = { username = "workuser"; };
      };

      mkSystemConfig = hostname: { username, ... }: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };

        modules = [
          ./hosts/${hostname}/default.nix
          agenix.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ../home/${username}/home.nix;
          }
        ];
      };
    in {
      nixosConfigurations = nixpkgs.lib.genAttrs (builtins.attrNames hosts) (hostname: 
        mkSystemConfig hostname (hosts.${hostname})
      );

      # ISO Image builder
      nixosIso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-main/default.nix
          agenix.nixosModules.default
          {
            console.setup.keyboardConfiguration.layout = "us";
            services.openssh.enable = true;
          }
        ];
      };
    };


      # ISO Image builder
      nixosIso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostname}/default.nix
          agenix.nixosModules.default
          {
            console.setup.keyboardConfiguration.layout = "us";
            services.openssh.enable = true;
          }
        ];
      };
}