require 'package'

class Rustrover < Package
  description 'A powerhouse IDE for Rust developers'
  homepage 'https://www.jetbrains.com/rust/'
  version '2024.3.2'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://download.jetbrains.com/rustrover/RustRover-#{version}.tar.gz"
  source_sha256 'c6549572baa913c9842b0227257f7477531269393d5989622a3d0b802b999bf8'

  depends_on 'openjdk8'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.patch
    # Fix java.io.IOException: Cannot run program "/home/chronos/user/.PyCharmCE2019.3/system/tmp/ij1055598732.tmp": error=13, Permission denied
    # FileUtils.mkdir_p CREW_DEST_HOME.to_s
    # FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    # FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.PyCharmCE2022.2"
    # system "touch #{CREW_DEST_PREFIX}/.config/.PyCharmCE2022.2/test"
    # FileUtils.ln_s "#{CREW_PREFIX}/.config/.PyCharmCE2022.2", "#{CREW_DEST_HOME}/.PyCharmCE2022.2"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/RustRover"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/RustRover"
    FileUtils.ln_s "#{CREW_PREFIX}/share/RustRover/bin/rustrover.sh", "#{CREW_DEST_PREFIX}/bin/rustrover"
  end

  def self.postinstall
    ExitMessage.add "\nType 'rustrover' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/.PyCharmCE2022.2")
  end
end
