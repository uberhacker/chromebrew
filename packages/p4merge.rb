require 'package'

class P4merge < Package
  description 'Helix Visual Merge Tool (P4Merge) is a three-way merging and side-by-side file comparison tool.'
  homepage 'https://www.perforce.com/downloads/visual-merge-tool'
  version '24.2'
  license 'GPL-3'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://www.perforce.com/downloads/perforce/r#{version}/bin.linux26x86_64/p4v.tgz"
  source_sha256 '158c12c8b6db0996be93dc1de50d2f01ccc4b2a56c72e4c7d6c2798a8ff82d5d'

  depends_on 'libglvnd'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/p4merge"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/p4merge"
    Dir["#{CREW_DEST_PREFIX}/share/p4merge/bin/*"].each do |binary|
      bin = File.basename binary
      FileUtils.ln_s "#{CREW_PREFIX}/share/p4merge/#{bin}", "#{CREW_DEST_PREFIX}/bin/#{bin}"
    end
    File.write "#{CREW_DEST_PREFIX}/bin/p4", <<~EOF
      #!/bin/bash
      LD_LIBRARY_PATH="#{CREW_PREFIX}/share/p4merge/lib:$LD_LIBRARY"
      #{CREW_PREFIX}/share/p4merge/bin/p4merge "$@"
    EOF
    File.chmod 0o755, "#{CREW_DEST_PREFIX}/bin/p4"
  end

  def self.postinstall
    ExitMessage.add "Type 'p4' to get started."
  end
end
