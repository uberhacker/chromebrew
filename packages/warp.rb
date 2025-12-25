require 'package'

class Warp < Package
  description 'The terminal with agents built in.'
  homepage 'https://www.warp.dev/'
  version '0.2025.12.17.17.17'
  license 'Unknown'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://releases.warp.dev/stable/v#{version}.stable_02/Warp-x86_64.AppImage"
  source_sha256 '5f44cef6fbaed1b9362742d833736a04f4df589172d43b45ee5257081aa58925'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    File.write 'warp.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/warp
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/warp"
    FileUtils.install 'warp.sh', "#{CREW_DEST_PREFIX}/bin/warp", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/warp"
  end

  def self.postinstall
    ExitMessage.add "\nSee 'https://docs.warp.dev/' to get started.\n"
  end
end
