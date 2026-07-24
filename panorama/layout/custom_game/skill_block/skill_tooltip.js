--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let SKILLS_LIST_TABLE = {}
let PLAYERS_SKILLS_INFO = {}
SubscribeAndFireNetTableByKey("globals", `skills_info`, function(v){
    SKILLS_LIST_TABLE = v
})

for (const PlayerID of Game.GetAllPlayerIDs()) {
    SubscribeAndFirePlayerTableByKey(`player_${PlayerID}_global`, `skills`, function(v){
        PLAYERS_SKILLS_INFO[PlayerID] = v
    })
}

function UpdateTooltip()
{
    $("#SpellBlock").RemoveAndDeleteChildren()
    let player_id = Number($.GetContextPanel().GetAttributeString("player_id", "-1"))
    if(PLAYERS_SKILLS_INFO[player_id]){
        for (const SkillName in PLAYERS_SKILLS_INFO[player_id]) {
            if(SKILLS_LIST_TABLE[SkillName]){
                SpawnBlock(SkillName, player_id)
            }
        }
    }
}

function SpawnBlock(name, player_id)
{
    let Info = SKILLS_LIST_TABLE[name]
    let PlayerInfo = PLAYERS_SKILLS_INFO[player_id][name]
    let main = $("#SpellBlock")

    let line = $.CreatePanel("Panel", main, "")
    line.AddClass("line")

    let image = $.CreatePanel("Panel", line, "")
    image.AddClass("image")
    image.style.backgroundImage = 'url("file://{images}/items/' + Info.icon + '.png")';
    image.style.backgroundSize = "100%"

    let info_text = $.CreatePanel("Label", line, "")
    info_text.AddClass("info_text")
    info_text.html = true

    let Value = Info.value * PlayerInfo

    let Pct = ""
    if(Info.is_percent == 1){
        Pct = "%"
    }

    let SkillDesc = `<font color='gold'>${ModifyPlus(Value)}${Pct}</font>${$.Localize(`#SKILL_${name}_desc`)}`

    info_text.text = SkillDesc
}

function ModifyPlus(num)
{
    if (num > 0)
    {
        return "+"+num
    }
    return num
}