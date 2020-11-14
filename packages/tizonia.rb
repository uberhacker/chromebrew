require 'package'

class Tizonia < Package
  description 'A command-line streaming music client/server for Linux.'
  homepage 'https://tizonia.org/'
  version '0.22.0'
  compatibility 'all'
  source_url 'https://github.com/tizonia/tizonia-openmax-il/archive/v0.22.0.tar.gz'
  source_sha256 '0750cae23ed600fb4b4699a392f43a5e03dcd0870383d64da4b8c28ea94a82f8'

  depends_on 'llvm' => ':build'
  depends_on 'boost'
  depends_on 'log4c'
  
  def self.build
    ENV['CC'] = 'clang'
    ENV['CXX'] = 'clang'
    system "meson #{CREW_MESON_OPTIONS} --wrap-mode=nodownload --auto-features=enabled build"
    system "ninja -C build"
  end
  
  def self.install
   system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
