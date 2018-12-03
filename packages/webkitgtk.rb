require 'package'

class Webkitgtk < Package
  description 'WebKitGTK+ is a full-featured port of the WebKit rendering engine, suitable for projects requiring any kind of web integration, from hybrid HTML/CSS applications to full-fledged web browsers.'
  homepage 'http://apr.apache.org/'
  version '2.22.4'
  source_url 'https://webkitgtk.org/releases/webkitgtk-2.22.4.tar.xz'
  source_sha256 'fab5be2883802352ae0e735dd1eff4bc18abaff7ac78689cec72eb2f611943b8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ninja' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      if ARCH == 'x86_64'
        system "cmake .. -DPORT=GTK -DCMAKE_BUILD_TYPE=Release -GNinja -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_SUFFIX=64"
     else
        system "cmake .. -DPORT=GTK -DCMAKE_BUILD_TYPE=Release -GNinja -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
      end
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
