--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function UpdateTooltip()
{
    let LeftArrow = $.GetContextPanel().GetParent().FindChildTraverse("LeftArrow")
    let RightArrow = $.GetContextPanel().GetParent().FindChildTraverse("RightArrow")
    let video_name = $.GetContextPanel().GetAttributeString("video_name", "")
    let is_locked = $.GetContextPanel().GetAttributeString("is_locked", "")
    let is_locked_description = $.GetContextPanel().GetAttributeString("is_locked_description", "")
    let BlockHoverPanel = $("#BlockHoverPanel")
    BlockHoverPanel.style.opacity = 0
    if ($.GetContextPanel().LoadingTooltip)
    {
        $.CancelScheduled($.GetContextPanel().LoadingTooltip)
    }

    $.GetContextPanel().style.height = "285px"

    $.GetContextPanel().LoadingTooltip = $.Schedule(0.01, function()
    {
        let TooltipPositionLeft = $.GetContextPanel().GetParent().GetParent().BHasClass("TooltipPositionLeft")
        BlockHoverPanel.style.opacity = 1
        BlockHoverPanel.RemoveAndDeleteChildren()
        BlockHoverPanel.visible = true

        $.GetContextPanel().SetHasClass("BlockHoverPanelLeft", false)
        $.GetContextPanel().SetHasClass("BlockHoverPanelRight", false)
        $.GetContextPanel().SetHasClass(TooltipPositionLeft ? "BlockHoverPanelLeft" : "BlockHoverPanelRight", true)
        LeftArrow.visible = false
        RightArrow.visible = false
        if (is_locked && is_locked == "1")
        {
            let locked_text = $.CreatePanel("Label", BlockHoverPanel, "");
            locked_text.AddClass("locked_text");
            locked_text.text = $.Localize("#"+is_locked_description);
        }
        
        let movie_container = $.CreatePanel("Panel", BlockHoverPanel, "")
        movie_container.AddClass("movie_container")

        let movie_spinner = $.CreatePanel("Panel", movie_container, "movie_spinner")
        movie_spinner.AddClass("movie_spinner")

        var video = $.CreatePanel("MoviePanel", movie_container, 'video', 
        {
            style: "",
            src: video_name,
            repeat: "true",
            hittest: "false",
            autoplay: "onload"
        });
        video.AddClass("BlockHoverPanelVideo")
    })
}