--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


const HUD_ROOT = $.GetContextPanel().GetParent().GetParent();

function create_npc_button(t){
    $.Msg("create_npc_button")
    const unitId = t.unit_id
    const new_panel = $.CreatePanel("Panel", HUD_ROOT, "npc_button_" + unitId);
    new_panel.BLoadLayout("s2r://panorama/layout/custom_game/npc_button/npc_button.xml", false, false);
    const new_label = $.CreatePanel("Label", HUD_ROOT, "npc_button_label_" + unitId);
    new_label.text = "Кузнец"
    GameUI.LoopTime.AddTime("HealthBarUpdate", 0, 0, () => {
        $.Msg("update npc_button")
        const worldPos = Entities.GetAbsOrigin(unitId);
        const buttonPos = {
            x: Game.WorldToScreenX(worldPos[0], worldPos[1], worldPos[2]) - 100,
            y: Game.WorldToScreenY(worldPos[0], worldPos[1], worldPos[2]),
        }
        const labelPos = {
            x: Game.WorldToScreenX(worldPos[0], worldPos[1], worldPos[2]) - 100,
            y: Game.WorldToScreenY(worldPos[0], worldPos[1], worldPos[2]),
        }
        new_panel.style.position = `${buttonPos.x}px ${buttonPos.y}px 0px`;
        new_label.style.position = `${labelPos.x}px ${labelPos.y}px 0px`;
    }, false); // false для постоянного выполнения
}


GameEvents.Subscribe( "create_npc_button", create_npc_button)