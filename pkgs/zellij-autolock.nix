{
  lib,
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "zellij-autolock";
  version = "0.2.2"; # You can update this to the latest version

  src = fetchurl {
    url = "https://github.com/fresh2dev/zellij-autolock/releases/download/${version}/zellij-autolock.wasm";
    sha256 = "aclWB7/ZfgddZ2KkT9vHA6gqPEkJ27vkOVLwIEh7jqQ=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/zellij-autolock.wasm
  '';

  meta = with lib; {
    description = "A Zellij plugin that automatically locks your session after a period of inactivity.";
    homepage = "https://github.com/fresh2dev/zellij-autolock";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
