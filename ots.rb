class Ots < Formula
  desc "OpenType Sanitiser parses validates & sanitizes OpenType & WOFF2 font files"
  homepage "https://github.com/khaledhosny/ots"
  url "https://github.com/khaledhosny/ots/releases/download/v7.0.0/ots-7.0.0.tar.gz"
  sha256 "3099c8960c1cf616941b589ba402fd9b46a1f2aeec86b541e22063eece8b5f13"

  head "https://github.com/khaledhosny/ots.git"

  depends_on "autoconf"   => :build
  depends_on "automake"   => :build
  depends_on "libtool"    => :build
  depends_on "pkg-config" => :build
  depends_on "freetype"   => :optional

  def install
    if build.with? "freetype"
      ENV.prepend_path "PKG_CONFIG_PATH", Formula["freetype"].opt_lib/"pkgconfig"
    end

    system "./autogen.sh" if build.head?
    system "./configure"
    system "make", "CXXFLAGS=-DOTS_DEBUG"

    bin.install "ots-sanitize"
    bin.install "ots-perf"
    bin.install "ots-idempotent"
    bin.install "ots-validator-checker"
    bin.install "ots-side-by-side" if build.with? "freetype"
  end

  test do
    system "ots-sanitize", "--version"
  end
end
