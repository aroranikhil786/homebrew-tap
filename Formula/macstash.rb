class Macstash < Formula
  desc "Capture a macOS development environment and rebuild it on another Mac"
  homepage "https://github.com/aroranikhil786/macstash"
  license "Apache-2.0"
  version "0.2.1"

  # A top-level url, with Intel overriding it, rather than both arms nested in
  # `on_macos`. Homebrew validates the formula for every platform it knows,
  # including arm64_linux, and a formula whose only urls live inside on_macos
  # has no url at all there — which it rejects with "formula requires at least
  # a URL", surfaced confusingly as "invalid syntax in tap".
  url "https://github.com/aroranikhil786/macstash/releases/download/v0.2.1/macstash-v0.2.1-darwin-arm64.tar.gz"
  sha256 "5fe8110a47ca44adf52619be85cc2f40bece673754f2fdb11c428ea41177f1cd"

  on_intel do
    url "https://github.com/aroranikhil786/macstash/releases/download/v0.2.1/macstash-v0.2.1-darwin-amd64.tar.gz"
    sha256 "2c21382e447140fb1b475ff918e6995241daf40b1df4327691cd8edbce422cf8"
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
    assert_match "macstash v0.2.1", shell_output("#{bin}/macstash version")
    assert_match "capture", shell_output("#{bin}/macstash help")
  end
end
