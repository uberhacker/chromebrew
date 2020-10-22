require 'package'

class Scrcpy < Package
  description 'Display and control your Android device'
  homepage 'https://github.com/Genymobile/scrcpy'
  version '1.16'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/Genymobile/scrcpy/archive/v1.16.tar.gz'
    source_sha256 '94cbd59e26faa08ca25d5126d6c8d45e831b6a9e716ce05cd57bc4bcc751f742'
    depends_on 'android_studio'
    depends_on 'ffmpeg'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --buildtype=release --strip -Db_lto=true builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
