require 'package'

class Synapse < Package
  description 'Synapse is a semantic launcher written in Vala that you can use to start applications as well as find and access relevant documents and files by making use of the Zeitgeist engine.'
  homepage 'https://launchpad.net/synapse-project'
  version '0.2.99.4'
  source_url 'https://launchpad.net/synapse-project/0.3/0.2.99.4/+download/synapse-0.2.99.4.tar.xz'
  source_sha256 '324c22d56415690979f23aae78cf080315a6defc506afd3e6ac14bb2ec4cddbc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'
  depends_on 'json_glib'
  depends_on 'libgee'
  depends_on 'libnotify'
  depends_on 'vala'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "ln -sf #{CREW_PREFIX}/bin/uget-gtk #{CREW_DEST_PREFIX}/bin/uget"
  end
end
