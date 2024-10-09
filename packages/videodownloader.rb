require 'package'

class Videodownloader < Package
  description 'Free video downloader'
  homepage 'https://www.4kdownload.com/-54'
  version '4.32.5-1'
  license '© 2024 Open Media'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://dl.4kdownload.com/app/4kvideodownloader_#{version}_amd64.deb"
  source_sha256 '0dbeb39b1808a7e59fe37b830673bf3d0ea7a3cacec882872fe0d12aed7cdeba'

  depends_on 'gtk3'

  no_compile_needed
  no_shrink

  def self.patch
    system "sed -i '3d' lib/4kvideodownloader/4kvideodownloader.sh"
    system "sed -i '3iLD_LIBRARY_PATH=\"/usr/local/lib/4kvideodownloader:\$LD_LIBRARY_PATH\"' lib/4kvideodownloader/4kvideodownloader.sh"
    system "sed -i 's,/usr,#{CREW_PREFIX},g' lib/4kvideodownloader/4kvideodownloader.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
    FileUtils.ln_sf "#{CREW_PREFIX}/lib/4kvideodownloader/4kvideodownloader.sh",
                    "#{CREW_DEST_PREFIX}/bin/4kvideodownloader"
  end

  def self.postinstall
    ExitMessage.add "\nType '4kvideodownloader' to get started.\n"
  end
end
