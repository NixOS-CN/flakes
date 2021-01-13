{ stdenv, fetchgit }:
stdenv.mkDerivation {
  name = "gruvarc-gtk-theme";
  src = fetchgit {
    url = "https://github.com/salimundo/Pop-gruvbox.git";
    rev = "818a87cff8c0a9dbafbfad11e5db318719c1cb2e";
    sha256 = "0jzi3hs5nw8mhkfja6hypapgd56vld4gm3mak8wnsxxn8c31jan5";
  };

  installPhase = ''
    mkdir -p $out/share/themes/gruvarc-gtk-theme
    cp -r * $out/share/themes/gruvarc-gtk-theme
  '';
}
