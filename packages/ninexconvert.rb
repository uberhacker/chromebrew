require 'package'

class Ninexconvert < Package
  description 'Download, convert, edit, and compress your files with ease'
  homepage 'https://123sudo.com/desktop/9xconvert'
  version '1.4.7'
  license 'Apache 2.0, MIT'
  compatibility 'x86_64'
  min_glibc '2.33'
  source_url "https://update.123sudo.com/desktop/9xconvert/9xconvert-#{version}-x86_64.AppImage"
  source_sha256 '4d37d825afe7a216e32b511acc29538a1db8867a34b69bf1b1e780bfc2dcfef8'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    File.write '9xconvert.sh', <<~EOF
      #!/bin/bash
      LD_LIBRARY_PATH=#{CREW_PREFIX}/share/9xconvert/usr/lib:$LD_LIBRARY_PATH
      cd #{CREW_PREFIX}/share/9xconvert
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/9xconvert"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv '9xconvert.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install '9xconvert.sh', "#{CREW_DEST_PREFIX}/bin/9xconvert", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/9xconvert"
  end

  def self.postinstall
    ExitMessage.add "\nType '9xconvert' to get started.\n"
  end
end
