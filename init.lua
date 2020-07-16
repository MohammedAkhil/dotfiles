local hyper = { "cmd", "alt", "ctrl", "shift" }
local dex = {"alt"}
hs.hotkey.bind(hyper, "0", function()
  hs.reload()
end)
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()


hs.window.animationDuration = 0
hs.hotkey.bind(hyper, "h", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToUnit(hs.layout.left50)
end)
hs.hotkey.bind(hyper, "j", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToUnit(hs.layout.maximized)
end)
hs.hotkey.bind(hyper, "k", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToScreen(win:screen():next())
end)
hs.hotkey.bind(hyper, "l", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToUnit(hs.layout.right50)
end)





function pingResult(object, message, seqnum, error)
    if message == "didFinish" then
        avg = tonumber(string.match(object:summary(), '/(%d+.%d+)/'))
        if avg == 0.0 then
            hs.alert.show("No network")
        elseif avg < 200.0 then
            hs.alert.show("Network good (" .. avg .. "ms)")
        elseif avg < 500.0 then
            hs.alert.show("Network poor(" .. avg .. "ms)")
        else
            hs.alert.show("Network bad(" .. avg .. "ms)")
        end
    end
end
hs.hotkey.bind(hyper, "p", function()hs.network.ping.ping("8.8.8.8", 1, 0.01, 1.0, "any", pingResult)end)




local applicationHotkeys = {
    a = 'Google Chrome',
    d = 'iTerm',
    s = 'Visual Studio Code',
    q = 'Notion',
  }
  for key, app in pairs(applicationHotkeys) do
    hs.hotkey.bind(hyper, key, function()
      hs.application.launchOrFocus(app)
    end)
  end

hs.hotkey.bind(hyper, "v", function()hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)



wifiWatcher = nil
homeSSID = "Andrill"
lastSSID = hs.wifi.currentNetwork()
  
  function ssidChangedCallback()
  
      if newSSID == homeSSID and lastSSID ~= homeSSID then
          -- We just joined our home WiFi network
          hs.audiodevice.defaultOutputDevice():setVolume(25)
      elseif newSSID ~= homeSSID and lastSSID == homeSSID then
          -- We just departed our home WiFi network
          hs.audiodevice.defaultOutputDevice():setVolume(0)
      end
  
      lastSSID = newSSID
  end
  
  wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
  wifiWatcher:start()



  local applicationDexHotkeys = {
    a = 'Telegram',
    s = 'Slack',

  }
  for key, app in pairs(applicationDexHotkeys) do
    hs.hotkey.bind(dex, key, function()
      hs.application.launchOrFocus(app)
    end)
  end




hs.hotkey.bind(hyper, "1", function()hs.caffeinate.lockScreen()end)

hs.loadSpoon("SpoonInstall")
Install=spoon.SpoonInstall

Install:andUse("ColorPicker",
               {
                 disable = false,
                 hotkeys = {
                   show = { hyper, "5" }
                 },
                 config = {
                   show_in_menubar = false,
                 },
                 start = true,
               }
)

Install:andUse("KSheet",
               {
                 hotkeys = {
                   toggle = { hyper, "6" }
}})

