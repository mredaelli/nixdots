{pkgs, fetchFromGitHub, stdenv}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "StyLua";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "JohnnyMorganz";
    repo = pname;
    rev = "v${version}";
    sha256 = "0hm87lqxb3pshffvwwxl06asx8qjz1l0vc3jkpnplg621bd9xsi3";
  };

  cargoSha256 = "0ihx9vpz5vvf25kqs24iv0n9w0dvc0gbbxckpz0zg3b0xhb8jjfx";
}
