require 'package'

class Imagemagick7 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  @_ver = '7.0.11-6'
  version @_ver
  license 'imagemagick'
  compatibility 'all'
  source_url "https://github.com/ImageMagick/ImageMagick/archive/#{@_ver}.tar.gz"
  source_sha256 '8adc1605784653b078572b825e8cd1d3d54f8a1b4ba86b32ca253c038f7e4c37'

  binary_url({
  })
  binary_sha256({
  })

  depends_on 'flif'
  depends_on 'freeimage'
  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'graphviz'
  depends_on 'jbigkit'
  depends_on 'jemalloc'
  depends_on 'lzma'
  depends_on 'libheif'
  depends_on 'librsvg'
  depends_on 'libwebp'
  depends_on 'libwmf'
  depends_on 'msttcorefonts'
  depends_on 'openexr'
  depends_on 'openjpeg'
  depends_on 'pango'

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless imver.empty?
  end

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto -fno-stack-protector -U_FORTIFY_SOURCE \
      -I#{CREW_PREFIX}/include/gdk-pixbuf-2.0 \
      -I#{CREW_PREFIX}/include/c++/v1/support/xlocale' \
      CXXFLAGS='-pipe -flto=auto -fno-stack-protector -U_FORTIFY_SOURCE' \
      LDFLAGS='-flto=auto -fno-stack-protector -U_FORTIFY_SOURCE' \
      ./configure \
      #{CREW_OPTIONS} \
      --mandir=#{CREW_MAN_PREFIX} \
      --program-prefix='' \
      --with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
      --disable-dependency-tracking \
      --enable-hugepages \
      --with-jemalloc \
      --with-modules \
      --enable-hdri \
      --with-perl \
      --with-rsvg \
      --with-x"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickWand-7.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickWand-7.Q16.so.6"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickCore-7.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickCore-7.Q16.so.6"
  end
end
