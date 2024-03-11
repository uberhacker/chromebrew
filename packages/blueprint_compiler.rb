require 'buildsystems/meson'

class Blueprint_compiler < Meson
  description 'Markup language and compiler for GTK 4 user interfaces.'
  homepage 'https://jwestman.pages.gitlab.gnome.org/blueprint-compiler/'
  version '0.10.0'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/jwestman/blueprint-compiler.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3cfbee5522f48b4f99d62d0c4f559320881012812b0f879e0592edf9b3fb608a',
     armv7l: '3cfbee5522f48b4f99d62d0c4f559320881012812b0f879e0592edf9b3fb608a',
     x86_64: 'a402bed68aff3ac037973935760317a4db6716049abe75bd456067798e190a46'
  })

  meson_options ''
end
