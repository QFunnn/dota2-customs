--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MAIN_PANEL = $.GetContextPanel()
let LocalPID = Players.GetLocalPlayer()
let DotaHud = GetDotaHud()

//LOADING STATE
const mainList = $("#mainList")
const PlayerLists = $("#PlayerLists")

let NetTableSubs = []

//SETTINGS STATE

const VoteBody = $("#VoteBody")
const VotesList = $("#VotesList")
const VoteHeaderTimerLabel = $("#VoteHeaderTimerLabel")
let LastTimeTimerSettings = 0
let TimerScheduleSettings = -1
let LastTimerNumSettings = 0

let VOTES = {
    SETTINGS_STATE: {},
    INIT_REROLLS: {},
    INIT_LIFES: {},
    SSS_COUNT_FIRST: {},
    FIRST_ABILITY_IS_GENERAL: {},
    HAS_SKILLS_SELECT: {},
    CREEP_BONUS_ARMOR: {},
    CREEP_BONUS_MAGIC_RESISTANCE: {},
    ROUND_WHEN_LOSE_AEGIS: {},
    ROUND_WHEN_CAN_SUMMON_CREEPS: {},
}

const VOTE_CATEGORIES = {
    INIT_REROLLS: "CategoryPlayerVotes",
    INIT_LIFES: "CategoryPlayerVotes",
    SSS_COUNT_FIRST: "CategoryAbilitiesVotes",
    FIRST_ABILITY_IS_GENERAL: "CategoryAbilitiesVotes",
    HAS_SKILLS_SELECT: "CategorySkillsVotes",
    CREEP_BONUS_ARMOR: "CategoryCreepsVotes",
    CREEP_BONUS_MAGIC_RESISTANCE: "CategoryCreepsVotes",
    ROUND_WHEN_LOSE_AEGIS: "CategoryRoundsVotes",
    ROUND_WHEN_CAN_SUMMON_CREEPS: "CategoryRoundsVotes",
}

const CustomCategories = $("#CustomCategories")

function GetVoteContainer(VoteName){
    let categoryId = VOTE_CATEGORIES[VoteName]
    if(categoryId){
        let cat = $(`#${categoryId}`)
        if(cat) return cat
    }
    return VotesList
}

const ResultsContainer = $("#ResultsContainer")
const ResultsTime = $("#ResultsTime")
const Results = $("#Results")

let LastTimeResultsTimer = 0
let LastTimerResultsNum = 0
let ResultsTimerSchedule = -1

//PICK STATE
const PickState = $("#PickState")
const CurrentBannedListHeroes = $("#CurrentBannedListHeroes")
const CurrentBannedListAbilities = $("#CurrentBannedListAbilities")
const PickHeroesContainer = $("#PickHeroesContainer")

let CurrentRandomHeroes = {}
let bOnce = false

let RerollPriceDefault = 20
let RerollPriceLockedHero = 50

//BANS STATE
const HeroesContainer = $("#HeroesContainer");
const StateSwitchMsg = $("#StateSwitchMsg");
const SelectedHeroImagePanel = $("#SelectedHeroImagePanel");
const SelectedHeroImage = $("#SelectedHeroImage");
const AbilitiesContainer = $("#AbilitiesContainer");
const MakeBanButton = $("#MakeBanButton");
const MakeRandomBansButton = $("#MakeRandomBansButton");
const BanState = $("#BanState");
const BannedListHeroes = $("#BannedListHeroes");
const BannedListAbilities = $("#BannedListAbilities");
const PopularBannedListHeroes = $("#PopularBannedListHeroes");
const PopularBannedListAbilities = $("#PopularBannedListAbilities");

const BanButtons = $("#BanButtons")
const Pages = $("#Pages")
const InfoContainerAbilitiesCategoriesList = $("#InfoContainerAbilitiesCategoriesList")
const InfoContainerHeroesCategoriesList = $("#InfoContainerHeroesCategoriesList")
const InfoContainerAbilitiesList = $("#InfoContainerAbilitiesList")
const InfoContainerHeroesList = $("#InfoContainerHeroesList")

let HEROES_INFO = {};
let ABILITIES_INFO = {};
let BANS_INFO = {};
let SelectedBanHero = "";

let SelectedToBan = undefined
let SelectedToBanType = undefined

let LocalPlayerBanInfo = {}
let LocalPlayerPopularBans = {}

let TimerSchedule = -1
let LastTimeTimer = 0;
let CurrentState = "PLAYERS_LOADING";
let Subscribes = [];
let PlayerSubscribes = [];

let CurrentBanInfo = {}

let StateTable = {
	PLAYERS_LOADING: ["PlayerLists", "SocialButtons"],
	SETTINGS: "SettingsState",
	BANS: "BanState",
	HERO_PICK: "PickState",
};

let MsgSchedule = -1;

let SelectedPage = ""

let CATEGORIES = {}

let SelectedCategory = {
	ABILITIES:{
		main: "",
		sub: ""
	},
	HEROES:{
		main: "",
		sub: ""
	}
};

let ChatInput = DotaHud.FindChildTraverse('ChatInput')

// [DEBUG] Мост панорама->сервер: вывод печатается в серверной консоли как [DEBUG-<tag>].
// Использование: GameUI.CustomUIConfig().DebugPrint("MYTAG", "сообщение")  -> [DEBUG-MYTAG] ...
function DebugPrint(tag, msg){
    try { GameEvents.SendCustomGameEventToServer("zxc_debug_print", {tag: tag, line: "" + msg}); } catch(e){}
}
GameUI.CustomUIConfig().DebugPrint = DebugPrint;

var hittestBlocker = DotaHud.FindChildTraverse("SidebarAndBattleCupLayoutContainer");
if (hittestBlocker) 
{
    hittestBlocker.hittest = false;
    hittestBlocker.hittestchildren = false;
    hittestBlocker.style.opacity = "0"
}

let loading_chat = DotaHud.FindChildTraverse('LoadingScreenChat')
let ChatLinesContainer;
let ChatContent;
let ChatEmoticonPicker;
let ChatAutocompletePanel;
if (loading_chat) 
{
    loading_chat.style.width = "300px"
    loading_chat.style.height = "200px"
    loading_chat.style.opacity = "1"
    loading_chat.style.marginBottom = "-90px"
    loading_chat.style.marginLeft = "25px"

	loading_chat.style.transitionDuration = "0s"

	ChatContent = loading_chat.GetChild(0)
	ChatEmoticonPicker = loading_chat.FindChildTraverse("ChatEmoticonPicker")
	ChatAutocompletePanel = loading_chat.FindChildTraverse("ChatAutocompletePanel")

	ChatContent.style.align = "left bottom"

	let ChatHeaderPanel = loading_chat.FindChildTraverse('ChatHeaderPanel')
	if (ChatHeaderPanel) 
	{
		ChatHeaderPanel.style.visibility = "collapse"
	}
	let ChatHelpPanel = loading_chat.FindChildTraverse('ChatHelpPanel')
	if (ChatHelpPanel) 
	{
		ChatHelpPanel.style.visibility = "collapse"
	}
	ChatLinesContainer = loading_chat.FindChildTraverse('ChatLinesContainer')
	if (ChatLinesContainer) 
	{
		ChatLinesContainer.style.height = "50px"
		ChatLinesContainer.style.transitionDuration = "0s"
	}
}

ExpectationLoad()
DOTAStates()
GameEvents.Subscribe( "game_rules_state_change", DOTAStates )

function ChatInputUpdater(){
	if(Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)){
		$.Schedule(0, ChatInputUpdater)
	}

	if(ChatInput && loading_chat){
		loading_chat.SetHasClass("ChatExpanded", ChatInput.BHasKeyFocus())

		if(ChatEmoticonPicker && ChatAutocompletePanel && ChatLinesContainer){
			ChatEmoticonPicker.style.maxHeight = "145px"
			ChatAutocompletePanel.style.maxHeight = "145px"

			if(ChatEmoticonPicker.BHasClass("Visible") || ChatAutocompletePanel.BHasClass("Visible") || loading_chat.BHasClass("ChatExpanded")){
				ChatLinesContainer.style.height = "150px"
				loading_chat.style.marginBottom = "-10.5px"
			}else{
				ChatLinesContainer.style.height = "50px"
				loading_chat.style.marginBottom = "-90px"
			}
		}
	}
}

