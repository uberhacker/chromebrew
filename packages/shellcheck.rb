require 'package'

class Shellcheck < Package
  description 'A static analysis tool for shell scripts'
  homepage 'https://www.shellcheck.net/'
  version '0.7.1'
  #compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/shellcheck-0.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/shellcheck-0.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/shellcheck-0.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/shellcheck-0.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '86741cdf292b5648e1a3fdbb9486979bc3342d0f6f0f5a79065f4fe9c31fab84',
     armv7l: '86741cdf292b5648e1a3fdbb9486979bc3342d0f6f0f5a79065f4fe9c31fab84',
       i686: '2ddbcb86d40f3846b507601851658abadbc76721f416092202a956446add5845',
     x86_64: '1cc886318d2cc56459767902f806bd9c7344374de3b85b402351aa7b7ab8da9b',
  })

  depends_on 'alien' => :build

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'armhf'
      sha256 = 'df4ef730dccab8f94e8b966636d4701deb2a5ab7cc4ad8159ba973622f26ed20'
    when 'i686'
      arch = 'i386'
      sha256 = '77e23e5a72947ecb3101c33bd97f50952434019a261d0427f8614f71f2155692'
    when 'x86_64'
      arch = 'amd64'
      sha256 = '73af08c96b1057c7328716822e5a88f864b77638f2b8f72e4cef38da3717021a'
    end
    package = "shellcheck_#{version}-1~bpo10+1_#{arch}.deb"
    system "wget http://ftp.debian.org/debian/pool/main/s/shellcheck/#{package}"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(package) ) == sha256
    system "alien -tc #{package}"
    system "tar xvf shellcheck-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv 'usr/bin', CREW_DEST_PREFIX
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
  end
end
