require 'package'

class Sklauncher < Package
  description 'Secure and modern Minecraft launcher'
  homepage 'https://skmedix.pl/'
  version '3.2.10'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://skmedix.pl/binaries/skl/#{version}/SKlauncher-#{version}.jar"
  source_sha256 '3ce7e5aff85320e1d393eb34e918a6b71a667bccf08252fbdd512443e5d62f9a'

  depends_on 'openjdk17'
  depends_on 'sommelier'

  no_compile_needed

  def self.build
    File.write 'sklauncher.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/sklauncher/SKlauncher-#{version}.jar "$@"
    EOF
  end

  def self.install
    FileUtils.install "SKlauncher-#{version}.jar", "#{CREW_DEST_PREFIX}/share/sklauncher/SKlauncher-#{version}.jar", mode: 0o644
    FileUtils.install 'sklauncher.sh', "#{CREW_DEST_PREFIX}/bin/sklauncher", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'sklauncher' to get started.\n"
  end
end
