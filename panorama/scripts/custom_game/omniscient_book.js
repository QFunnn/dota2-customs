--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MAIN_PANEL = $.GetContextPanel()
let HEROES_INFO = {}
let SelectedHero = ""

const OmniContainer = $("#OmniContainer")
const SelectedHeroImage = $("#SelectedHeroImage")
const SelectedHeroPanel = $("#SelectedHeroPanel")
const AbilitiesContainer = $("#AbilitiesContainer")

GameEvents.Subscribe("builder_show_omniscient", OpenOmniscient);

SubscribeAndFirePlayerTableByKey("globals", "heroes_info", function(v){
    HEROES_INFO = v

    CreateOmniscientMenu()
});

function OpenOmniscient(){
    MAIN_PANEL.AddClass("Show")
}

function HideOmniscient(){
    MAIN_PANEL.ToggleClass("HalfHide")
}

function CloseOmniscient(){
    MAIN_PANEL.RemoveClass("Show")
    MAIN_PANEL.RemoveClass("HalfHide")
}

function CloseOmniscientFull(){
    CloseOmniscient()
    GameEvents.SendCustomGameEventToServer("builder_omniscient_closed", {});
}

function OnPlayerSelectedAbility(AbilityName){
    CloseOmniscient()
    GameEvents.SendCustomGameEventToServer("builder_omniscient_selected", {ability_name:AbilityName});
}

function CreateOmniscientMenu(){
    for (const HeroName in HEROES_INFO) {
		let HeroInfo = HEROES_INFO[HeroName]

		let AttributePanel = GetOrCreateHeroesAttribute(HeroInfo.primary_attribute)

		let Container = AttributePanel.FindChildTraverse("HeroesTabContainer")
		if(Container){
			let HeroPanel = GetOrCreateHero(Container, HeroName)

			HeroPanel.SetPanelEvent("onactivate", function(){
				OnPlayerSelectedHero(HeroName)
			})
		}
	}
	
	for (let i = 0; i < 4; i++) {
		let AttributePanel = GetOrCreateHeroesAttribute(i)
		let Container = AttributePanel.FindChildTraverse("HeroesTabContainer")
		if(Container){
			ReorderPanels(Container, SortFuncHeroes)
		}
	}

	ReorderPanels(OmniContainer, SortFuncAttributes)
}

function OnPlayerSelectedHero(HeroName){
    if(SelectedHero == HeroName){return}

    SelectedHero = HeroName

    SelectedHeroImage.heroname = HeroName

    MAIN_PANEL.SetHasClass("HeroSelected", SelectedHero != "")

    UpdateSelectedHero()

    UpdateHeroes()
}

function UpdateHeroes(){
	for (const HeroName in HEROES_INFO) {
		let HeroInfo = HEROES_INFO[HeroName]

		let AttributePanel = GetOrCreateHeroesAttribute(HeroInfo.primary_attribute)

		let Container = AttributePanel.FindChildTraverse("HeroesTabContainer")
		if(Container){
			let HeroPanel = GetOrCreateHero(Container, HeroName)

			HeroPanel.SetHasClass("Selected", HeroName == SelectedHero)
		}
	}
}

function UpdateSelectedHero(){
	if(SelectedHero == ""){return}

	let HeroInfo = HEROES_INFO[SelectedHero]

	let Num = 0
	for (const _ in HeroInfo.abilities) {
		let AbilityName = HeroInfo.abilities[_]
		let AbilityPanel = GetOrCreateAbility(Num)

		AbilityPanel.CurrentName = AbilityName

		AbilityPanel.SetPanelEvent("onactivate", function(){
			OnPlayerSelectedAbility(AbilityName)
		})

		let Image = AbilityPanel.FindChildTraverse("BanAbilityImage")
		if(Image){
			Image.abilityname = AbilityName
		}

		AbilityPanel.SetPanelEvent('onmouseover', function () {
			$.DispatchEvent("DOTAShowAbilityTooltip", AbilityPanel, AbilityName);
		});
	
		AbilityPanel.SetPanelEvent('onmouseout', function () {
			$.DispatchEvent("DOTAHideAbilityTooltip", AbilityPanel);
		});

		Num++;
	}

	ReorderPanels(AbilitiesContainer, SortFuncAbilities)

	for (let i = 0; i < AbilitiesContainer.GetChildCount(); i++) {
		let Child = AbilitiesContainer.FindChildTraverse(`Ability_${i}`)
		if(Child && (Num-1) < i){
			SafeDeleteAsync(Child)
		}
	}
}

function GetOrCreateHeroesAttribute(attribute){
	let f = OmniContainer.FindChildTraverse(`HeroesAttribute_${attribute}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", OmniContainer, `HeroesAttribute_${attribute}`, {})
		panel.BLoadLayoutSnippet("HeroesTab")

		panel.AddClass(`AttributeNum_${attribute}`)
		panel.SetDialogVariable("attribute_name", $.Localize(`#GAME_Attributes_${attribute}`))

		return panel
	}
}

function GetOrCreateHero(Container, HeroName){
	let f = Container.FindChildTraverse(`Hero_${HeroName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `Hero_${HeroName}`, {})
		panel.BLoadLayoutSnippet("HeroCard")

		let Image = panel.FindChildTraverse("HeroCardImage")
		if(Image){
			Image.heroname = HeroName
		}

		return panel
	}
}

function GetOrCreateAbility(AbilitySlot){
	let f = AbilitiesContainer.FindChildTraverse(`Ability_${AbilitySlot}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", AbilitiesContainer, `Ability_${AbilitySlot}`, {})
		panel.BLoadLayoutSnippet("BanAbility")

		return panel
	}
}
function ReorderPanels(Container, SortFunc){
    var count = Container.GetChildCount()
	if (count > 0) {
		for (var i = 0; i < count; i++) {
            for (var j = i+1; j < count; j++) {
                let prev = Container.GetChild(i);
                let child = Container.GetChild(j);
                if(child != undefined){
                    SortFunc(Container, prev, child);
                }
            }
        }
	}
}

function SortFuncAttributes(Container, a, b){
    let aItemName = a.id.replace("HeroesAttribute_", "")
    let bItemName = b.id.replace("HeroesAttribute_", "")
    if ( aItemName > bItemName )  
	{
        Container.MoveChildBefore(b, a);
	}
    return b
}

function SortFuncHeroes(Container, a, b){
    let aItemName = a.id.replace("Hero_", "")
    let bItemName = b.id.replace("Hero_", "")
    if ( $.Localize(`#${aItemName}`) > $.Localize(`#${bItemName}`) )  
	{
        Container.MoveChildBefore(b, a);
	}
    return b
}

function SortFuncAbilities(Container, a, b){
    let aItemName = a.CurrentName
    let bItemName = b.CurrentName
    if ( $.Localize(`#DOTA_Tooltip_ability_${aItemName}`) > $.Localize(`#DOTA_Tooltip_ability_${bItemName}`) )  
	{
        Container.MoveChildBefore(b, a);
	}
    return b
}