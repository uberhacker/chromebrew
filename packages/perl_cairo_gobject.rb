require 'buildsystems/perl'

class Perl_cairo_gobject < PERL
  description 'Integrate Cairo into the Glib type system'
  homepage 'https://metacpan.org/pod/Cairo::GObject'
  version '1.005-perl5.40'
  license 'GPL 2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-GObject-1.005.tar.gz'
  source_sha256 '8d896444d71e1d0bca3d24e31e5d82bd0d9542aaed91d1fb7eab367bce675c50'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e47d27066dfcce1985e12ac63222c3a652978c66c35bde0913355b2b570629d1',
     armv7l: 'e47d27066dfcce1985e12ac63222c3a652978c66c35bde0913355b2b570629d1',
     x86_64: 'f3af8ebb01d2a374e8ae8dd12388decc9018abc7353563f0d0d4c781a8ab5411'
  })

  depends_on 'cairo' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'perl_cairo' => :build
  depends_on 'perl_glib' => :build

  no_compile_needed
end
