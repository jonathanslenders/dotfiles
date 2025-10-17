hs.application.enableSpotlightForNameSearches(true)

function app(appname)
    -- Check if the app is running.
    local app = hs.appfinder.appFromName(appname)

    -- Not running -> launch.
    if not app then
        hs.alert.show(appname .." not running")
        hs.application.open(appname)
        return
    end

    -- Running -> bring all windows to front and maximize..
    app:activate()
    local windows = app:allWindows()
    for _, w in pairs(windows) do
        w:raise()
        w:maximize(0)
    end
end

hs.hotkey.bind({"alt"}, "1", function()
    app("Ghostty")
end)


hs.hotkey.bind({"alt"}, "2", function()
    app("Firefox")
end)

hs.hotkey.bind({"alt"}, "3", function()
    app("Google Chrome")
end)

hs.hotkey.bind({"alt"}, "4", function()
    local app = hs.appfinder.appFromName("WebEx")

    if not app then
        hs.alert.show("Lauching WebEx")
        hs.application.open("WebEx")
        return
    end

    app:activate()
    local windows = app:allWindows()
    for _, w in pairs(windows) do
        --w:moveToScreen(hs.screen.find("DELL P2423DE (1)"))
        w:moveToScreen(hs.screen{x=-2,y=0}) -- Two screens left from the primary screen.
        w:raise()
        w:maximize(0)
    end
end)
