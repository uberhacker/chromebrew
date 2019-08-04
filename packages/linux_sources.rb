require 'package'

class Linux_sources < Package
  description 'Sources for the Linux kernel'
  homepage 'https://kernel.org/'
  version '3.x-4.x'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.install
    linux_ver = "linux-#{KERNEL_VERSION}"
    source_url = "https://www.kernel.org/pub/linux/kernel/v#{KERNEL}/#{linux_ver}.tar.xz"
    src_dir = CREW_DEST_PREFIX + '/src'
    FileUtils.mkdir_p src_dir
    Dir.chdir src_dir do
      system "wget #{source_url}"
      case KERNEL_VERSION
      when '3.18'
      when '4.4.178'
        sha256 = 'c3598c22b7994b3bebc3059e8ab85bc212c53550eb401baab3f29f8d007a043d'
      end
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{linux_ver}.tar.xz") ) == sha256
      system "tar xvf #{linux_ver}.tar.xz"
      FileUtils.mv "#{linux_ver}", 'linux'
      Dir.chdir 'linux' do
        system 'make', 'defconfig'
      end
    end
  end
end
