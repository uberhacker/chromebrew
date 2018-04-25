require 'package'

class Gssdp < Package
  description 'A GObject-based API for handling resource discovery and announcement over SSDP.'
  homepage 'https://github.com/GNOME/gssdp'
  version '1.0.2'
  source_url 'https://github.com/GNOME/gssdp/archive/gssdp-1.0.2.tar.gz'
  source_sha256 'ab22eb14e9faa587cf18ed191bdefaa6f7fb26e0c9852d9844f96b645c65273f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libsoup'

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
