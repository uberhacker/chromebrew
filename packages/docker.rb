require 'package'

class Docker < Package
  description 'Docker is the company driving the container movement and the only container platform provider to address every application across the hybrid cloud.'
  homepage 'https://www.docker.com/'
  version '17.09.0-ce'
  source_url 'https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz'
  source_sha256 'a9e90a73c3cdfbf238f148e1ec0eaff5eb181f92f35bdd938fd7dab18e1c4647'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cgroupfs_mount'
  depends_on 'iptables'
  depends_on 'libnettle'
  depends_on 'qemu'
  depends_on 'xzutils'

  def self.install
    abort "Docker is only available on x86_64 architecture.".lightred unless ARCH == 'x86_64'
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp * #{CREW_DEST_PREFIX}/bin"
    system "wget -q https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-Linux-x86_64"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('docker-machine-Linux-x86_64') ) == '8f5310eb9e04e71b44c80c0ccebd8a85be56266b4170b4a6ac6223f7b5640df9'
    system "install -Dm755 docker-machine-Linux-x86_64 #{CREW_DEST_PREFIX}/bin/docker-machine"
    system "wget -q https://github.com/jigtools/docker-machine-driver-qemu/releases/download/v0.1.0/default.docker-machine-driver-qemu-Linux-x86_64"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('default.docker-machine-driver-qemu-Linux-x86_64') ) == '7d1e1516ec3dd2122017e5d4d8766cc6dd526f5cf5dfb6b84d3c66c745cd04e5'
    system "install -Dm755 default.docker-machine-driver-qemu-Linux-x86_64 #{CREW_DEST_PREFIX}/bin/docker-machine-driver-qemu"
  end
end