function DOTAStates(){
	// [A50/reconnect] Реконнект в СЕРЕДИНЕ игры: движок не убирает кастомный загрузочный
	// экран, пока не заспавнится локальный герой. Если герой мёртв/на респавне/подменён на
	// минииг-юнит (voting-раунд) — лоадинг-скрин висит поверх, хотя игра уже идёт (слышны
	// звуки, работает `say`). Прячем корень сами, когда игра уже в бою (>= PRE_GAME); нормальный
	// пик/бан не трогаем — там состояние CUSTOM_GAME_SETUP/HERO_SELECTION/STRATEGY_TIME.
	if(Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_STRATEGY_TIME)){
		$.GetContextPanel().style.visibility = "collapse"
		return
	}
	if(Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP)){
		ChatInputUpdater()
		LocalPID = Players.GetLocalPlayer()
		if(loading_chat) {
			loading_chat.style.marginLeft = "5px"
		}
		
		let Sub = SubscribeAndFireNetTableByKey("globals", "ban_info", function(v){
			CurrentBanInfo.heroes = toArray(v.heroes)
			CurrentBanInfo.abilities = toArray(v.abilities)
		});
		Subscribes.push(Sub)

		Sub = SubscribeAndFirePlayerTableByKey("globals", "heroes_info", function(v){
			HEROES_INFO = v
	
			StartBans()
		});
		PlayerSubscribes.push(Sub)

		Sub = SubscribeAndFirePlayerTableByKey("globals", "abilities_info", function(v){
			ABILITIES_INFO = v
		});
		PlayerSubscribes.push(Sub)

		Sub = SubscribeAndFirePlayerTableByKey("globals", "bans_categories", function(v){
			CATEGORIES = v
	
			SetupCategories()
		});
		PlayerSubscribes.push(Sub)
	
		Sub = SubscribeAndFireNetTableByKey("globals", "current_state", function(v){
			LastTimeTimer = v.last_time
			CurrentState = v.state_name

			if(TimerSchedule != -1){
				$.CancelScheduled(TimerSchedule)
				TimerSchedule = -1
			}

			UpdateTimer()

			// if(!Game.IsInToolsMode()){
				ShowCurrentStateMsg()

				CloseStates()
			// }

			if(CurrentState == "BANS"){
				SelectPage("Default")

				SelectCategory("ABILITIES", "SSS")
				SelectCategory("HEROES", "SSS")
			}
	
			$.Schedule(2, function(){
				SwitchStates()
			})
		});
		Subscribes.push(Sub)

		Sub = SubscribeAndFireNetTableByKey("globals", "current_game_settings", function(v){
			if(CurrentState == "SETTINGS"){
				SetupVoteResults(v)
			}
		});
		Subscribes.push(Sub)

		Sub = SubscribeAndFireNetTableByKey("globals", "current_state_time", function(v){
			LastTimeResultsTimer = v.last_time

			if(ResultsTimerSchedule != -1){
				$.CancelScheduled(ResultsTimerSchedule)
				ResultsTimerSchedule = -1
			}

			UpdateResultsTimer()
		});
		Subscribes.push(Sub)
		

		Sub = SubscribeAndFireNetTableByKey("players_server_info", `player_${LocalPID}`, function(v){
			let Table = {
				heroes: v.favorite_ban_heroes,
				abilities: v.favorite_ban_abilities,
			}
			LocalPlayerPopularBans = Table
			UpdatePopularBans()
			UpdateInfoLists("ABILITIES")
			UpdateInfoLists("HEROES")
			UpdateHeroes()
			UpdateSelectedHero()

			if(BANS_INFO != {}){
				UpdateBansTable(BANS_INFO)
			}

			MAIN_PANEL.SetHasClass("IsLocalPlayerSubscribed", IsPlayerBattlePassSubscribedInTable(v))

			let PlayerCoins = 0
			if(v && v.profile && v.profile.coins != undefined){
				PlayerCoins = v.profile.coins
			}
			MAIN_PANEL.SetDialogVariable("player_coins", PlayerCoins)
		});
		Subscribes.push(Sub)

		Sub = SubscribeAndFireNetTableByKey("globals", "ban_info", function(v){
			UpdateHeroes()
			UpdateSelectedHero()
			UpdatePopularBans()

			BANS_INFO = v

			UpdateBansTable(v)
			UpdatePickBansTable(v)

			UpdateInfoLists("ABILITIES")
			UpdateInfoLists("HEROES")
		});
		Subscribes.push(Sub)

		Sub = SubscribeAndFirePlayerTableByKey(`player_${LocalPID}_global`, `ban_info`, function(v){
			LocalPlayerBanInfo = v

			UpdateBanInfo()

			let bDisabled = (v.used_random_bans == 1 || v.banned_atleast_one_time == 1)

			MakeRandomBansButton.SetHasClass("Disabled", bDisabled)
		});
		PlayerSubscribes.push(Sub)

		Sub = SubscribeAndFirePlayerTableByKey(`player_${LocalPID}_global`, `builder_info`, function(v){
			if(JSON.stringify(CurrentRandomHeroes) != JSON.stringify(v.random_heroes) || v.selected_hero != ""){
				CurrentRandomHeroes = v.random_heroes
				DeleteAllChildren(PickHeroesContainer)
			}
			$.Schedule(0.1, function(){
				UpdatePick(v)
			})
		});
		PlayerSubscribes.push(Sub)

		// Settings State

		for (const VOTE_NAME in VOTES) {
			Sub = SubscribeAndFireNetTableByKey("globals", `vote_${VOTE_NAME}_settings`, function(v){
				VOTES[VOTE_NAME] = v
				CreateVote(VOTE_NAME, v)
			})
			Subscribes.push(Sub)

			Sub = SubscribeAndFireNetTableByKey("globals", `vote_${VOTE_NAME}_info`, function(v){
				UpdateVote(VOTE_NAME, v)
			})
			Subscribes.push(Sub)
		}


	}else if(Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP)){
		for (const Sub of Subscribes) {
			CustomNetTables.UnsubscribeNetTableListener(Sub)
		}
		Subscribes = []

        for (const Sub of NetTableSubs) {
            CustomNetTables.UnsubscribeNetTableListener(Sub)
        }
        NetTableSubs = []

		for (const Sub of PlayerSubscribes){
			if(Sub != -1){
				UnsubscribeFromPlayerTable(Sub)
			}
		}
		PlayerSubscribes = []
	}
}

function SetupVoteResults(ResultsData){
	ResultsContainer.RemoveAndDeleteChildren()

	Results.RemoveClass("Show")
	Results.AddClass("Show")

	Game.EmitSound("Creep.Sended")

	let delay = 0.15;

	let Array = toArray(ResultsData)
	Array.sort((a, b)=>{
		let aLoc = $.Localize(`#SETTINGS_VALUE_${a.name}`)
		let bLoc = $.Localize(`#SETTINGS_VALUE_${b.name}`)

		if(aLoc > bLoc){
			return 1
		}else if(aLoc < bLoc){
			return -1
		}

		return 0
	})
    if(Array){
        for (const SettingInfo of Array) {
			let p = GetOrCreateVoteResult(SettingInfo.name)

			$.Schedule( delay, function(){
				if(p && p.IsValid()){
					p.AddClass("DelayedShow")
					Game.EmitSound("Draft.PickMade")
				}
			} )
			delay += 0.15;

			p.SetDialogVariable("result_name", $.Localize(`#SETTINGS_VALUE_${SettingInfo.name}`))

            let Value = SettingInfo.value % 1 === 0  ?  SettingInfo.value :  SettingInfo.value.toFixed(2)
			Value = parseFloat(Value)

			let OptionText = `#VOTES_LIST_${SettingInfo.name}_${Value}`
			let OptionName = $.Localize(OptionText)

			if(OptionText == OptionName){
				OptionName = Value + ""
			}

			p.SetDialogVariable("result_value", OptionName)
        }
    }
}

function UpdateResultsTimer(){
    let RawDif = LastTimeResultsTimer - Game.GetGameTime()
    let Diff = Math.max(Math.ceil(Math.abs(RawDif)), 0)

    if(LastTimeResultsTimer > 0 && RawDif > 0){
		ResultsTimerSchedule = $.Schedule(0.2, UpdateResultsTimer)
	}else{
		ResultsTime.RemoveClass("Warning")
	}

	ResultsTime.SetDialogVariable("results_time", GetTimeString(Diff))

	ResultsTime.SetHasClass("Warning", Diff <= 10)

	if(Diff <= 5 && LastTimerResultsNum != Diff){
		LastTimerResultsNum = Math.ceil(Diff)
		Game.EmitSound("Tutorial.TaskProgress")
	}
}

