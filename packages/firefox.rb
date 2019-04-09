require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '66.0.2'
  source_url 'https://ftp.mozilla.org/pub/firefox/releases/66.0.2/source/firefox-66.0.2.source.tar.xz'
  source_sha256 'fc37538e5852d4c97778ad7437fb1d37e9218c284ced70935378562e35184b46'

  binary_url ({
    aarch64: '',
     armv7l: '',
       i686: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/66.0.2/linux-i686/en-US/firefox-66.0.2.tar.bz2',
     x86_64: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/66.0.2/linux-x86_64/en-US/firefox-66.0.2.tar.bz2',
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
       i686: 'e969531fd9b8cc7bd305ce8350ab14adadb304b1898b777d3275507f5ec38791',
     x86_64: 'eda0f0bc2af3a4b19f77d48c7242453477565906337848b51e363291456f41b1',
  })

  depends_on 'bz2'
  depends_on 'libevent'
  depends_on 'libvpx'
  depends_on 'llvm'
  depends_on 'nodebrew'
  depends_on 'nss'
  depends_on 'pulseaudio'
  depends_on 'rust'
  depends_on 'gtk2'
  depends_on 'yasm'
  depends_on 'sommelier'

  def self.build
    # For detailed build instructions, see https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Simple_Firefox_build/Linux_and_MacOS_build_preparation.
    ENV['AUTOCONF'] = CREW_PREFIX + '/bin/autoconf'
    system "TMPDIR=#{CREW_PREFIX}/tmp cargo install cbindgen" unless File.exists? HOME + '/.cargo/bin/cbindgen'
    node_ver = 'v9.11.2'
    node_old = `nodebrew ls | fgrep 'current: ' | cut -d' ' -f2`.chomp
    node_ver_installed = `nodebrew ls | grep -o #{node_ver} | head -1`.chomp
    system "nodebrew install #{node_ver}" unless node_ver_installed == node_ver
    system "nodebrew use #{node_ver}" unless node_old == node_ver
    Dir.chdir 'build' do
      system '../configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--with-system-bz2',
             '--with-system-icu',
             '--with-system-libevent',
             '--with-system-libvpx',
             '--with-system-nspr',
             '--with-system-nss',
             '--with-system-zlib'
      system 'make'
      system "nodebrew uninstall #{node_ver}" unless node_ver_installed == node_ver
      system "nodebrew use #{node_old}" unless node_old == "none"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
