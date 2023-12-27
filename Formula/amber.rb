class Amber < Formula
  desc "Code search / replace tool"
  homepage "https://github.com/dalance/amber"
  url "https://github.com/dalance/amber/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "41908502077197f55ec86b3a4dd4059a78deae9833e9ba33302b1146cc1ec3f5"
  license "MIT"

  bottle do
    root_url "https://github.com/danopia/homebrew-tools/releases/download/amber-0.5.9"
    sha256 cellar: :any_skip_relocation, catalina:     "895e2f1e060704c0316acd2355b8dea41b6fe8b8ca2a4ac5880bf86f970e50ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "63a1abe680e9d58ccd4547e3e51d5566d7db520c777b0c56313fd57c77ffcf94"
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