function GetOrCreateVoteResult(Result){
	let f = ResultsContainer.FindChildTraverse(`Result_${Result}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", ResultsContainer, `Result_${Result}`, {})
		panel.BLoadLayoutSnippet("ResultRow")

		return panel
	}
}

function CreateVote(VoteName, v){
    let Instance = GetOrCreateVoteInstance(GetVoteContainer(VoteName), VoteName)

    Instance.SetDialogVariable("instance_name", $.Localize(`#VOTES_LIST_${VoteName}`))
    Instance.SetDialogVariable("instance_desc", $.Localize(`#VOTES_LIST_${VoteName}_desc`))

	let VoteInstanceInfo = Instance.FindChildTraverse("VoteInstanceInfo")
	if(VoteInstanceInfo){
		VoteInstanceInfo.SetPanelEvent('onmouseover', function() {
			$.DispatchEvent('DOTAShowTextTooltip', VoteInstanceInfo, $.Localize(`#VOTES_LIST_${VoteName}_tooltip`)); 
		});
			
		VoteInstanceInfo.SetPanelEvent('onmouseout', function() {
			$.DispatchEvent('DOTAHideTextTooltip', VoteInstanceInfo);
		});
	}

	let bIsMini = v.mini == 1

	Instance.SetHasClass("Mini", bIsMini)

    let Container = Instance.FindChildTraverse("VoteInstanceOptions")
    if(Container){
        for (const _ in v.options) {
            let OptionID = v.options[_]
			if(bIsMini){
				OptionID = OptionID % 1 === 0  ? OptionID : OptionID.toFixed(2)
				OptionID = parseFloat(OptionID)
			}
            let Option = GetOrCreateVoteOption(Container, OptionID)

			let OptionText = `#VOTES_LIST_${VoteName}_${OptionID}`
			let OptionName = $.Localize(OptionText)

			if(bIsMini && OptionText == OptionName){
				OptionName = OptionID + ""
			}

            Option.SetDialogVariable("option_name", OptionName)

			let Text = $.Localize(`#VOTES_LIST_${VoteName}_${OptionID}_desc`)

			if(v.values != undefined && v.values[OptionID] != undefined){
				let OptionValues = v.values[OptionID]
				for (const ValueName in OptionValues) {
					let v = OptionValues[ValueName] % 1 === 0  ? OptionValues[ValueName] : OptionValues[ValueName].toFixed(2)
					Text = Text.replace(`%${ValueName}%`, `<span class="SpecialValue">${v}</span>`)
				}
			}

			Option.SetDialogVariable("option_desc", Text)

            Option.SetDialogVariable("option_count", "0 / 0")
            Option.SetDialogVariable("option_rating", "0%")

            let VoteOptionProgressbar = Option.FindChildTraverse("VoteOptionProgressbar")
            if(VoteOptionProgressbar){
                VoteOptionProgressbar.max = 0
                VoteOptionProgressbar.value = 0
            }

            Option.SetPanelEvent("onactivate", function() {
                Game.EmitSound( "General.ButtonClick" );
                GameEvents.SendCustomGameEventToServer("votes_player_voted", {VoteName:VoteName, Option:OptionID+""});
            })
        }
    }
}

function GetOrCreateVoteInstance(Container, VoteName) {
    let f = Container.FindChildTraverse(`VoteInstance_${VoteName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", Container, `VoteInstance_${VoteName}`, {})
        panel.BLoadLayoutSnippet("VoteInstance")

        return panel
    }
}

function GetOrCreateVoteOption(Container, OptionNum) {
    let f = Container.FindChildTraverse(`Option_${OptionNum}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", Container, `Option_${OptionNum}`, {})
        panel.BLoadLayoutSnippet("VoteOption")

        return panel
    }
}

function UpdateSettingsTimer(){
    let RawDif = LastTimeTimerSettings - Game.GetGameTime()
    let Diff = Math.max(Math.ceil(Math.abs(RawDif)), 0)

    if(LastTimeTimerSettings > 0 && RawDif > 0){
		TimerScheduleSettings = $.Schedule(0.2, UpdateSettingsTimer)
	}else{
		VoteHeaderTimerLabel.RemoveClass("Warning")
	}

	VoteHeaderTimerLabel.SetDialogVariable("timer_time", GetTimeString(Diff))

	VoteHeaderTimerLabel.SetHasClass("Warning", Diff <= 10)

	if(Diff <= 5 && LastTimerNumSettings != Diff){
		LastTimerNumSettings = Math.ceil(Diff)
		Game.EmitSound("Tutorial.TaskProgress")
	}
}

function UpdateVote(VoteName, v) {
    let Settings = VOTES[VoteName]
    let bEnded = v.ended

    let Instance = GetOrCreateVoteInstance(GetVoteContainer(VoteName), VoteName)
    Instance.SetHasClass("Show", bEnded == 0)
    if(bEnded == 1){
        $.Schedule(0.21, ()=>{
            Instance.SetHasClass("ShowVisibility", bEnded == 0)
        })
    }else{
        Instance.SetHasClass("ShowVisibility", bEnded == 0)
    }

    let AllHidden = true
    let HasCustomVote = false
    for (const Name of Object.keys(VOTES)) {
        let Inst = VotesList.FindChildTraverse(`VoteInstance_${Name}`)
        if(Inst && Inst.BHasClass("Show")){
            AllHidden = false
            if(VOTE_CATEGORIES[Name]){
                HasCustomVote = true
            }
        }
    }

    VoteBody.SetHasClass("ShowVotes", AllHidden == false)
    if(CustomCategories){
        CustomCategories.SetHasClass("Show", HasCustomVote)
    }

    if(TimerScheduleSettings != -1){
        $.CancelScheduled(TimerScheduleSettings)
        TimerScheduleSettings = -1
    }

    LastTimeTimerSettings = v.end_time
    if(!AllHidden){
        UpdateSettingsTimer()
    }

    let PlayersVotes = {}
    let PlayersRating = {}
    for (const _ in Settings.options) {
        let OptionID = Settings.options[_]
		OptionID = OptionID % 1 === 0  ? OptionID : parseFloat(OptionID).toFixed(2)
		OptionID = parseFloat(OptionID)

        PlayersVotes[OptionID] = 0
        PlayersRating[OptionID] = 0
    }

    let MaxVotes = 0
	let MaxRating = 0
    for (const PlayerID in v.player_votes) {
        MaxVotes++;
		MaxRating += GetPlayerRating(PlayerID)

		let voted = v.player_votes[PlayerID].voted_option

		voted = voted % 1 === 0  ? voted : parseFloat(voted).toFixed(2)
		voted = parseFloat(voted)

        PlayersVotes[voted]++;
        PlayersRating[voted]+=GetPlayerRating(PlayerID);
    }

	let bShowResults = v.player_votes[LocalPID] != undefined && v.player_votes[LocalPID].can_vote == false
    let LocalPlayerVote = bShowResults ? v.player_votes[LocalPID].voted_option : -1

    for (let OptionID in PlayersVotes) {
		OptionID = OptionID % 1 === 0  ? OptionID : parseFloat(OptionID).toFixed(2)
		OptionID = parseFloat(OptionID)
        let VotedCount = PlayersVotes[OptionID]
        let VotedRating = PlayersRating[OptionID]

		let VotedRatingPct = 0
		if(MaxRating > 0 && bShowResults){
			VotedRatingPct = (VotedRating * 100) / MaxRating
		}

		let CurrentVoted = 0
		let CurrentVotedRating = 0
        if(bShowResults){
            CurrentVoted = VotedCount
			CurrentVotedRating = VotedRating
        }

        let Option = GetOrCreateVoteOption(Instance, OptionID)

        Option.SetDialogVariable("option_count", `${CurrentVoted} / ${MaxVotes}`)
        Option.SetDialogVariable("option_rating", `${VotedRatingPct.toFixed(0)}%`)

        Option.SetHasClass("SelfOption", LocalPlayerVote == OptionID)

        let ProgressBar = Option.FindChildTraverse("VoteOptionProgressbar")
        if(ProgressBar){
            ProgressBar.max = MaxRating
            ProgressBar.value = CurrentVotedRating
        }
    }
}

function SetupCategories(){
	InfoContainerAbilitiesCategoriesList.RemoveAndDeleteChildren()
	InfoContainerHeroesCategoriesList.RemoveAndDeleteChildren()
	let SpecialSort = ["SSS"]
	for (const MainCategoryName in CATEGORIES) {
		let bIsAbiliy = MainCategoryName == "ABILITIES"
		let Container = bIsAbiliy ? InfoContainerAbilitiesCategoriesList : InfoContainerHeroesCategoriesList
		for (const TierName of SpecialSort) {
			let MainCategoryPanel = GetOrCreateCategory(Container, TierName)
			MainCategoryPanel.SetDialogVariable("category_name", $.Localize(`#BAN_STATE_Category_${TierName}`))
			MainCategoryPanel.AddClass(TierName)

			MainCategoryPanel.SetPanelEvent("onactivate", ()=>{
				SelectCategory(MainCategoryName, TierName, "")
			})

			let SortedMiniCategories = Object.keys(CATEGORIES[MainCategoryName][TierName]).sort((a, b)=>{
				if(a == "DEFAULT"){return -1}
				let aLocalize = $.Localize(`#BAN_STATE_Category_${a}`)
				let bLocalize = $.Localize(`#BAN_STATE_Category_${b}`)
				if(aLocalize > bLocalize){return 1}
				if(aLocalize < bLocalize){return -1}
				return 0
			})
			for (const CategoryName of SortedMiniCategories) {
				if(CategoryName == "DEFAULT"){continue}

				let MiniCategoryPanel = GetOrCreateCategory(Container, CategoryName)
				MiniCategoryPanel.SetDialogVariable("category_name", $.Localize(`#BAN_STATE_Category_${CategoryName}`))
				MiniCategoryPanel.AddClass("SubCategory")

				MiniCategoryPanel.SetPanelEvent("onactivate", ()=>{
					SelectCategory(MainCategoryName, TierName, CategoryName)
				})
			}
		}
	}
}

function SelectCategory(CategoryType, CategoryName, SubCategory){
	if(SubCategory == undefined){
		SubCategory = ""
	}
	if(SelectedCategory[CategoryType].main == CategoryName && SelectedCategory[CategoryType].sub == SubCategory){return}

	SelectedCategory[CategoryType].main = CategoryName
	SelectedCategory[CategoryType].sub = SubCategory

	let Container = CategoryType == "ABILITIES" ? InfoContainerAbilitiesCategoriesList : InfoContainerHeroesCategoriesList
	
	let ContainerList = CategoryType == "ABILITIES" ? InfoContainerAbilitiesList : InfoContainerHeroesList

	ContainerList.RemoveAndDeleteChildren()

	let Cat = SubCategory == "" ? CategoryName : SubCategory

	DeselectCategoryExceptOf(Container, Cat)

	UpdateInfoLists(CategoryType)
}

function UpdateInfoLists(CategoryType){
	let bIsAbiliy = CategoryType == "ABILITIES"
	let Container = bIsAbiliy ? InfoContainerAbilitiesList : InfoContainerHeroesList

	if(SelectedCategory[CategoryType].main != ""){
		let ItemsArray = []

		if(SelectedCategory[CategoryType].sub == ""){
			for (const TierName in CATEGORIES[CategoryType]) {
				for (const CategoryName in CATEGORIES[CategoryType][SelectedCategory[CategoryType].main]) {
					let Array = toArray(CATEGORIES[CategoryType][SelectedCategory[CategoryType].main][CategoryName])
					ItemsArray = ItemsArray.concat(Array)
				}
			}
		}else{
			let Array = toArray(CATEGORIES[CategoryType][SelectedCategory[CategoryType].main][SelectedCategory[CategoryType].sub])
			ItemsArray = ItemsArray.concat(Array)
		}

		ItemsArray = ItemsArray.sort((a, b)=>{
			let aLocalize = bIsAbiliy ? $.Localize(`#DOTA_Tooltip_ability_${a}`) : $.Localize(`#${a}`)
			let bLocalize = bIsAbiliy ? $.Localize(`#DOTA_Tooltip_ability_${b}`) : $.Localize(`#${b}`)
			if(aLocalize > bLocalize){return 1}
			if(aLocalize < bLocalize){return -1}
			return 0
		})

		for (const Item of ItemsArray) {
			let p = GetOrCreateInfoItem(Container, Item)

			p.SetHasClass("IsAbility", bIsAbiliy)
			p.SetHasClass("BannedItem", IsBanned(Item))
			p.SetHasClass("Selected", Item == SelectedToBan)
			p.SetHasClass("IsFavorite", IsFavorite(Item))

			if(bIsAbiliy){
				let CategoryItemAbilityImage = p.FindChildTraverse("CategoryItemAbilityImage")
				if(CategoryItemAbilityImage){
					CategoryItemAbilityImage.abilityname = Item
				}

				p.SetPanelEvent('onmouseover', function () {
					$.DispatchEvent("DOTAShowAbilityTooltip", p, Item);
				});
			
				p.SetPanelEvent('onmouseout', function () {
					$.DispatchEvent("DOTAHideAbilityTooltip", p);
				});

				p.SetPanelEvent("onactivate", function(){
					let HeroN = GetAbilityHeroName(Item)
					if(HeroN != undefined){
						OnPlayerSelectedHero(HeroN)
					}
					OnPlayerSelectedToBan(Item, "ABILITY")
				})
				p.SetPanelEvent("oncontextmenu", function(){
					GameEvents.SendCustomGameEventToServer("server_on_player_add_to_favorite_ban", {BanType: "ABILITY", BanItem: Item});
				})
			}else{
				let CategoryItemHeroesImage = p.FindChildTraverse("CategoryItemHeroesImage")
				if(CategoryItemHeroesImage){
					CategoryItemHeroesImage.heroname = Item
				}

				p.SetPanelEvent("onactivate", function(){
					OnPlayerSelectedHero(Item)
					OnPlayerSelectedToBan(Item, "HERO")
				})

				p.SetPanelEvent("oncontextmenu", function(){
					GameEvents.SendCustomGameEventToServer("server_on_player_add_to_favorite_ban", {BanType: "HERO", BanItem: Item});
				})
			}
		}
	}
}

function UpdatePick(v){
	PickState.SetHasClass("NoRerolls", v.reroll_count <= 0)
	PickState.SetHasClass("CoinsRerolls", (v.reroll_count_free <= 0 && v.reroll_count > 0) || (v.locked_hero != undefined && v.reroll_count > 0))
	PickState.SetDialogVariable("reroll_count", v.reroll_count)
	PickState.SetDialogVariable("reroll_count_free", v.reroll_count_free)
	PickState.SetDialogVariable("reroll_count_paid", Math.max(0, v.reroll_count - Math.max(0, v.reroll_count_free)))
	PickState.SetDialogVariable("hero_name", $.Localize(`#${v.selected_hero}`))

	PickState.SetDialogVariable("reroll_price", v.locked_hero != undefined ? RerollPriceLockedHero : RerollPriceDefault)

	PickState.SetHasClass("HeroSelected", v.selected_hero != "")
	PickState.SetHasClass("HeroLocked", v.locked_hero != undefined)

	if(v.selected_hero != "" && !bOnce){
		bOnce = true
		let SoundsInfo = HERO_SPAWN_SOUND_EVENTS[v.selected_hero]
		if(SoundsInfo){
			Game.EmitSound(SoundsInfo[Math.floor(Math.random()*SoundsInfo.length)])
		}
	}

	let Heroes = v.random_heroes
	if(!Heroes){return}

	let HeroesArray = toArray(Heroes)

	for (const HeroName of HeroesArray) {
		let HeroInfo = HEROES_INFO[HeroName]
		if(HeroInfo){
			let panel = GetOrCreatePickHero(PickHeroesContainer, HeroName)

			let HeroPickClickArea = panel.FindChildTraverse("HeroPickClickArea")
			if (HeroPickClickArea) {
				HeroPickClickArea.SetPanelEvent("onactivate", function(){
					if(v.selected_hero == ""){
						GameEvents.SendCustomGameEventToServer("builder_select_hero", {hero_name: HeroName});
					}
				})
				HeroPickClickArea.SetPanelEvent("onmouseover", function(){
					if (!panel.BHasClass("SelectedHero") && !panel.BHasClass("ShowStatsTooltip")) {
						panel.AddClass("HoveredArea")
					}
				})
				HeroPickClickArea.SetPanelEvent("onmouseout", function(){
					panel.RemoveClass("HoveredArea")
				})
			}

			panel.SetPanelEvent("oncontextmenu", function(){
				GameEvents.SendCustomGameEventToServer("builder_lock_hero", {heroname: HeroName});
			})

			panel.SetHasClass("SelectedHero", v.selected_hero == HeroName)

			panel.SetHasClass("LockedHero", v.locked_hero == HeroName)

			panel.AddClass("Show")

			panel.AddClass(`AttributeNum_${HeroInfo.primary_attribute}`)

			panel.SetHasClass("SSSHero", HeroInfo.sss_category != "NONE")
			if(HeroInfo.sss_category != "NONE"){
				panel.AddClass(`SSSCATEGORY_${HeroInfo.sss_category}`)
			}

			let HeroPickSceneContainer = panel.FindChildTraverse("HeroPickSceneContainer")
			if(HeroPickSceneContainer && !panel.FindChildTraverse("Scene")){
				let hero_scene = $.CreatePanel("DOTAScenePanel", HeroPickSceneContainer, "Scene", { 
					class: "HeroPickScene", 
					drawbackground: "true", 
					unit:HeroName, 
					particleonly:"false", 
					renderdeferred:"false", 
					antialias:"true", 
					renderwaterreflections:"true" 
				});

				hero_scene.SetScenePanelToLocalHero(HeroInfo.id);
			}

			panel.SetDialogVariable("hero_name", $.Localize(`#${HeroName}`))

			let HeroIcon = panel.FindChildTraverse("HeroIcon")
			if(HeroIcon){
				HeroIcon.heroname = HeroName
			}

			let AbilitiesContainer = panel.FindChildTraverse("AbilitiesContainer")
			if(AbilitiesContainer){
				for (const _ in HeroInfo.abilities) {
					let AbilityName = HeroInfo.abilities[_]
					let ability = GetOrCreatePickAbility(AbilitiesContainer, AbilityName)

					ability.CurrentName = AbilityName

					ability.SetHasClass("BannedItem", IsBannedAbility(AbilityName))

					let PickAbilityImage = ability.FindChildTraverse("PickAbilityImage")
					if(PickAbilityImage){
						PickAbilityImage.abilityname = AbilityName
					}

					ability.SetPanelEvent('onmouseover', function () {
						$.DispatchEvent("DOTAShowAbilityTooltip", ability, AbilityName);
					});
				
					ability.SetPanelEvent('onmouseout', function () {
						$.DispatchEvent("DOTAHideAbilityTooltip", ability);
					});
				}
			}

			ReorderPanels(AbilitiesContainer, SortFuncAbilities)

			let HeroTalents = panel.FindChildTraverse("HeroTalents")
			if(HeroTalents){
				HeroTalents.SetPanelEvent('onmouseover', function() {
					$.DispatchEvent('DOTAHUDShowHeroStatBranchTooltip', HeroTalents, HeroInfo.id, 0)
				});

				HeroTalents.SetPanelEvent('onmouseout', function() {
					$.DispatchEvent('DOTAHUDHideStatBranchTooltip', HeroTalents);
				});
			}

			let HeroInnate = panel.FindChildTraverse("HeroInnate")
			if(HeroInnate){
				let innates = HeroInfo.innate_abilities || []
				let primaryInnate = null
				for (let i in innates) {
					let name = innates[i]
					if (name) {
						primaryInnate = name
						break
					}
				}

				if (!primaryInnate) {
					primaryInnate = "innate_disabled_placeholder"
				}

				HeroInnate.SetHasClass("HasInnate", primaryInnate != null)

				if (primaryInnate) {
					HeroInnate.abilityname = primaryInnate
					HeroInnate.SetPanelEvent('onmouseover', function() {
						$.DispatchEvent('DOTAShowAbilityTooltip', HeroInnate, primaryInnate)
					});
					HeroInnate.SetPanelEvent('onmouseout', function() {
						$.DispatchEvent('DOTAHideAbilityTooltip', HeroInnate);
					});
				}
			}

			let HeroStatsButton = panel.FindChildTraverse("HeroStatsButton")
			if (HeroStatsButton && HeroInfo.base_stats && panel.StatsSetupDone !== HeroName) {
				panel.StatsSetupDone = HeroName

				// Ленивая инициализация — тяжёлые вычисления и SetDialogVariable
				// вызываем только при первом клике на кнопку, а не при каждом рендере карточки
				HeroStatsButton.SetPanelEvent('onactivate', function() {
					if (panel.StatsTooltipPopulated !== HeroName) {
						panel.StatsTooltipPopulated = HeroName
						SetupHeroStatsTooltip(panel, HeroStatsButton, HeroInfo)
					}
					panel.AddClass("ShowStatsTooltip")
				});

				let HeroStatsClose = panel.FindChildTraverse("HeroStatsClose")
				if (HeroStatsClose) {
					HeroStatsClose.SetPanelEvent('onactivate', function() {
						panel.RemoveClass("ShowStatsTooltip")
					});
				}
			}

			let HeroAghanim = panel.FindChildTraverse("HeroAghanim")
			if(HeroAghanim){
				HeroAghanim.SetPanelEvent('onmouseover', function() {
					$.DispatchEvent('DOTAHUDShowAghsStatusTooltip', HeroAghanim, HeroInfo.id, 0)
				});
			
				HeroAghanim.SetPanelEvent('onmouseout', function() {
					$.DispatchEvent('DOTAHUDHideAghsStatusTooltip', HeroAghanim);
				});
			}
		}
	}
}

function FormatNumber(value, decimals) {
	let num = Number(value) || 0
	if (decimals === undefined) {
		return String(Math.round(num))
	}
	return num.toFixed(decimals)
}

function SetupHeroStatsTooltip(cardPanel, button, heroInfo) {
	let stats = heroInfo.base_stats || {}
	let primaryAttr = heroInfo.primary_attribute

	let primaryValue = 0
	if (primaryAttr === 0) primaryValue = stats.str || 0
	else if (primaryAttr === 1) primaryValue = stats.agi || 0
	else if (primaryAttr === 2) primaryValue = stats.int || 0

	let baseDamageBonus = primaryValue
	let damageMin = Math.round((stats.damage_min || 0) + baseDamageBonus)
	let damageMax = Math.round((stats.damage_max || 0) + baseDamageBonus)

	let atkRate = stats.attack_rate || 1.7
	let baseAS = 100
	let attackSpeed = Math.round(baseAS + (stats.agi || 0))
	let atkTime = (atkRate / (1 + (stats.agi || 0) * 0.01)).toFixed(2)

	let armor = (stats.armor || 0) + (stats.agi || 0) * 0.167
	let physResist = 1 - (100 / (100 + armor * 6))

	let hpFromStr = (stats.str || 0) * 22
	let hpRegenFromStr = (stats.str || 0) * 0.1
	let manaFromInt = (stats.int || 0) * 12
	let manaRegenFromInt = (stats.int || 0) * 0.05
	let magicResistFromInt = (stats.int || 0) * 0.1

	cardPanel.SetDialogVariable("atk_speed", String(attackSpeed))
	cardPanel.SetDialogVariable("damage", damageMin + " - " + damageMax)
	cardPanel.SetDialogVariable("attack_range", FormatNumber(stats.attack_range))
	cardPanel.SetDialogVariable("move_speed", FormatNumber(stats.move_speed))
	cardPanel.SetDialogVariable("mana_regen", FormatNumber((stats.mana_regen || 0) + manaRegenFromInt, 2))

	cardPanel.SetDialogVariable("armor", FormatNumber(armor, 1))
	cardPanel.SetDialogVariable("phys_resist", FormatNumber(physResist * 100, 0) + "%")
	cardPanel.SetDialogVariable("magic_resist", FormatNumber((stats.magic_resist || 25) + magicResistFromInt, 1) + "%")
	cardPanel.SetDialogVariable("hp_regen", FormatNumber((stats.hp_regen || 0) + hpRegenFromStr, 2))

	let perLevel = $.Localize("#PICK_STATE_HeroStats_UnitsPerLevel")
	let gainColor = "#6bd67b"

	function FormatGain(value) {
		return "(<b><font color='" + gainColor + "'>" + FormatNumber(value, 1) + "</font></b> " + perLevel + ")"
	}

	cardPanel.SetDialogVariable("str_value", FormatNumber(stats.str))
	cardPanel.SetDialogVariable("str_gain", FormatGain(stats.str_gain))
	cardPanel.SetDialogVariable("str_derived", "= " + FormatNumber(hpFromStr) + " HP, " + FormatNumber(hpRegenFromStr, 2) + " HP regen")

	cardPanel.SetDialogVariable("agi_value", FormatNumber(stats.agi))
	cardPanel.SetDialogVariable("agi_gain", FormatGain(stats.agi_gain))
	cardPanel.SetDialogVariable("agi_derived", "= " + FormatNumber((stats.agi || 0) * 0.167, 1) + " armor, " + FormatNumber(stats.agi) + " attack speed")

	cardPanel.SetDialogVariable("int_value", FormatNumber(stats.int))
	cardPanel.SetDialogVariable("int_gain", FormatGain(stats.int_gain))
	cardPanel.SetDialogVariable("int_derived", "= " + FormatNumber(manaFromInt) + " mana, " + FormatNumber(manaRegenFromInt, 2) + " regen, " + FormatNumber(magicResistFromInt, 1) + "% magic resist")
}

function RerollHeroes(){
	GameEvents.SendCustomGameEventToServer("builder_reroll_heroes", {});
}

function RandomHero(){
	GameEvents.SendCustomGameEventToServer("builder_random_hero", {});
}

let LastTimerNum = 0

function UpdateTimer(){
	if(LastTimeTimer != 0){
		TimerSchedule = $.Schedule(0.2, UpdateTimer)
	}else{
		MAIN_PANEL.RemoveClass("Warning")
	}

	let Diff = Math.max(Math.ceil(Math.abs(LastTimeTimer - Game.GetGameTime())), 0)
	let Text = $.Localize("#bp_time_left") + GetTimeString(Diff)
	MAIN_PANEL.SetDialogVariable("timer", Text)

	MAIN_PANEL.SetHasClass("Warning", Diff <= 10)

	if(Diff <= 5 && LastTimerNum != Diff){
		LastTimerNum = Math.ceil(Diff)
		Game.EmitSound("Tutorial.TaskProgress")
	}
}

function ShowLoadingPlayers(){
	$("#PlayerLists").SetHasClass("ShowState", CurrentState == "PLAYERS_LOADING")
}

function ShowCurrentStateMsg(){
	if(MsgSchedule != -1){
		$.CancelScheduled(MsgSchedule)
		StateSwitchMsg.AddClass("FastEnd")
		StateSwitchMsg.RemoveClass("ShowState")
		MsgSchedule = -1
	}

	StateSwitchMsg.RemoveClass("FastEnd")
	StateSwitchMsg.AddClass("ShowState")
    StateSwitchMsg.SetDialogVariable("state_name", $.Localize(`#STATES_State_${CurrentState}`))

	Game.EmitSound("cha_ban_state_sound")
	Game.EmitSound("cha_change_state_sound")

	MsgSchedule = $.Schedule(2.2, function(){
		StateSwitchMsg.AddClass("FastEnd")
		StateSwitchMsg.RemoveClass("ShowState")
	})
}

function CloseStates(){
	for (const STATE_NAME in StateTable) {
		if(typeof StateTable[STATE_NAME] == "object"){
			for (const PanelID of StateTable[STATE_NAME]) {
				let p = $(`#${PanelID}`)
				if(p){
					p.RemoveClass("ShowState")
				}
			}
		}else{
			let p = $(`#${StateTable[STATE_NAME]}`)
			if(p){
				p.RemoveClass("ShowState")
			}
		}
	}
}

function SwitchStates(){
	for (const STATE_NAME in StateTable) {
		if(typeof StateTable[STATE_NAME] == "object"){
			for (const PanelID of StateTable[STATE_NAME]) {
				let p = $(`#${PanelID}`)
				if(p){
					p.SetHasClass("ShowState", STATE_NAME == CurrentState)
				}
			}
		}else{
			let p = $(`#${StateTable[STATE_NAME]}`)
			if(p){
				p.SetHasClass("ShowState", STATE_NAME == CurrentState)
			}
		}
	}
}

function MakeBan(){
	if(SelectedToBan == undefined || SelectedToBanType == undefined){return}
	
	let Times = 0

	if(SelectedToBanType == "HERO" && LocalPlayerBanInfo.heroes != undefined){
		Times = LocalPlayerBanInfo.heroes
	}
	if(SelectedToBanType == "ABILITY" && LocalPlayerBanInfo.abilities != undefined){
		Times = LocalPlayerBanInfo.abilities
	}

	if(Times > 0){
		GameEvents.SendCustomGameEventToServer("bans_ban", {to_ban:SelectedToBan, to_ban_type: SelectedToBanType});
	}
}

function MakeRandomBans(){
	if(LocalPlayerBanInfo == {}){return}

	let bCanUse = (LocalPlayerBanInfo.banned_atleast_one_time == 0 && LocalPlayerBanInfo.used_random_bans == 0)

	if(bCanUse){
		GameEvents.SendCustomGameEventToServer("bans_random_bans", {});
	}
}

function StartBans(){
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

	ReorderPanels(HeroesContainer, SortFuncAttributes)
}

function OnPlayerSelectedHero(HeroName){
	if(SelectedBanHero == HeroName){return}

	SelectedBanHero = HeroName

	SelectedHeroImage.heroname = HeroName

	SelectedToBan = undefined
	SelectedToBanType = undefined

	BanState.SetHasClass("HeroSelected", SelectedBanHero != "")

	SelectedHeroImagePanel.SetPanelEvent("onactivate", function(){
		OnPlayerSelectedToBan(HeroName, "HERO")
	})

	let Times = 0

	if(Times == 0 && LocalPlayerBanInfo.heroes != undefined && LocalPlayerBanInfo.heroes > 0){
		Times = LocalPlayerBanInfo.heroes
	}
	if(Times == 0 && LocalPlayerBanInfo.abilities != undefined && LocalPlayerBanInfo.abilities > 0){
		Times = LocalPlayerBanInfo.abilities
	}

	MakeBanButton.SetHasClass("Disabled", Times <= 0)

	UpdateSelectedHero()

	UpdateHeroes()

	UpdatePopularBans()

	UpdateInfoLists("ABILITIES")
	UpdateInfoLists("HEROES")
}

function OnPlayerSelectedToBan(ToBan, ToBanType){
	SelectedToBan = ToBan
	SelectedToBanType = ToBanType

	BanState.SetHasClass("PlayerSelectedToBan", SelectedToBan != undefined)

	UpdateBanInfo()

	UpdateSelectedHero()

	UpdatePopularBans()

	UpdateInfoLists("ABILITIES")
	UpdateInfoLists("HEROES")
}

function UpdateBanInfo(){
	let Times = 0

	if(SelectedToBanType == "HERO" && LocalPlayerBanInfo.heroes != undefined){
		Times = LocalPlayerBanInfo.heroes
	}
	if(SelectedToBanType == "ABILITY" && LocalPlayerBanInfo.abilities != undefined){
		Times = LocalPlayerBanInfo.abilities
	}

	BanState.SetDialogVariableInt("times", Times)

	let bDisabled = IsBanned(SelectedToBan) || Times <= 0
	
	MakeBanButton.SetHasClass("Disabled", bDisabled)
}

function UpdateHeroes(){
	for (const HeroName in HEROES_INFO) {
		let HeroInfo = HEROES_INFO[HeroName]

		let AttributePanel = GetOrCreateHeroesAttribute(HeroInfo.primary_attribute)

		let Container = AttributePanel.FindChildTraverse("HeroesTabContainer")
		if(Container){
			let HeroPanel = GetOrCreateHero(Container, HeroName)

			HeroPanel.SetHasClass("Selected", HeroName == SelectedBanHero)

			HeroPanel.SetHasClass("BannedItem", IsBannedHero(HeroName))

			HeroPanel.SetHasClass("IsFavorite", IsFavorite(HeroName))

			HeroPanel.SetPanelEvent("oncontextmenu", function(){
				GameEvents.SendCustomGameEventToServer("server_on_player_add_to_favorite_ban", {BanType: "HERO", BanItem: HeroName});
			})
		}
	}
}

function UpdateSelectedHero(){
	if(SelectedBanHero == ""){return}
	// DeleteAllChildren(AbilitiesContainer)
	let HeroInfo = HEROES_INFO[SelectedBanHero]

	SelectedHeroImagePanel.SetHasClass("Selected", SelectedToBan == SelectedBanHero)

	SelectedHeroImagePanel.SetHasClass("BannedItem", IsBannedHero(SelectedBanHero))

	SelectedHeroImagePanel.SetHasClass("IsFavorite", IsFavorite(SelectedBanHero))

	SelectedHeroImagePanel.SetPanelEvent("oncontextmenu", function(){
		GameEvents.SendCustomGameEventToServer("server_on_player_add_to_favorite_ban", {BanType: "HERO", BanItem: SelectedBanHero});
	})

	let Num = 0
	for (const _ in HeroInfo.abilities) {
		let AbilityName = HeroInfo.abilities[_]
		let AbilityPanel = GetOrCreateAbility(Num)

		AbilityPanel.CurrentName = AbilityName

		AbilityPanel.SetHasClass("Selected", SelectedToBan == AbilityName)

		AbilityPanel.SetHasClass("BannedItem", IsBannedAbility(AbilityName))

		AbilityPanel.SetHasClass("IsFavorite", IsFavorite(AbilityName))

		AbilityPanel.SetPanelEvent("onactivate", function(){
			OnPlayerSelectedToBan(AbilityName, "ABILITY")
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

		AbilityPanel.SetPanelEvent("oncontextmenu", function(){
			GameEvents.SendCustomGameEventToServer("server_on_player_add_to_favorite_ban", {BanType: "ABILITY", BanItem: AbilityName});
		})

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

function UpdatePickBansTable(v){
	for (const TableName in v) {
		let TableInfo = toArray(v[TableName])
		let bIsAbility = TableName == "abilities"
		let bIsHero = TableName == "heroes"

		let Container = bIsAbility ? CurrentBannedListAbilities : CurrentBannedListHeroes
		if(Container){

			TableInfo = TableInfo.sort((a, b)=>{
                let aLocalize = bIsAbility ? $.Localize(`#DOTA_Tooltip_ability_${a}`) : $.Localize(`#${a}`)
                let bLocalize = bIsAbility ? $.Localize(`#DOTA_Tooltip_ability_${b}`) : $.Localize(`#${b}`)
                if(aLocalize > bLocalize){return 1}
                if(aLocalize < bLocalize){return -1}
                return 0
            })

			Container.SetHasClass("SmallIcons", TableInfo.length > 13)
			Container.SetHasClass("SmallIconsPick", TableInfo.length > 13)

			for (const Name of TableInfo) {
				let panel = GetOrCreateBannedItem(Container, Name)

				panel.SetHasClass("IsHero", bIsHero)
				panel.SetHasClass("IsAbility", bIsAbility)

				if(bIsAbility){
					panel.SetPanelEvent('onmouseover', function () {
						$.DispatchEvent("DOTAShowAbilityTooltip", panel, Name);
					});

					panel.SetPanelEvent('onmouseout', function () {
						$.DispatchEvent("DOTAHideAbilityTooltip", panel);
					});
				}

				let BannedItemHero = panel.FindChildTraverse("BannedItemHero")
				if(bIsHero && BannedItemHero){
					BannedItemHero.heroname = Name
				}

				let BannedItemAbility = panel.FindChildTraverse("BannedItemAbility")
				if(bIsAbility && BannedItemAbility){
					BannedItemAbility.abilityname = Name
				}
			}

			CenterLastRow(Container)
		}
	}
}

let _centerLastRowPending = {}

function CenterLastRow(container) {
	if (!container || !container.id) return
	let key = container.id
	if (_centerLastRowPending[key]) return
	_centerLastRowPending[key] = true

	$.Schedule(0.2, function() {
		_centerLastRowPending[key] = false
		if (!container || !container.IsValid()) return

		let allChildren = container.Children()
		if (!allChildren || allChildren.length < 2) return

		let firstChild = allChildren[0]
		if (firstChild.BHasClass && firstChild.BHasClass("BannedRow")) {
			firstChild = firstChild.Children()[0]
		}
		if (!firstChild) return

		let rawWidth = firstChild.actuallayoutwidth || 0
		let margin = 5
		if (rawWidth >= 64) {
			margin = 10
		} else if (rawWidth >= 48) {
			margin = 5
		} else {
			margin = 5
		}
		let itemWidth = rawWidth + margin
		let containerWidth = container.actuallayoutwidth || 0
		if (itemWidth <= margin || containerWidth <= 0) return

		let perRow = Math.max(1, Math.floor(containerWidth / itemWidth))
		let totalItems = 0
		for (let i = 0; i < allChildren.length; i++) {
			let c = allChildren[i]
			if (c.BHasClass && c.BHasClass("BannedRow")) {
				totalItems += c.Children().length
			} else {
				totalItems += 1
			}
		}
		if (perRow >= totalItems) return

		let bannedItems = []
		for (let i = 0; i < allChildren.length; i++) {
			let c = allChildren[i]
			if (c.BHasClass && c.BHasClass("BannedRow")) {
				let rowItems = c.Children()
				for (let j = 0; j < rowItems.length; j++) {
					bannedItems.push(rowItems[j])
				}
			} else {
				bannedItems.push(c)
			}
		}

		for (let i = allChildren.length - 1; i >= 0; i--) {
			let c = allChildren[i]
			if (c.BHasClass && c.BHasClass("BannedRow")) {
				c.RemoveAndDeleteChildren()
				c.DeleteAsync(0)
			}
		}

		container.AddClass("HasCenteredRows")

		let currentRow = null
		for (let i = 0; i < bannedItems.length; i++) {
			if (i % perRow === 0) {
				currentRow = $.CreatePanel("Panel", container, "")
				currentRow.AddClass("BannedRow")
			}
			bannedItems[i].SetParent(currentRow)
		}
	})
}

function UpdateBansTable(v){
	for (const TableName in v) {
		let TableInfo = toArray(v[TableName])
		let bIsAbility = TableName == "abilities"
		let bIsHero = TableName == "heroes"

		let Container = bIsAbility ? BannedListAbilities : BannedListHeroes
		if(Container){

			TableInfo = TableInfo.sort((a, b)=>{
                let aLocalize = bIsAbility ? $.Localize(`#DOTA_Tooltip_ability_${a}`) : $.Localize(`#${a}`)
                let bLocalize = bIsAbility ? $.Localize(`#DOTA_Tooltip_ability_${b}`) : $.Localize(`#${b}`)
                if(aLocalize > bLocalize){return 1}
                if(aLocalize < bLocalize){return -1}
                return 0
            })

			Container.SetHasClass("SmallIcons", TableInfo.length > 6)

			for (const Name of TableInfo) {
				let panel = GetOrCreateBannedItem(Container, Name)

				panel.SetHasClass("IsHero", bIsHero)
				panel.SetHasClass("IsAbility", bIsAbility)

				panel.SetHasClass("IsFavorite", IsFavorite(Name))

				if(bIsAbility){
					panel.SetPanelEvent('onmouseover', function () {
						$.DispatchEvent("DOTAShowAbilityTooltip", panel, Name);
					});
				
					panel.SetPanelEvent('onmouseout', function () {
						$.DispatchEvent("DOTAHideAbilityTooltip", panel);
					});
				}

				let BanType = bIsAbility ? "ABILITY" : "HERO"

				panel.SetPanelEvent("oncontextmenu", function(){
					GameEvents.SendCustomGameEventToServer("server_on_player_add_to_favorite_ban", {BanType: BanType, BanItem: Name});
				})

				let BannedItemHero = panel.FindChildTraverse("BannedItemHero")
				if(bIsHero && BannedItemHero){
					BannedItemHero.heroname = Name
				}

				let BannedItemAbility = panel.FindChildTraverse("BannedItemAbility")
				if(bIsAbility && BannedItemAbility){
					BannedItemAbility.abilityname = Name
				}
			}
		}
	}
}

function UpdatePopularBans(){
	if(LocalPlayerPopularBans == {}){return}

	for (let i = 0; i < PopularBannedListAbilities.GetChildCount(); i++) {
		const Child = PopularBannedListAbilities.GetChild(i)
		let Array = toArray(LocalPlayerPopularBans.abilities)
		if(Child && !Array.includes(Child.id.replace("Item_", ""))){
			SafeDeleteAsync(Child)
		}
	}
	for (let i = 0; i < PopularBannedListHeroes.GetChildCount(); i++) {
		const Child = PopularBannedListHeroes.GetChild(i)
		let Array = toArray(LocalPlayerPopularBans.heroes)
		if(Child && !Array.includes(Child.id.replace("Item_", ""))){
			SafeDeleteAsync(Child)
		}
	}

	for (const TableName in LocalPlayerPopularBans) {
		let TableInfo = LocalPlayerPopularBans[TableName]
		let bIsAbility = TableName == "abilities"
		let bIsHero = TableName == "heroes"

		let Container = bIsAbility ? PopularBannedListAbilities : PopularBannedListHeroes
		if(Container){
			// Container.SetHasClass("SmallIcons", Count(TableInfo) > 6)
			for (const _ in TableInfo) {
				let Name = TableInfo[_]
				let panel = GetOrCreateBannedItem(Container, Name)

				panel.SetHasClass("Selected", SelectedToBan == Name)

				panel.SetHasClass("BannedItem", IsBanned(Name))

				let BanType = bIsAbility ? "ABILITY" : "HERO"

				panel.SetPanelEvent("onactivate", function(){
					if(bIsAbility){
						let HName = GetAbilityHeroName(Name)
						if(HName != undefined){
							OnPlayerSelectedHero(HName)
						}
					}else{
						OnPlayerSelectedHero(Name)
					}
					OnPlayerSelectedToBan(Name, BanType)
				})

				panel.SetHasClass("IsHero", bIsHero)
				panel.SetHasClass("IsAbility", bIsAbility)

				panel.style.transitionDuration = "0.0s"

				panel.AddClass("PopularBan")
				panel.style.transitionDuration = "0.1s"

				panel.AddClass("IsFavorite")

				if(bIsAbility){
					panel.SetPanelEvent('onmouseover', function () {
						$.DispatchEvent("DOTAShowAbilityTooltip", panel, Name);
					});
				
					panel.SetPanelEvent('onmouseout', function () {
						$.DispatchEvent("DOTAHideAbilityTooltip", panel);
					});
				}

				panel.SetPanelEvent("oncontextmenu", function(){
					GameEvents.SendCustomGameEventToServer("server_on_player_add_to_favorite_ban", {BanType: BanType, BanItem: Name});
				})

				let BannedItemHero = panel.FindChildTraverse("BannedItemHero")
				if(bIsHero && BannedItemHero){
					BannedItemHero.heroname = Name
				}

				let BannedItemAbility = panel.FindChildTraverse("BannedItemAbility")
				if(bIsAbility && BannedItemAbility){
					BannedItemAbility.abilityname = Name
				}
			}
		}
	}
}

function IsBannedHero(HeroName){
	if(CurrentBanInfo == {} || !CurrentBanInfo.heroes){return false}
	
	return CurrentBanInfo.heroes.includes(HeroName)
}

function IsBannedAbility(AbilityName){
	if(CurrentBanInfo == {} || !CurrentBanInfo.abilities){return false}
	
	return CurrentBanInfo.abilities.includes(AbilityName)
}

function IsBanned(Name){
	if(CurrentBanInfo == {} || !CurrentBanInfo.heroes || !CurrentBanInfo.abilities){return false}
	
	let bBanned = (CurrentBanInfo.heroes.includes(Name) || CurrentBanInfo.abilities.includes(Name))
	
	return bBanned
}

function GetAbilityHeroName(Name){
	if(!ABILITIES_INFO || !ABILITIES_INFO[Name]){return undefined}

	return ABILITIES_INFO[Name].HeroName
}

function IsFavorite(Name){
	if(LocalPlayerPopularBans == {} || LocalPlayerPopularBans.heroes == undefined || LocalPlayerPopularBans.abilities == undefined){return false}

	let ArrayHeroes = toArray(LocalPlayerPopularBans.heroes)
	let ArrayAbilities = toArray(LocalPlayerPopularBans.abilities)
	if(ArrayHeroes.includes(Name) || ArrayAbilities.includes(Name)){
		return true
	}

	return false
}

function GetOrCreateHeroesAttribute(attribute){
	let f = HeroesContainer.FindChildTraverse(`HeroesAttribute_${attribute}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", HeroesContainer, `HeroesAttribute_${attribute}`, {})
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

function GetOrCreateBannedItem(Container, BannedItemName){
	let f = Container.FindChildTraverse(`Item_${BannedItemName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `Item_${BannedItemName}`, {})
		panel.BLoadLayoutSnippet("BannedItem")

		return panel
	}
}

function GetOrCreatePickHero(Container, HeroName){
	let f = Container.FindChildTraverse(`Hero_${HeroName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `Hero_${HeroName}`, {})
		panel.BLoadLayoutSnippet("HeroPickCard")

		return panel
	}
}

function GetOrCreatePickAbility(Container, AbilityName){
	let f = Container.FindChildTraverse(`Ability_${AbilityName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `Ability_${AbilityName}`, {})
		panel.BLoadLayoutSnippet("PickAbility")

		return panel
	}
}

function GetOrCreateCategory(Container, CategoryName){
	let f = Container.FindChildTraverse(`Category_${CategoryName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `Category_${CategoryName}`, {})
		panel.BLoadLayoutSnippet("CategoryLine")

		return panel
	}
}

function GetOrCreateInfoItem(Container, ItemName){
	let f = Container.FindChildTraverse(`InfoItem_${ItemName}`)
	if(f){
		return f
	}else{
		let panel = $.CreatePanel("Panel", Container, `InfoItem_${ItemName}`, {})
		panel.BLoadLayoutSnippet("CategoryItem")

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

function CreatePlayerPanels() {
    mainList.RemoveAndDeleteChildren()
    ShowLoadingPlayers(PlayerLists)
    let average_rating = 0

    for (const Sub of NetTableSubs) {
        CustomNetTables.UnsubscribeNetTableListener(Sub)
    }
    NetTableSubs = []

    for (let playerID of Game.GetAllPlayerIDs()) {
		let pInfo = Game.GetPlayerInfo( playerID )

        const pPanel = $.CreatePanel("Panel", mainList, `player_${playerID}`);
		pPanel.BLoadLayoutSnippet("playerPanel");

        if (playerID % 2 != 0) { pPanel.AddClass("Right"); }
		// pPanel.FindChildTraverse('avatar').steamid = pInfo.player_steamid
		pPanel.FindChildTraverse('name').steamid = pInfo.player_steamid
        pPanel.FindChildTraverse('avatar').steamid = pInfo.player_steamid

        pPanel.SetDialogVariable("player_rating", "")

        let sub = SubscribeAndFireNetTableByKey("players_server_info", `player_${[playerID]}`, function(v){
            pPanel.SetDialogVariable("player_rating", v.profile.rating)
            // Пересчитываем средний рейтинг лобби при каждом обновлении профиля.
            // Профили подгружаются с backend асинхронно (по мере загрузки игроков),
            // поэтому среднее нарастает по мере того как новые рейтинги становятся видны.
            UpdateAverage()
        })
        NetTableSubs.push(sub)
    }
    // Инициализация: пустая строка пока ни у кого нет рейтинга.
    UpdateAverage()
    UpdatePlayersConnectionState()
    GameEvents.Subscribe("dota_player_connection_state_changed", UpdatePlayersConnectionState)
}

function DeselectCategoryExceptOf(Container, CategoryName){
	for (let i = 0; i < Container.GetChildCount(); i++) {
		let Child = Container.GetChild(i)
		if(Child){
			Child.SetHasClass("SelectedCategory", Child.id == `Category_${CategoryName}`)
		}
	}
}

function DeselectPagesExceptOf(PageName){
	for (let i = 0; i < Pages.GetChildCount(); i++) {
		let Child = Pages.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `Page${PageName}`)
		}
	}
	for (let i = 0; i < BanButtons.GetChildCount(); i++) {
		let Child = BanButtons.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `Button${PageName}`)
		}
	}
}

function SelectPage(PageName){
	if(SelectedPage == PageName){
		return
	}

	DeselectPagesExceptOf(PageName)
}

function UpdateAverage()
{
    let sum_rating = 0
    let loaded_count = 0
    // Считаем только тех игроков, чьи профили УЖЕ пришли с backend (rating заполнен).
    // По мере загрузки игроков players_server_info обновляется -- среднее нарастает.
    for (let playerID of Game.GetAllPlayerIDs())
    {
        var rank_info = CustomNetTables.GetTableValue("players_server_info", `player_${playerID}`)
        if (rank_info != null && rank_info.profile && rank_info.profile.rating != null)
        {
            sum_rating = sum_rating + rank_info.profile.rating
            loaded_count = loaded_count + 1
        }
    }

    let target = $("#AverageRatingPlayers")
    if (!target) return

    if (loaded_count <= 0)
    {
        // Никого ещё не загрузилось -- показываем пустую строку чтобы не делиться на 0
        // и не показывать "Средний рейтинг: 0" / NaN.
        target.text = ""
        return
    }

    let avg = Math.floor(sum_rating / loaded_count)
    target.text = $.Localize("#average_rating") + avg
}

function UpdatePlayersConnectionState() {
    for (const player of Game.GetAllPlayerIDs()) {
        if ($('#player_' + player))
        {
            $('#player_' + player).RemoveClass('playerConnected')
            $('#player_' + player).RemoveClass('playerConnectedFailed')
            let pState = Game.GetPlayerInfo( player ).player_connection_state
            if (pState == DOTAConnectionState_t.DOTA_CONNECTION_STATE_CONNECTED)
            {
                $.Schedule(0.3, function () {
                    $('#player_' + player).AddClass('playerConnected')
                })
            } else if (pState == DOTAConnectionState_t.DOTA_CONNECTION_STATE_FAILED || pState == DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED || pState == DOTAConnectionState_t.DOTA_CONNECTION_STATE_DISCONNECTED) {
                $('#player_' + player).AddClass('playerConnectedFailed')
            }
        }
    }
}

function ExpectationLoad() {
	const pInfo = Game.GetPlayerInfo( Game.GetLocalPlayerID() )
	if (!pInfo || pInfo.player_connection_state != DOTAConnectionState_t.DOTA_CONNECTION_STATE_CONNECTED)
		return void $.Schedule(0.1, ExpectationLoad)

    CreatePlayerPanels()
}