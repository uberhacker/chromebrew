require 'package'

class Cpu_g < Package
  description 'CPU-G is an application that shows useful information about your hardware.'
  homepage 'https://sourceforge.net/projects/cpug/'
  version '0.9.0'
  source_url 'https://downloads.sourceforge.net/project/cpug/cpu-g-0.9.0.tar.gz'
  source_sha256 '46d490197b46ccabad93bdd3514650fd206d72dbb09a7509356a642c39dd7225'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'pygtk'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,/usr/bin/python,#{CREW_PREFIX}/bin/python,' cpu-g"
    system "sed -i 's,\"cpu-g.glade\",\"#{CREW_PREFIX}/share/cpu_g/cpu-g.glade\",' cpu-g"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/cpu_g/data"
    FileUtils.cp 'cpu-g', "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp 'cpu-g.glade', "#{CREW_DEST_PREFIX}/share/cpu_g"
    FileUtils.cp 'doc/cpu-g.1', "#{CREW_DEST_PREFIX}/share/man/man1"
    FileUtils.cp_r Dir.glob('data/*'), "#{CREW_DEST_PREFIX}/share/cpu_g/data"
  end

  def self.postinstall
    puts
    puts "Type 'cpu-g' to get started.".lightblue
    puts
  end
end
