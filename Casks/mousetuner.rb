cask "mousetuner" do
  version "0.1.1"
  sha256 "2f01dc30d23e7227cc61330d7c987273ee532dd6553bbb31c86d59fb2eef2681"

  url "https://github.com/mousetuner/mousetuner/releases/download/v0.1.1/MouseTuner-#{version}.zip",
      verified: "github.com/mousetuner/mousetuner/releases/download/v0.1.1/"
  name "MouseTuner"
  desc "Smooth scrolling, button mapping and Logitech HID++ control for third-party mice"
  homepage "https://github.com/mousetuner/mousetuner"

  livecheck do
    url "https://mousetuner.com/appcast.xml"
    strategy :sparkle
  end

  # 应用自带 Sparkle。不声明的话 brew upgrade 会和 Sparkle 抢着更新同一个 app。
  auto_updates true

  # ADR-0001：最低支持 macOS 13.3。cask 只能按大版本卡，13.0–13.2 会被放进来，
  # 由应用自己的 LSMinimumSystemVersion 拦住。
  depends_on macos: ">= :ventura"

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
