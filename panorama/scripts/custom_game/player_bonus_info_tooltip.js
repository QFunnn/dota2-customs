--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const BannedHeroesContainer = $("#BannedHeroesContainer")
const BannedAbilitiesContainer = $("#BannedAbilitiesContainer")
const ExtraCreepsContainer = $("#ExtraCreepsContainer")

function SetupTooltip(){
    let PlayerID = $.GetContextPanel().GetAttributeString("playerid", "")

    BannedHeroesContainer.RemoveAndDeleteChildren()
    BannedAbilitiesContainer.RemoveAndDeleteChildren()
    ExtraCreepsContainer.RemoveAndDeleteChildren()

    if(PlayerID != undefined && PlayerID != ""){
        let EndData = GetPlayerTablesValue("globals", `player_${PlayerID}_end_data`)
        if(EndData && EndData.player_data){
            for (const _ in EndData.player_data.banned_heroes) {
                let BannedHeroName = EndData.player_data.banned_heroes[_]

                let p = GetOrCreateHero(BannedHeroName)
            }
            for (const _ in EndData.player_data.banned_abilities) {
                let BannedAbilityName = EndData.player_data.banned_abilities[_]

                let p = GetOrCreateAbility(BannedAbilityName)
            }

            let Creeps = {}
            for (const _ in EndData.player_data.extra_creeps) {
                let Info = EndData.player_data.extra_creeps[_]
                Creeps[Info.creep_name] = Creeps[Info.creep_name] != undefined ? Creeps[Info.creep_name] + 1 : Creeps[Info.creep_name] = 1
            }

            for (const CreepName in Creeps) {
                let CreepCount = Creeps[CreepName]

                let p = GetOrCreateExtraCreep(CreepName)

                let ExtraCreature = p.FindChildTraverse("ExtraCreature")
                if(ExtraCreature){
                    ExtraCreature.SetUnit(CreepName, "", true)
                }

                p.SetDialogVariable("creep_name", $.Localize(`#${CreepName}`))
                p.SetDialogVariable("count", CreepCount+"")
            }
        }
    }
}

function GetOrCreateHero(HeroName){
    let f = BannedHeroesContainer.FindChildTraverse(`BannedHero_${HeroName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("DOTAHeroImage", BannedHeroesContainer, `BannedHero_${HeroName}`, {class: "BannedHero", heroname: HeroName})
        return panel
    }
}

function GetOrCreateAbility(AbilityName){
    let f = BannedAbilitiesContainer.FindChildTraverse(`BannedAbility_${AbilityName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("DOTAAbilityImage", BannedAbilitiesContainer, `BannedAbility_${AbilityName}`, {class: "BannedAbility", abilityname: AbilityName})
        return panel
    }
}

function GetOrCreateExtraCreep(CreepName){
    let f = ExtraCreepsContainer.FindChildTraverse(`ExtraCreature_${CreepName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", ExtraCreepsContainer, `ExtraCreature_${CreepName}`, {})
        panel.BLoadLayoutSnippet("Creep")
        return panel
    }
}