class Macstash < Formula
  desc "Capture a macOS development environment and rebuild it on another Mac"
  homepage "https://github.com/aroranikhil786/macstash"
  license "Apache-2.0"
  version "0.1.0"

  # A top-level url, with Intel overriding it, rather than both arms nested in
  # `on_macos`. Homebrew validates the formula for every platform it knows,
  # including arm64_linux, and a formula whose only urls live inside on_macos
  # has no url at all there — which it rejects with "formula requires at least
  # a URL", surfaced confusingly as "invalid syntax in tap".
  url "https://github.com/aroranikhil786/macstash/releases/download/v0.1.0/macstash-v0.1.0-darwin-arm64.tar.gz"
  sha256 "c66146b0608c4f0bdcfdad4885772fea0155db7fb26f885ec6d85d382dfca092"

  on_intel do
    url "https://github.com/aroranikhil786/macstash/releases/download/v0.1.0/macstash-v0.1.0-darwin-amd64.tar.gz"
    sha256 "9f9d6b94bb2caba82a49988dfde7be80c858d06fd6da9801375dee0883661202"
  end

  # macstash reads macOS preference domains, TCC requirements and Homebrew
  # state, and sandboxes itself with sandbox-exec. There is nothing to port.
  depends_on :macos

  def install
    bin.install Dir["macstash-*"].first => "macstash"
  end

  test do
    # Asserted literally rather than through #{version}: the release script
    # embeds the git tag, so the binary reports "v0.1.0" while the formula
    # version is "0.1.0", and interpolating would double the v.
    assert_match "macstash v0.1.0", shell_output("#{bin}/macstash version")
    assert_match "capture", shell_output("#{bin}/macstash help")
  end
end
