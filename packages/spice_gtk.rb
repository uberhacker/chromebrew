require 'package'

class Spice_gtk < Package
  description 'Client library using GLib and GTK+'
  homepage 'https://www.spice-space.org/'
  version '0.37'
  source_url 'https://gitlab.freedesktop.org/spice/spice-gtk/-/archive/v0.37/spice-gtk-v0.37.tar.bz2'
  source_sha256 'eab3e99f19414f24a12cb17c118e3196ea0b33269109a4b1f384e088ad082137'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gst_plugins_base'
  depends_on 'gtk3'
  depends_on 'six'
  depends_on 'spice_protocol'
  depends_on 'usbutils'
  depends_on 'vala'

  def self.build
    system 'pip3 install pyparsing'
    system 'git clone -b v0.37 https://gitlab.freedesktop.org/spice/spice-gtk.git'
    Dir.chdir 'spice-gtk' do
      system './autogen.sh'
      system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--disable-maintainer-mode'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'spice-gtk' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    system 'pip3 uninstall -y pyparsing'
    system "pip3 install pyparsing --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
