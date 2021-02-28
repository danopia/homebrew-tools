class Saml2aws < Formula
  desc "[FORK] Login and retrieve AWS temporary credentials using a SAML IDP"
  homepage "https://github.com/danopia/saml2aws"
  url "https://github.com/danopia/saml2aws.git",
  tag:      "v0.0.1",
  revision: "6c6e0f7bff27ec3b60ca862f086bb5109463ba74"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w -X main.Version=#{version}", "./cmd/saml2aws"
  end

  test do
    assert_match "error building login details: failed to validate account: URL empty in idp account",
      shell_output("#{bin}/saml2aws script 2>&1", 1)
  end
end
