require 'buildsystems/pip'

class Py3_radio_active < Pip
  description 'Play and record any radio stations around the globe right from the terminal.'
  homepage 'https://github.com/deep5050/radio-active'
  version "2.9.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a678a6c88e3634a7231d74744e72fc0763c5784f3d7839fb3d30c5695beb5530',
     armv7l: 'a678a6c88e3634a7231d74744e72fc0763c5784f3d7839fb3d30c5695beb5530',
     x86_64: 'de16c9fdcb54a77f3242c9a09d0da4175b57c8557a85027f6a30111007db4c50'
  })

  depends_on 'ffmpeg'
  depends_on 'python3' => :build

  no_source_build

  def self.postinstall
    ExitMessage.add "\nType 'radio --help' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.radio-active-configs.ini")
    Package.agree_to_remove("#{HOME}/.radio-active-last-station")
  end
end
