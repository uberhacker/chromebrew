require 'package'

class Ventoy < Package
  description 'Open source tool to create bootable USB drive for ISO/WIM/IMG/VHD(x)/EFI files.'
  homepage 'https://www.ventoy.net/en/index.html'
  version '1.0.99'
  license 'GPL-3.0'
  compatibility 'x86_64'
  source_url "https://downloads.sourceforge.net/project/ventoy/v#{version}/ventoy-#{version}-linux.tar.gz"
  source_sha256 '467cdd188a7f739bc706adbc1d695f61ffdefc95916adb015947d80829f00a3d'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/ventoy"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/ventoy"
  end

  def self.postinstall
    ExitMessage.add <<~EOM
      \nTo get started, type the following:
      cd #{CREW_PREFIX}/share/ventoy
      sudo bash ./VentoyWeb.sh\n
      For more info, execute the following:
      #{`echo -n $PAGER`} #{CREW_PREFIX}/share/ventoy/README
    EOM
  end
end
