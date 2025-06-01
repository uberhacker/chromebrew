require 'package'

class Yazi < Package
  description 'Blazing fast terminal file manager written in Rust, based on async I/O.'
  homepage 'https://yazi-rs.github.io/'
  version '25.5.31'
  license 'MIT'
  compatibility 'aarch64 i686 x86_64'
  source_url "https://github.com/sxyazi/yazi/releases/download/v#{version}/yazi-#{ARCH}-unknown-linux-gnu.zip"
  case ARCH
  when 'aarch64'
    source_sha256 '24c8950f64c1357a47e5f9fa3685bd3d031937a5f0ccd4ed9fb439e6dde8f8fe'
  when 'i686'
    source_sha256 '0e6a21e20b4305bcfae422c94fc940bfb5ac816a28da1a6374c2bb3d7b02c98b'
  when 'x86_64'
    source_sha256 '617b42aca6da4f89afa2db38122e00670738e84893ea2f366b898d3038f62ca3'
  end

  no_compile_needed
  print_source_bashrc

  def self.build
    File.write 'yazi.bash', <<~EOF
      #!/bin/bash
      source #{CREW_PREFIX}/share/yazi/completions/ya.bash
      source #{CREW_PREFIX}/share/yazi/completions/yazi.bash
    EOF
  end

  def self.install
    FileUtils.install %w[ya yazi], "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/yazi"
    FileUtils.mv 'completions', "#{CREW_DEST_PREFIX}/share/yazi"
    FileUtils.install 'yazi.bash', "#{CREW_DEST_PREFIX}/etc/bash_completions.d/10-yazi", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'yazi' to get started.\n"
  end
end
