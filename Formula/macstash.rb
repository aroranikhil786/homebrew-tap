class Macstash < Formula
  desc "Capture a macOS development environment and rebuild it on another Mac"
  homepage "https://github.com/aroranikhil786/macstash"
  license "Apache-2.0"
  version "0.2.9"

  # A top-level url, with Intel overriding it, rather than both arms nested in
  # `on_macos`. Homebrew validates the formula for every platform it knows,
  # including arm64_linux, and a formula whose only urls live inside on_macos
  # has no url at all there — which it rejects with "formula requires at least
  # a URL", surfaced confusingly as "invalid syntax in tap".
  url "https://github.com/aroranikhil786/macstash/releases/download/v0.2.9/macstash-v0.2.9-darwin-arm64.tar.gz"
  sha256 "30c86c39bd4e3854f53bb168327c85ae9917b557a26e7991554e0265fa332e5e"

  on_intel do
    url "https://github.com/aroranikhil786/macstash/releases/download/v0.2.9/macstash-v0.2.9-darwin-amd64.tar.gz"
    sha256 "2fadd5f1c1f2a6b027306abec7302ab3b8ad7e0166c2932525cbf72ffe03fe87"
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
    assert_match "macstash v0.2.9", shell_output("#{bin}/macstash version")
    assert_match "capture", shell_output("#{bin}/macstash help")
  end
end
