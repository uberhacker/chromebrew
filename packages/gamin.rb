require 'package'

class Gamin < Package
  description 'Gamin is a file and directory monitoring system defined to be a subset of the FAM (File Alteration Monitor) system.'
  homepage 'https://people.gnome.org/~veillard/gamin/'
  version '0.1.10'
  source_url 'https://people.gnome.org/~veillard/gamin/sources/gamin-0.1.10.tar.gz'
  source_sha256 '28085f0ae8be10eab582ff186af4fb0be92cc6c62b5cc19cd09b295c7c2899a1'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'
  depends_on 'gtk_doc'
  depends_on 'python27'

  def self.patch
    # See http://www.linuxfromscratch.org/blfs/view/7.4/general/gamin.html.
    system "sed -i 's/G_CONST_RETURN/const/' server/gam_node.c server/gam_node.h server/gam_subscription.c server/gam_subscription.h"
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
