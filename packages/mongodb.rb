require 'package'

class Mongodb < Package
  description 'MongoDB is the next-generation database that lets you create applications never before possible.'
  homepage 'https://www.mongodb.com/'
  version '4.0.10'
  source_url 'https://fastdl.mongodb.org/src/mongodb-src-r4.0.10.tar.gz'
  source_sha256 '11c9c55f1145ac1b6f757ff74f969d41cf47044191b3b0f3fee77f333b8f4f8d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' => :build

  def self.build
    system 'pip install -r buildscripts/requirements.txt'
    system 'python buildscripts/scons.py all'
  end

  def self.install
    system "python buildscripts/scons.py --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR} install"
  end
end
