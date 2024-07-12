require 'package'

class Openshot < Package
  description 'OpenShot Video Editor is an award-winning free and open-source video editor'
  homepage 'https://www.openshot.org/'
  version '3.2.1'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url "https://github.com/OpenShot/openshot-qt/releases/download/v#{version}/OpenShot-v#{version}-x86_64.AppImage"
  source_sha256 'd318fc24c81057241bdec3fb8eed68849ec5b918939c39417b47543fb326a693'

  no_compile_needed

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    File.write 'openshot.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/openshot
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/openshot"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'openshot.sh', "#{CREW_DEST_PREFIX}/bin/openshot", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/openshot"
  end

  def self.postinstall
    ExitMessage.add "\nType 'openshot' to get started.\n"
  end
end
