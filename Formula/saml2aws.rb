class Saml2aws < Formula
  desc "[FORK] Login and retrieve AWS temporary credentials using a SAML IDP"
  homepage "https://github.com/danopia/saml2aws"
  url "https://github.com/danopia/saml2aws.git",
  tag:      "v0.0.1",
  revision: "6c6e0f7bff27ec3b60ca862f086bb5109463ba74"
  license "MIT"

  bottle do
    root_url "https://github.com/danopia/homebrew-tools/releases/download/saml2aws-0.0.1"
    sha256 cellar: :any_skip_relocation, catalina:     "d74f2e5303c3d6283b4d3fef1c75c2571c50cff3f0ff83fcaef100284e2d6d5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bcfab6ce9d566cec16cf03987de9e06a0ffb4e2dc8d0ad3e09a325c2c975d8ae"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w -X main.Version=#{version}", "./cmd/saml2aws"
  end

  test do
    assert_match "error building login details: failed to validate account: URL empty in idp account",
      shell_output("#{bin}/saml2aws script 2>&1", 1)
  end
end
