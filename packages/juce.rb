require 'package'

class Juce < Package
  description 'JUCE is an open-source cross-platform C++ application framework used for rapidly developing high quality desktop and mobile applications'
  homepage 'https://juce.com/'
  version '5.4.1'
  case ARCH
  when 'x86_64'
    source_url 'https://d30pueezughrda.cloudfront.net/juce/juce-5.4.1-linux.zip'
    source_sha256 'd0501af669d927ae8a4760c27b6055cff7d6912e8611c09bd051fa714f230cb1'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/juce"
  end

  def self.install
    system "cp -r . #{CREW_DEST_PREFIX}/share/juce"
    system "ln -s #{CREW_PREFIX}/share/juce/Projucer #{CREW_DEST_PREFIX}/bin/projucer"
  end
end
