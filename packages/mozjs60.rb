require 'package'

class Mozjs60 < Package
  description 'JS is Mozilla\'s JavaScript engine written in C.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/general/js60.html'
  version '60.8.0'
  source_url 'https://ftp.gnome.org/pub/gnome/teams/releng/tarballs-needing-help/mozjs/mozjs-60.8.0.tar.bz2'
  source_sha256 '697331336c3d65b80ded9ca87b4a8ceb804e5342b476eaa133ac638102a9dc5d'

  binary_url ({
    x86_64: 'file:///home/chronos/user/chromebrew/release/x86_64/mozjs60-60.8.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    x86_64: 'c13870f537e7cc0f53b04f0c4082f286b63b87f146fab853aa80156385d427da'
  })

  def self.build
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/autoconf", "#{CREW_PREFIX}/bin/autoconf213"
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "CXXFLAGS='-I#{CREW_PREFIX}/include/c++/8.3.0 -I#{CREW_PREFIX}/include/c++/8.3.0/x86_64-cros-linux-gnu' ../js/src/configure \
--prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-intl-api --with-system-zlib --with-system-icu --disable-jemalloc --disable-readline"
      system 'make'
    end
    FileUtils.rm_f "#{CREW_PREFIX}/bin/autoconf213"
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
