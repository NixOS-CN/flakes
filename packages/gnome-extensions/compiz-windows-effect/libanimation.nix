{ stdenv, fetchFromGitHub, wrapGAppsHook, meson, ninja, gobject-introspection
, glib, pkg-config, gmock, gtest }:
stdenv.mkDerivation {
  name = "libanimation";
  src = fetchFromGitHub {
    owner = "hermes83";
    repo = "libanimation";
    rev = "b8e910530e6ebfd6db08f0379ebf3f9315465d5f";
    sha256 = "03mm8vkrf3qdr90zajs07fws6q2nk75dvkkvir1rk4a7d1xrgh7y";
  };
  patches = [ ./remove-test.patch ];
  nativeBuildInputs = [ wrapGAppsHook ];
  buildInputs =
    [ meson ninja gobject-introspection glib pkg-config gmock gtest ];
}
