{ stdenv, buildGoModule , fetchFromGitHub }:

buildGoModule rec {
  pname = "efm-langserver";
  version = "0.0.26";

  src = fetchFromGitHub {
    owner = "mattn";
    repo = pname;
    rev = "v${version}";
    sha256 = "0m9cfimjprdj9jvhmc9wgchpy1djq5sdaqk6iphh346w4blwvs5w";
  };

  vendorSha256 = "1whifjmdl72kkcb22h9b1zadsrc80prrjiyvyba2n5vb4kavximm";
}
