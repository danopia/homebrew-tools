class Amber < Formula
  desc "Code search / replace tool"
  homepage "https://github.com/dalance/amber"
  url "https://github.com/dalance/amber/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "41908502077197f55ec86b3a4dd4059a78deae9833e9ba33302b1146cc1ec3f5"
  license "MIT"

  bottle do
    root_url "https://github.com/danopia/homebrew-tools/releases/download/amber-0.6.0"
    sha256 cellar: :any_skip_relocation, monterey: "cf173cde82ae67b2c7f9e1a18da48903943874af688d81657b380597e0e5260a"
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
    refute_match %r{^\./file3:}, output
  end
end
