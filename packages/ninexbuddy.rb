require 'package'

class Ninexbuddy < Package
  description 'Desktop online video download helper'
  homepage 'https://123sudo.com/desktop/9xbuddy'
  version '2.1.4'
  license 'Apache 2.0, MIT'
  compatibility 'x86_64'
  min_glibc '2.33'
  source_url "https://update.123sudo.com/desktop/9xbuddy/9xbuddy-#{version}-x86_64.AppImage"
  source_sha256 'dfb11ec510b985f33fcce512ab20dd48a7d7753f56dbb4a630e1d8d731f97c85'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    File.write '9xbuddy.sh', <<~EOF
      #!/bin/bash
      LD_LIBRARY_PATH=#{CREW_PREFIX}/share/9xbuddy/usr/lib:$LD_LIBRARY_PATH
      cd #{CREW_PREFIX}/share/9xbuddy
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/9xbuddy"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv '9xbuddy.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install '9xbuddy.sh', "#{CREW_DEST_PREFIX}/bin/9xbuddy", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/9xbuddy"
  end

  def self.postinstall
    ExitMessage.add "\nType '9xbuddy' to get started.\n"
  end
end
