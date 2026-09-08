class Macstash < Formula
  desc "Capture a macOS development environment and rebuild it on another Mac"
  homepage "https://github.com/aroranikhil786/macstash"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aroranikhil786/macstash/releases/download/v0.1.0/macstash-v0.1.0-darwin-arm64.tar.gz"
      sha256 "c66146b0608c4f0bdcfdad4885772fea0155db7fb26f885ec6d85d382dfca092"
    end

    on_intel do
      url "https://github.com/aroranikhil786/macstash/releases/download/v0.1.0/macstash-v0.1.0-darwin-amd64.tar.gz"
      sha256 "9f9d6b94bb2caba82a49988dfde7be80c858d06fd6da9801375dee0883661202"
    end
  end

  def install
    bin.install Dir["macstash-*"].first => "macstash"
  end

  test do
    # Asserted literally rather than through #{version}: the release script
    # embeds the git tag, so the binary reports "v0.1.0" while Homebrew scans
    # "0.1.0" from the URL, and interpolating would double the v.
    assert_match "macstash v0.1.0", shell_output("#{bin}/macstash version")
    # `capture` is deliberately not exercised here: it re-executes itself under
    # sandbox-exec and walks the whole home directory, neither of which belongs
    # in a formula test.
    assert_match "capture", shell_output("#{bin}/macstash help")
  end
end
