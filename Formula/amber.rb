class Amber < Formula
  desc "Code search / replace tool"
  homepage "https://github.com/dalance/amber"
  url "https://github.com/dalance/amber/archive/v0.5.8.tar.gz"
  sha256 "f12e0b176273e011209e7d8613d1b9a049e50aeb536871c1f6c05a9d6a494935"
  license "MIT"

  bottle do
    root_url "https://github.com/danopia/homebrew-tools/releases/download/amber-0.5.8"
    cellar :any_skip_relocation
    sha256 "d2ef27cd229b78214c6118bb3c67475afe053b80615108462b80fc8f01814abd" => :catalina
    sha256 "34da1faac58eea246a55fda73f1182bbb069f085799d37f3668356e4b23a8f50" => :x86_64_linux
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    # Create three dummy files
    (testpath/"file1").write "foo\nbar\nqux"
    (testpath/"file2").write "bar\nabc"
    (testpath/"file3").write "baz"

    # Ensure `ambs bar` finds two of the files
    # (Amber exits silently with status 1 when TERM=dumb)
    output = shell_output("env TERM=xterm #{bin}/ambs --no-color bar")
    # Checking individual lines to be ordering agnostic
    assert_match %r{^\./file1:bar$}, output
    assert_match %r{^\./file2:bar$}, output
    assert_no_match %r{^\./file3:}, output
  end
end
