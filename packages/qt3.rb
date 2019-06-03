require 'package'

class Qt3 < Package
  description 'A complete cross-platform C++ software framework and widget toolkit for creating classic and embedded graphical user interfaces.'
  homepage 'https://www.qt.io/'
  version '3.3.8b'
  source_url 'https://download.qt.io/archive/qt/3/qt-x11-free-3.3.8b.tar.gz'
  source_sha256 '1b7a1ff62ec5a9cb7a388e2ba28fda6f960b27f27999482ebeceeadb72ac9f6e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'freeglut'
  depends_on 'libjpeg'
  depends_on 'libmng'
  depends_on 'libpng'
  depends_on 'libxcursor'
  depends_on 'libxft'
  depends_on 'libxinerama'
  depends_on 'libxrandr'
  depends_on 'unixodbc'

  def self.patch
    system 'filefix'
    system "for f in $(find config.tests/x11/ -name '*.test'); do sed -i 's,/usr/lib /lib,#{CREW_LIB_PREFIX} /usr/#{ARCH_LIB} /#{ARCH_LIB},' $f; done"
    system "for f in $(find config.tests/x11/ -name '*.test'); do sed -i 's,/usr/include /include,#{CREW_PREFIX}/include /usr/include /include,' $f; done"
    #system "sed -i 's,compress(,qCompress(,g' src/kernel/qpngio.cpp"
    #system "sed -i 's,unqCompress(,qUncompress(,g' src/kernel/qpngio.cpp"
  end

  def self.build
    system "./configure -v \
           -prefix #{CREW_PREFIX} \
           -libdir #{CREW_LIB_PREFIX} \
           -bindir #{CREW_PREFIX}/bin \
           -release \
           -shared \
           -static \
           -thread \
           -no-nis \
           -pch \
           -no-cups \
           -stl \
           -system-nas-sound \
           -sm \
           -xshape \
           -xinerama \
           -xcursor \
           -xrandr \
           -xrender \
           -xft \
           -tablet \
           -xkb \
           -no-dlopen-opengl \
           -qt-sql-odbc \
           -qt-sql-sqlite \
           -system-libjpeg \
           -system-libmng \
           -system-libpng \
           -system-zlib"
    system 'make'
  end

  def self.install
    system "make -destdir #{CREW_DEST_DIR} install"
  end
end
