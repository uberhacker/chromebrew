require 'package'

class Elogind < Package
  description "The systemd project's 'logind', extracted to a standalone package"
  homepage 'https://github.com/elogind/elogind'
  version '241.4'
  source_url 'https://github.com/elogind/elogind/archive/v241.4.tar.gz'
  source_sha256 'fb4d0f931d5fb11af5a4426b0198e85fabc83d604ee24427b26480164cddb7e1'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson' => :build
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gperf'
  depends_on 'libgudev'
  depends_on 'libcap'
  depends_on 'linux_pam'
  depends_on 'pcre2'

  def self.build
    system "meson \
            --buildtype=release \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --sysconfdir=#{CREW_PREFIX}/etc \
            -Dman=false \
            _build"
    system 'ninja -v -C _build'
  end

#  def self.check
#    system 'ninja -C _build test'
#  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
    FileUtils.mv "#{CREW_DEST_DIR}/lib", "#{CREW_DEST_PREFIX}"
    FileUtils.mv Dir.glob("#{CREW_DEST_DIR}/bin/*"), "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv Dir.glob("#{CREW_DEST_DIR}/#{ARCH_LIB}/*"), "#{CREW_DEST_LIB_PREFIX}" if ARCH == 'x86_64'
  end
end
