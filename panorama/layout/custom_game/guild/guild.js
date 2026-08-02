--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const ROOT_PANEL = $.GetContextPanel()

const guildMenuContainer = $("#Guild_menu_container")
if (guildMenuContainer) guildMenuContainer.visible = false


const ROOT_MAIN_LAYER = ROOT_PANEL.FindChildrenWithClassTraverse("main-layer")[0]
ROOT_MAIN_LAYER.visible = true
ROOT_MAIN_LAYER.RemoveAndDeleteChildren()

const ROOT_TOP_LAYER = ROOT_PANEL.FindChildrenWithClassTraverse("top-layer")[0]
ROOT_TOP_LAYER.visible = true
ROOT_TOP_LAYER.RemoveAndDeleteChildren()

const localPlayerSteamId64 = Game.GetLocalPlayerInfo().player_steamid

// Контроллер окна (одновременно открыто только одно окно) и закрытие по клику снаружи
DotaHUD.windowControllers["guild"] = {
	is_open: false,
	open: function () {
		try {
			openGuildMenu()
		} catch (error) {
			handleError(error)
		}
	},
	close: function () {
		closeEverything(true)
	}
}
DotaHUD.ListenToMouseEvent(
	DotaHUD.GetCloseWindowOnOutsideClick(ROOT_PANEL, "guild")
)

let hideAboveHeadThings = false

// Кнопка в топ-баре: та же иконка, что была на <Button class="open"/> (open_menu.png)
GameUI.LoopTime.Schedule(0.0, () => {
	DotaHUD.CreateTopBarButton("file://{images}/guild/open_menu.png", "guild", () => {
		if (DotaHUD.IsWindowOpen("guild")) {
			DotaHUD.WindowClose("guild")
		} else {
			DotaHUD.WindowOpen("guild")
		}
	}, "guild_open_menu")
	DotaHUD.AttachRightClickToTopBarButton("guild", () => {
		contextMenu([
			{
				id: "hide-above-head-things",
				type: "checkbox",
				text: "#guild_misc_settings_hide_above_head_things",
				checked: hideAboveHeadThings,
				image: ImageUtils.resolve("⚙️"),
				onChecked: (_, checked) => {
					hideAboveHeadThings = checked
				},
			},
		])
	})
})

/** @type {Guild} */
let GUILD

const GUILDS = new GuildsManager()

let nextRequestConfigsTime = 0

function openGuildMenu() {
	$.Msg("[Guild] openGuildMenu called");

	if (!GUILD) {
		$.Msg("[Guild] GUILD is not defined, requesting configs from server");
		if (nextRequestConfigsTime > Date.now()) return
		GameEvents.SendCustomGameEventToServer("Guild:RequestConfigs", {});
		nextRequestConfigsTime = Date.now() + 3
		return;
	}

	if (!isReady) {
		$.Msg("[Guild] isReady flag is false, returning early");
		return;
	}

	if (GUILD.isValid) {
		$.Msg("[Guild] GUILD is valid");
		if (ROOT_MAIN_LAYER.guildPanel) {
			$.Msg("[Guild] ROOT_MAIN_LAYER.guildPanel exists, toggling visibility");
			ROOT_MAIN_LAYER.guildPanel.toggleVisibility();
			return;
		}

		try {
			$.Msg("[Guild] Opening guild panel");
			openGuildPanel();
		} catch (error) {
			$.Msg("[Guild] Error occurred during openGuildPanel: " + error);
			handleError(error);
		}
		return;
	}

	$.Msg("[Guild] GUILD is not valid, opening guilds list");
	openGuildsList();
}

function closeEverything(fromGuildButton=false) {
	closeActiveContextMenu()
	closeAllModals()

	safeDeletePanel(ROOT_MAIN_LAYER.guildsList)
	ROOT_MAIN_LAYER.guildsList = undefined

	if (!fromGuildButton) {
		safeDeletePanel(ROOT_MAIN_LAYER.guildPanel)
		ROOT_MAIN_LAYER.guildPanel = undefined

		DotaHUD.windowControllers["guild"].is_open = false
	} else {
		if (ROOT_MAIN_LAYER.guildPanel)
			ROOT_MAIN_LAYER.guildPanel.toggleVisibility()
	}
}

let isReady = false

function init() {
	GameEventsSubscribe("Guild:RequestConfigs", (data) => {
		GUILD = new Guild(data)

		GameEvents.SendCustomGameEventToServer("Guild:Init", {})
	})

	GameEventsSubscribe("Guild:PopulateGuild", (data) => {
		isReady = true

		if (!data.guild || !Object.keys(data.guild).length)
			return

		GUILD.populate(data.guild, data.speedruns)
		
		// DotaHUD.WindowOpen("guild")
		if (!!data.openGuildMenu) {
			closeEverything()

			DotaHUD.WindowOpen("guild")
		}
	})

	GameEventsSubscribe("Guild:Patch", (patchData) => {
		if ("guild" in patchData) {
			if (!GUILD || !GUILD.isValid)
				return

			if (GUILD.id !== String(patchData.guild.id))
				return

			if (patchData.guild.delete) {
				closeEverything()
				GUILD.reset()
				return
			}

			GUILD.patch(patchData.guild)
		}
		if ("guilds" in patchData) {
			GUILDS.patch(patchData.guilds)
		}
	})

	GameEventsSubscribe("Guild:RequestInit", (patchData) => {
		GameEvents.SendCustomGameEventToServer("Guild:RequestConfigs", {})
	})

	GameEvents.SendCustomGameEventToServer("Guild:RequestConfigs", {})
}

init()
