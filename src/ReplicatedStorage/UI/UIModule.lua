--[=[
    @class UIModule

    This is the class storing everything used to handle the UI
]=]

local UIModule = {}

--[=[
    Makes an UI appear with a fade effect
    @param ui GUI -- The UI to apply the effect to
    @param Time number -- How long the animation lasts (in seconds)
]=]
function UIModule:FadeIn(ui: GUI, Time: number)
    game:GetService("TweenService"):Create(ui, TweenInfo.new(Time), {Transparency = 0}):Play()
end
--[=[
    Same as [UIModule:FadeIn](/api/UIModule#FadeIn) but does the opposite by making an UI disappear with a fade effect
    @param ui GUI -- The UI to apply the effect to
    @param Time number -- How long the animation lasts (in seconds)
]=]
function UIModule:FadeOut(ui: GUI, Time: number)
    game:GetService("TweenService"):Create(ui, TweenInfo.new(Time), {Transparency = 0}):Play()
end

--[=[
    Closes every UI tagged with "Menu"
]=]
function UIModule:CloseAllMenus()
    local Menus = game:GetService("CollectionService"):GetTagged("Menu")
    for index = 1, #Menus do
        Menus[index].Visible = false
    end
end