require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '65.0.1'
  source_url 'https://ftp.mozilla.org/pub/firefox/releases/65.0.1/source/firefox-65.0.1.source.tar.xz'
  source_sha256 '67e517f6d1ea8aa5c8f32404b8756f3205c3550917a91a19b0a0edccc656a3cc'

  binary_url ({
    aarch64: '',
     armv7l: '',
       i686: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/65.0.1/linux-i686/en-US/firefox-65.0.1.tar.bz2',
     x86_64: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/65.0.1/linux-x86_64/en-US/firefox-65.0.1.tar.bz2',
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
       i686: '4f78c2c7cc56e5479415206e66039bd8634811dc311c2b53f22c6856fd98aa53',
     x86_64: 'a89aae224b872d1b5e17ab213ca04a711ae72061828685f999ea2f52784acb56',
  })

  depends_on 'bz2'
  depends_on 'libevent'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libvpx'
  depends_on 'nodebrew'
  depends_on 'nss'
  depends_on 'rust'

  def self.build
    # For detailed build instructions, see https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Simple_Firefox_build/Linux_and_MacOS_build_preparation.
    ENV['AUTOCONF'] = CREW_PREFIX + '/bin/autoconf'
    system "TMPDIR=#{CREW_PREFIX}/tmp cargo install cbindgen" unless File.exists? HOME + '/.cargo/bin/cbindgen'
    node_ver = 'v8.15.0'
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
             '--with-system-jpeg',
             '--with-system-libevent',
             '--with-system-libvpx',
             '--with-system-nspr',
             '--with-system-nss',
             '--with-system-png',
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
