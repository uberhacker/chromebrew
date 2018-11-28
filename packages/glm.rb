require 'package'

class Glm < Package
  description 'OpenGL Mathematics (GLM) is a header only C++ mathematics library for graphics software based on the OpenGL Shading Language (GLSL) specifications.'
  homepage 'http://glm.g-truc.net/'
  version '0.9.9.3'
  source_url 'https://github.com/g-truc/glm/releases/download/0.9.9.3/glm-0.9.9.3.zip'
  source_sha256 '496e855590b8aa138347429b7fc745d66707303fb82c1545260d1888472e137b'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB} .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
