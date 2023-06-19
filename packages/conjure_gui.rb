require 'package'

class Conjure_gui < Package
  description 'Apply various ImageMagick commands to your images'
  homepage 'https://github.com/nate-xyz/conjure'
  version '0.1.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/nate-xyz/conjure.git'
  git_hashtag "v#{version}"

  binary_url({
  })
  binary_sha256({
  })

  depends_on 'gtk4'
  depends_on 'pygobject'
  depends_on 'libadwaita'
  depends_on 'imagemagick7'
  depends_on 'appstream_glib'
  depends_on 'desktop_file_utils'

  def self.patch
    # Fix -bash: ./setup.sh: Permission denied
    FileUtils.chmod 0755, %w(setup.sh run.sh)
    # Fix WARNING: Project targets '>= 0.59.0' but uses feature deprecated since '0.55.0'
    system "sed -i 's,.path(),.full_path(),' conjure/meson.build"
    # Abstract prefix directory, if necessary
    system "sed -i 's,_builddir,_builddir --prefix #{CREW_PREFIX},g' conjure/meson.build"
  end

  def self.build
    system './setup.sh && ./run.sh'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C _builddir install"
  end
end
