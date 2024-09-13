require 'buildsystems/autotools'

class Gnupg < Autotools
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.5.1'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-#{version}.tar.bz2"
  source_sha256 '8a34bb318499867962c939e156666ada93ed81f01926590ac68f3ff79178375e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'feac6ee5a39250c7c1e276022c4b2d563663469b608f098a29eebeff7c311a14',
     armv7l: 'feac6ee5a39250c7c1e276022c4b2d563663469b608f098a29eebeff7c311a14',
       i686: 'b79683c5444f80f6c09d659d253d0651230f189ce3062ff1604a60958e6f7338',
     x86_64: '0a0753944ee934003275add76de9338498050ac50d98142656834c7639f79559'
  })

  depends_on 'bzip2' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'libassuan' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libksba' # R
  depends_on 'libusb' # R
  depends_on 'libxtrans' => :build
  depends_on 'npth' # R
  depends_on 'openldap' # R
  depends_on 'pinentry' => :build
  depends_on 'potrace' => :build
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'zlib' # R

  configure_options '--with-zlib \
    --with-bzip2 \
    --with-readline'

  run_tests
end
