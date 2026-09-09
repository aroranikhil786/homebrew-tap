class Macstash < Formula
  desc "Capture a macOS development environment and rebuild it on another Mac"
  homepage "https://github.com/aroranikhil786/macstash"
  license "Apache-2.0"
  version "0.2.7"

  # A top-level url, with Intel overriding it, rather than both arms nested in
  # `on_macos`. Homebrew validates the formula for every platform it knows,
  # including arm64_linux, and a formula whose only urls live inside on_macos
  # has no url at all there — which it rejects with "formula requires at least
  # a URL", surfaced confusingly as "invalid syntax in tap".
  url "https://github.com/aroranikhil786/macstash/releases/download/v0.2.7/macstash-v0.2.7-darwin-arm64.tar.gz"
  sha256 "0f717b20bc5c2f1fa9b6e01db7ce5bfa8e19b08a1a67564c2a101ea5f7352354"

  on_intel do
    url "https://github.com/aroranikhil786/macstash/releases/download/v0.2.7/macstash-v0.2.7-darwin-amd64.tar.gz"
    sha256 "1f13c0b4ecb12a1bd2cfc9678f110d8014234ec4c0fe74f0a49142b650503dd8"
  end

  # macstash reads macOS preference domains, TCC requirements and Homebrew
  # state, and sandboxes itself with sandbox-exec. There is nothing to port.
  depends_on :macos

  def install
    bin.install Dir["macstash-*"].first => "macstash"
  end

  test do
    # Asserted literally rather than through #{version}: the release script
    # embeds the git tag, so the binary reports a leading "v" that the formula
    # version does not carry, and interpolating would double it.
    assert_match "macstash v0.2.7", shell_output("#{bin}/macstash version")
    assert_match "capture", shell_output("#{bin}/macstash help")
  end
end
