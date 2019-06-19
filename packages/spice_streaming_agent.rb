require 'package'

class Spice_streaming_agent < Package
  description 'Spice Streaming Agent is a guest-side daemon which captures the guest video output, encodes it to a video stream and forwards the resulting stream to the host to be sent through SPICE.'
  homepage 'https://www.spice-space.org/'
  version '0.2'
  source_url 'https://spice-space.org/download/releases/spice-streaming-agent/spice-streaming-agent-0.2.tar.xz'
  source_sha256 '1f09c4e17ad237a712290354cd4d1468cef1c3977911d93dd40034ef618afedb'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libjpeg_turbo'
  depends_on 'libx11'
  depends_on 'spice_protocol'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
