require 'mkmf-rice'

$CXXFLAGS += ' -std=c++17 $(optflags)'

# change to 0 for Linux pre-cxx11 ABI version
$CXXFLAGS += ' -D_GLIBCXX_USE_CXX11_ABI=1'

apple_clang = RbConfig::CONFIG['CC_VERSION_MESSAGE'] =~ /apple clang/i

if apple_clang
  # silence torch warnings
  $CXXFLAGS += ' -Wno-deprecated-declarations'
else
  # silence rice warnings
  $CXXFLAGS += ' -Wno-noexcept-type'

  # silence torch warnings
  $CXXFLAGS += ' -Wno-duplicated-cond -Wno-suggest-attribute=noreturn'
end

pkg_config('opencv4')

create_makefile 'blankpage/blankpage'
