require 'package'

class Mysql_workbench < Package
  description 'MySQL Workbench is a unified visual tool for database architects, developers, and DBAs.'
  homepage 'https://www.mysql.com/products/workbench/'
  version '8.0.12'
  source_url 'https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-8.0.12-src.tar.gz'
  source_sha256 '0241586c95026a7d4d1b552ba2e33d8e66f6826e8f7e1a692b78c405f80cd334'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libsigcplusplus'
  depends_on 'libsecret'
  depends_on 'libglade'
  depends_on 'libglu'
  depends_on 'boost'
  depends_on 'pango'
  depends_on 'mesa'
  depends_on 'gtkmm2'
  depends_on 'gtkmm3'
  depends_on 'swig'
  depends_on 'sqlite'
  depends_on 'gdal'
  depends_on 'sommelier'

  def self.build
    FileUtils.mkdir 'wb-build'
    Dir.chdir 'wb-build' do
      system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'wb-build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
