require 'buildsystems/meson'

class Frog < Meson
  description 'Extract text from any image, video, QR Code and etc.'
  homepage 'https://tenderowl.com/work/frog/'
  version '1.5.1'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/TenderOwl/Frog.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3cfbee5522f48b4f99d62d0c4f559320881012812b0f879e0592edf9b3fb608a',
     armv7l: '3cfbee5522f48b4f99d62d0c4f559320881012812b0f879e0592edf9b3fb608a',
     x86_64: 'a402bed68aff3ac037973935760317a4db6716049abe75bd456067798e190a46'
  })

  meson_options ''
end
