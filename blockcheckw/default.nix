{ lib, rustPlatform, fetchFromGitHub }:

# nix shell .#nixosConfigurations.ginnungagap.pkgs.blockcheckw
rustPlatform.buildRustPackage rec {
  pname = "blockcheckw";
  version = "0.12.1";

  src = fetchFromGitHub {
    owner = "rcd27";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-+h/DWeo8zTgsXS+2Maab1J/yK70Vk+kzuQY5HqDkaVk=";
  };

  cargoHash = "sha256-q86Sg2rgbo9Q1RkY6SeNJvX5oaVwVXLcBjK4UVqq0Xc=";

  doCheck = false;

  meta = {
    description = "blockcheck2.sh wrapper for better scanning speed";
    homepage = "https://github.com/rcd27/blockcheckw";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ igsha ];
    mainProgram = pname;
  };
}
