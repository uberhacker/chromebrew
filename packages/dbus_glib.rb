require 'package'

class Dbus_glib < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '0.110'
  source_url 'https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.110.tar.gz'
  source_sha256 '7ce4760cf66c69148f6bd6c92feaabb8812dee30846b24cd0f7395c436d7e825'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus_glib-0.110-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dbus_glib-0.110-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dbus_glib-0.110-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus_glib-0.110-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d1b018f7ae01b9b008923368f940f23365cecf0345c2d0ca15ccc0632c39c10',
     armv7l: '8d1b018f7ae01b9b008923368f940f23365cecf0345c2d0ca15ccc0632c39c10',
       i686: '691d9a465ff5bd2f8d0f11072f2527a987debfb55fa76dce7ae8b6682a0783ef',
     x86_64: 'f212225d9ae0766041883c1e570e737e1bcf09f3057028c6e4b6d2d4fd53ce14',
  })

  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'python27'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'pip install six'
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
