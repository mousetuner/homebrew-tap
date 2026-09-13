cask "mousetuner" do
  version "0.2.0"
  sha256 "a76dc92fc459cf767dc9d3908ae41cab4f0c4d889c1b5b559784aaf4013d2532"

  url "https://github.com/mousetuner/mousetuner/releases/download/v0.2.0/MouseTuner-#{version}.zip"
  name "MouseTuner"
  desc "Smooth scrolling, button mapping and Logitech HID++ control for third-party mice"
  homepage "https://github.com/mousetuner/mousetuner"

  livecheck do
    url "https://mousetuner.com/appcast.xml"
    strategy :sparkle
  end

  # 应用自带 Sparkle。不声明的话 brew upgrade 会和 Sparkle 抢着更新同一个 app。
  auto_updates true

  # ADR-0001：最低支持 macOS 15，与应用的 LSMinimumSystemVersion 一致，brew audit --online
  # 会比对这两处。符号写法本身就是「该版本及以上」，">= :sequoia" 的字符串写法已被废弃。
  depends_on macos: :sequoia

  app "MouseTuner.app"

  zap trash: [
    "~/Library/Application Support/MouseTuner",
    "~/Library/Application Support/com.mousetuner.MouseTuner",
    "~/Library/Caches/com.mousetuner.MouseTuner",
    "~/Library/HTTPStorages/com.mousetuner.MouseTuner",
    "~/Library/Preferences/com.mousetuner.MouseTuner.plist",
    "~/Library/Saved Application State/com.mousetuner.MouseTuner.savedState",
  ]

  caveats <<~EOS
    MouseTuner needs Accessibility permission on first launch.

    Uninstalling does not remove the license credential or the trial record from your
    login keychain. This is intentional: reinstalling keeps your activation. To remove
    them, open Keychain Access and delete the "com.mousetuner.MouseTuner" entries.
  EOS
end
