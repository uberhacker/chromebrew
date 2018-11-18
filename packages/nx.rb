require 'package'

class Nx < Package
  description 'NoMachine is the fastest and highest quality remote desktop you have ever tried.'
  homepage 'https://www.nomachine.com/'
  version '6.3.6.1'
  case ARCH
  when 'i686'
    source_url 'https://download.nomachine.com/download/6.3/Linux/nomachine_6.3.6_1_i686.tar.gz'
    source_sha256 'c34d32e6874cd8634b96a6844d5bb9790f24e2f2adcc88200ba0264cab71491e'
  when 'x86_64'
    source_url 'https://download.nomachine.com/download/6.3/Linux/nomachine_6.3.6_1_x86_64.tar.gz'
    source_sha256 'adf09afcbc34564927458b00038829a7b002da543754c7d072ade22cbe906580'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    Dir.chdir "NX/etc/NX/server/packages" do
      system "tar xvf nxclient.tar.gz"
      system "tar xvf nxnode.tar.gz"
      system "tar xvf nxplayer.tar.gz"
      system "tar xvf nxserver.tar.gz"
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    Dir.chdir "NX/etc/NX/server/packages" do
      system "mv NX/lib NX/lib64" if ARCH == 'x86_64'
      system "cp -r NX/* #{CREW_DEST_PREFIX}"
    end
  end
end
