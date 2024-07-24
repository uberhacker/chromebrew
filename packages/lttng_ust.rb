require 'buildsystems/autotools'

class Lttng_ust < Autotools
  description 'Linux Trace Toolkit: next generation is a modern toolkit for tracing Linux systems and applications.'
  homepage 'https://lttng.org/'
  version '2.13.8'
  license 'LGPL-2.1-only, MIT, GPL-2.0-only, GPL-3.0-or-later, BSD-2-Clause, BSD-3-Clause'
  compatibility 'all'
  source_url 'https://github.com/lttng/lttng-ust.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9677336d0654e566fb3769176570cbb988b04eb1205bfd6910fe77d2fda0a313',
     armv7l: '9677336d0654e566fb3769176570cbb988b04eb1205bfd6910fe77d2fda0a313',
       i686: '5377227f36450235d9c7fc52b50035582665ed35d0ffc94929fa558211851ab5',
     x86_64: '28e0b2bfe70850e9c145f4a7e9b5ee928ae5c8b840bb288dbb497c78bd6172a3'
  })

  depends_on 'liburcu'
  depends_on 'numactl'

  configure_options '--disable-man-pages'

  # FAIL: regression/abi0-conflict/test_abi0_conflict 10 - dlopen: no-ust app with abi1 and abi1 succeeds
  # regression/abi0-conflict/test_abi0_conflict: Failed test 'dlopen: no-ust app with abi1 and abi1 succeeds'
  # regression/abi0-conflict/test_abi0_conflict: in ./regression/abi0-conflict/test_abi0_conflict:main() at line 100.
  # run_tests
end
