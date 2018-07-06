require 'package'

class Libgconf < Package
  description 'GConf is a configuration database system for storing application preferences.'
  homepage 'https://projects-old.gnome.org/gconf/'
  version '3.2.6'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/GConf/3.2/GConf-3.2.6.tar.xz'
  source_sha256 '1912b91803ab09a5eed34d364bf09fe3a2a9c96751fde03a4e0cfa51a04d784c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgconf-3.2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgconf-3.2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgconf-3.2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgconf-3.2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b3ce596e8f2428f0da25a73be4434b89889686790681b228ebfeae7eb9cd365f',
     armv7l: 'b3ce596e8f2428f0da25a73be4434b89889686790681b228ebfeae7eb9cd365f',
       i686: '1519f6e9b3dbbe00af80d3bb0d0d67233977aa09c62f36263564d5a803e4c44a',
     x86_64: '694f3c37b35df0d3b33694c9e31716009a2280809ebd6644542945fca76f6ebd',
  })

  depends_on 'dbus_glib' => :build
  depends_on 'gtk3' => :build
  depends_on 'openldap' => :build

  def self.build
    system "sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' configure"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-nls',
           '--disable-orbit',
           '--disable-static',
           '--with-openldap'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
