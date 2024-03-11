require 'package'

class Baobab < Package
  description 'Disk Usage Analyzer (also known as baobab) scans folders, devices or remote locations and and reports on the disk space consumed by each element.'
  homepage 'https://wiki.gnome.org/Apps/DiskUsageAnalyzer'
  version '43.0'
  license 'GPL-2+ and FDL-1.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/baobab/-/archive/43.0/baobab-43.0.tar.bz2'
  source_sha256 'dd1e2c65d4cee3d904d1c127ef700d07b8011a689cde2c3f9de04cdaa1f1df6c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd42ba8dd8345a57b294eed20b6eed797c1a2c75fe87d86640548c8879fef8f2',
     armv7l: 'bd42ba8dd8345a57b294eed20b6eed797c1a2c75fe87d86640548c8879fef8f2',
     x86_64: 'ee45c716382ad00b465ee704f10f266712239d7426098cdeb780f7a48a57b5e8'
  })

  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'itstool' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'gtk4' # R
  depends_on 'libadwaita' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
