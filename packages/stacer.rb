require 'package'

class Stacer < Package
  description 'Linux System Optimizer & Monitoring'
  homepage 'https://oguzhaninan.github.io/Stacer-Web/'
  version '1.1.0'
  compatibility 'x86_64'

  if ARCH == 'x86_64'
    source_url "https://github.com/oguzhaninan/Stacer/releases/download/v#{version}/stacer_#{version}_amd64.deb"
    source_sha256 `curl -Ls #{source_url} | sha256sum | cut -d' ' -f1`.chomp
    depends_on 'gtk3'
    depends_on 'sommelier'
  end

  def self.install
system 'ls -l'
abort
    # llvm-strip doesn't works with opera
    ENV['CREW_NOT_STRIP'] = '1'
    
    # since opera put the executable to library, we need to link it to CREW_PREFIX
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/opera/opera", 'bin/opera'
      
    # place all stuff to lib64 instead of lib
    FileUtils.mv 'lib/x86_64-linux-gnu/', 'share/'
    FileUtils.rm_rf 'lib/'
    
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir.glob('*'), CREW_DEST_PREFIX
  end
  
  def self.postinstall
    puts
    puts 'Set Opera as your default browser? [Y/n]: '
    case STDIN.gets.chomp
    when "\n", 'Y', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/opera/opera", 'x-www-browser'
      end
    else
      puts 'No change has been made.'
      puts
    end
  end

  def self.remove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      FileUtils.rm 'x-www-browser' if File.realpath('x-www-browser') == "#{CREW_LIB_PREFIX}/opera/opera"
    end    
  end
end
