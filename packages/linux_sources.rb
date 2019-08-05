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
      when '3.10'
        sha256 = 'df27fa92d27a9c410bfe6c4a89f141638500d7eadcca5cce578954efc2ad3544'
      when '3.14'
        sha256 = '61558aa490855f42b6340d1a1596be47454909629327c49a5e4e10268065dffa'
      when '3.18'
        sha256 = 'becc413cc9e6d7f5cc52a3ce66d65c3725bc1d1cc1001f4ce6c32b69eb188cbd'
      when '3.8.11'
        sha256 = '53d8f2c11b63a07807ddabd2b51ee7e91a0ed6a1abceeea422ac2cd0e5923fa3'
      when '4.14'
        sha256 = 'f81d59477e90a130857ce18dc02f4fbe5725854911db1e7ba770c7cd350f96a7'
      when '4.4.178'
        sha256 = 'c3598c22b7994b3bebc3059e8ab85bc212c53550eb401baab3f29f8d007a043d'
      else
        sha256 = 'becc413cc9e6d7f5cc52a3ce66d65c3725bc1d1cc1001f4ce6c32b69eb188cbd'
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
