require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '65.0.2'
  source_url 'https://ftp.mozilla.org/pub/firefox/releases/65.0.2/source/firefox-65.0.2.source.tar.xz'
  source_sha256 '7d856a681fd8959f492679d0db3c3b787102665670f57cd9739ba9065702059f'

  binary_url ({
    aarch64: '',
     armv7l: '',
       i686: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/65.0.2/linux-i686/en-US/firefox-65.0.2.tar.bz2',
     x86_64: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/65.0.2/linux-x86_64/en-US/firefox-65.0.2.tar.bz2',
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
       i686: '8cec05eacf4cca3124c59d41fffea6059cdb6dd47c3590cd0c60dc66ca75d2f4',
     x86_64: 'f7cd14a461d274ea213c79a35ba00157e7e23b573648c90825b277482effb459',
  })

  depends_on 'bz2'
  depends_on 'libevent'
  depends_on 'libvpx'
  depends_on 'llvm'
  depends_on 'nasm'
  depends_on 'nodebrew'
  depends_on 'nss'
  depends_on 'pulseaudio'
  depends_on 'rust'
  depends_on 'gtk2'
  depends_on 'sommelier'

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
