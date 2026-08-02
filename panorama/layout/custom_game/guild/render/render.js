--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


(() => {
	const CONTEXT_PANEL = $.GetContextPanel()

	let parentIsDotaHUD = false

	const parent = (() => {
		const HUD = CONTEXT_PANEL.GetParent().GetParent().GetParent()
		if (!HUD || HUD.id !== "Hud") {
			$.Msg("[guild/render/render.js] Valve break something or did major changes to UI (can't find DOTAHud(id=\"Hud\") container).")
			return CONTEXT_PANEL
		}

		const HUDElements = HUD.FindChild("HUDElements")
		if (!HUDElements) {
			$.Msg("[guild/render/render.js] Valve break something or did major changes to UI (can't find Panel(id=\"HUDElements\") container).")
			return CONTEXT_PANEL
		}

		const childsCount = HUDElements.GetChildCount()

		for (let i = 0; i < childsCount; i++) {
			const child = HUDElements.GetChild(i)
			if (child && child.IsValid() && child.BHasClass("over-hero-things"))
				child.DeleteAsync(0)
		}

		parentIsDotaHUD = true

		return HUDElements
	})()

	let screenheight = 0

	function ScreenHeightWidth() {
		screenheight = CONTEXT_PANEL.actuallayoutheight

		$.Schedule(1 / 2, ScreenHeightWidth)
	}

	ScreenHeightWidth()

	function getAllHeroes() {
		const heroes = [];
		const allHeroes = Entities.GetAllHeroEntities()

		for (const hero of allHeroes) {
			if (Entities.IsValidEntity(hero) && !Entities.IsEnemy(hero))
				heroes.push(hero)
		}

		return heroes
	}

	/** 
	 * @param {Panel} panel
	 */
	function setupHeroPanelStyles(panel) {
		panel.style.flowChildren = "down"
		panel.style.width = "240px"
		panel.style.zIndex = "-1000"

		const title = panel.title
		if (title) {
			title.style.height = "41px"

			const label = title.label
			if (label) {
				label.style.align = "center center"
				label.style.marginTop = "5.7%"
				label.style.textAlign = "center"
				label.style.color = "#ff66ff"
				label.style.fontSize = "16px"
				label.style.fontWeight = "bold"
				label.style.textShadow = "0 0 8px #9e139e"
			}

			const particle = title.particle
			if (particle) {
				particle.style.width = "100%"
				particle.style.height = "fill-parent-flow(1)"
				particle.style.padding = "-36px -30px -30px"
			}
		}

		const guild = panel.guild
		if (guild) {
			guild.style.horizontalAlign = "center"
			guild.style.width = "100%"
			guild.style.marginTop = "2px"
			guild.style.flowChildren = "down"

			const name = guild.name
			if (name) {
				name.style.horizontalAlign = "center"
				name.style.width = "60%"
				name.style.textAlign = "center"
				name.style.fontWeight = "bold"
				name.style.color = "#e5e0c5"
				name.style.fontSize = "16px"
				name.style.textOverflow = "shrink"
			}

			const role = guild.role
			if (role) {
				role.style.horizontalAlign = "center"
				role.style.width = "60%"
				role.style.textAlign = "center"
				role.style.fontWeight = "bold"
				role.style.fontSize = "16px"
				role.style.textOverflow = "shrink"
			}
		}
	}

	/**
	 * @typedef {Object} PlayerRenderData
	 * @property {Object} [hero]
	 * @property {Panel} [panel]
	 * @property {string} [sid64]
	 * @property {string} [guildName]
	 * @property {string} [showGuildInfo]
	 * @property {string} [showTitle]
	 */

	/** @type {Record<number, PlayerRenderData>} */
	const playersData = {}

	function initHeroPanel(playerId) {
		const panel = playersData[playerId].panel
		if (panel) return panel

		const _panel = div(parent, { parentKey: `overHeroThings-${playerId}`, className: "over-hero-things" })

		img(_panel, { parentKey: "title", image: ImageUtils.resolve("guild/banner.png") })
			.visible = false

		_panel.title.particle = $.CreatePanel("DOTAParticleScenePanel", _panel.title, "", {
			particleName: "particles/guild/behind_banner_1.vpcf",
			particleonly: true,
			cameraOrigin: "0 255 0",
			lookAt: "0 0 0",
			fov: "70",
			hittest: false,
		})

		span(_panel.title, { parentKey: "label", text: "#guild_shop_visual_guild_title_text" })

		div(_panel, { parentKey: "guild" })

		span(_panel.guild, { parentKey: "role", text: "Leader" })
			.visible = false
		span(_panel.guild, { parentKey: "name", text: "Ф".repeat(20) })
			.visible = false

		playersData[playerId].panel = _panel
		
		if (parentIsDotaHUD) {
			setupHeroPanelStyles(_panel)

			const firstParentChild = parent.GetChild(0)

			if (firstParentChild)
				parent.MoveChildBefore(_panel, firstParentChild)
		}

		return _panel
	}

	const offsetY = -55

	function renderThings() {
		for (const playerId in playersData) {
			const panel = initHeroPanel(playerId)

			if (hideAboveHeadThings) {
				if (panel.visible)
					panel.visible = false
				
				continue
			}

			const { hero } = playersData[playerId]
			if (!hero || !Entities.IsAlive(hero)) {
				if (panel.visible)
					panel.visible = false

				continue
			}

			if (!panel.visible)
				panel.visible = true

			const heroOrigin = Entities.GetAbsOrigin(hero)

			const healthBarOffset = Entities.GetHealthBarOffset(hero)

			let wx = Game.WorldToScreenX(heroOrigin[0], heroOrigin[1], heroOrigin[2] + healthBarOffset)
			let wy = Game.WorldToScreenY(heroOrigin[0], heroOrigin[1], heroOrigin[2] + healthBarOffset)

			let x = wx
			let y = wy

			const pw = panel.actuallayoutwidth
			const ph = panel.actuallayoutheight

			x -= pw / 2
			y -= ph

			const scale = 1080 / screenheight

			x = Math.round(x * scale)
			y = Math.round(y * scale + offsetY)
			
			if (!isFinite(x) || isNaN(x) || !isFinite(y) || isNaN(y)) {
				x = -1000
				y = -1000
				panel.visible = false
			} else {
				panel.visible = true
			}

			panel.style.position = x + "px " + y + "px 0px"
		}

		$.Schedule(1 / 200, renderThings)
	}

	renderThings()

	function init() {
		const heroes = getAllHeroes()
		if (heroes.length === 0)
			return $.Schedule(1 / 10, init)

		for (const i in heroes) {
			const hero = heroes[i]

			const playerId = Entities.GetPlayerOwnerID(hero)

			if (!playersData[playerId]) {
				playersData[playerId] = {
					hero,
				}
			} else {
				playersData[playerId].hero = hero
			}
		}
	}

	init()
	$.Schedule(5, init)
	$.Schedule(15, init)

	function handlePlayerData(data) {
		const playerId = data.playerId
		if (playerId == null) return

		if (!playersData[playerId]) {
			playersData[playerId] = {}
		}

		const playerData = playersData[playerId]

		initHeroPanel(playerId)

		if (Object.keys(data).length <= 1) {
			playerData.panel.title.visible = false
			playerData.panel.guild.name.visible = false
			playerData.panel.guild.role.visible = false
			return
		}

		if ("sid64" in data) {
			playerData.sid64 = data.sid64
		}

		if ("name" in data) {
			playerData.guildName = data.name
			playerData.panel.guild.name.text = playerData.guildName
		}

		if ("showGuildInfo" in data) {
			if (!Boolean(data.showGuildInfo)) {
				playerData.panel.guild.name.visible = false
				playerData.panel.guild.role.visible = false
			} else {
				playerData.panel.guild.name.visible = true

				const guildMember = !GUILD.isValid ? null : GUILD.members.cache.get(String(playerData.sid64))

				if (!guildMember) {
					playerData.panel.guild.role.visible = false
				} else {
					const role = guildMember.role

					playerData.panel.guild.role.text = guildMember.role.name
					playerData.panel.guild.role.style.color = guildMember.role.color
					playerData.panel.guild.role.visible = true
				}
			}
		}

		if ("showTitle" in data) {
			playerData.panel.title.visible = Boolean(data.showTitle)
		}
	}

	function updateRoles() {
		for (const playerId in playersData) {
			const playerData = playersData[playerId]

			const { panel } = playerData
			if (!panel) continue

			const guildMember = (!GUILD || !GUILD.isValid) ? null : GUILD.members.cache.get(String(playerData.sid64))
			if (!guildMember) continue

			const role = guildMember.role

			playerData.panel.guild.role.text = guildMember.role.name
			playerData.panel.guild.role.style.color = guildMember.role.color
		}

		$.Schedule(2, () => updateRoles())
	}
	updateRoles()

	GameEventsSubscribe("Guild:UpdatePlayerRenderGuildData", (playerData) => {
		handlePlayerData(playerData)
	})
}
)()