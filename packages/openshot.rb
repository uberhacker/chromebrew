require 'package'

class Openshot < Package
  description 'OpenShot is an open-source project dedicated to delivering high quality video editing, animation, and playback solutions to the world.'
  homepage 'https://github.com/OpenShot/openshot-qt'
  version '2.4.3'
  source_url 'https://github.com/OpenShot/openshot-qt/archive/v2.4.3.tar.gz'
  source_sha256 '901b485c28cfcbb4d1baf3cd6a30b165090c49c96f252236f1bbd8c8ab709721'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libopenshot'
  depends_on 'pyqt5'

  def self.build
    system "python3 setup.py build"
  end

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
