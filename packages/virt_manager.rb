require 'package'

class Virt_manager < Package
  description 'The virt-manager application is a desktop user interface for managing virtual machines through libvirt.'
  homepage 'https://virt-manager.org/'
  version '2.2.0'
  source_url 'https://github.com/virt-manager/virt-manager/archive/v2.2.0.tar.gz'
  source_sha256 'aa43c609e945ba0d265ddc6014faec10ae9ab2789c7248c5b65ba4be94903bdc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'
  depends_on 'libnl3'
  depends_on 'libosinfo'

  def self.install
    system "./setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
