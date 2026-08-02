--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} GuildData
 * @property {number | String} created_at
 * 
 * @property {string} id
 * 
 * @property {string} name
 * @property {string} image
 * @property {string} description
 * 
 * @property {number | String} [name_change_unavailable_until]
 * 
 * @property {Object} [booster]
 * @property {number | string} bought_at
 * @property {number | string} expires_at
 * 
 * @property {number} exp
 * @property {number} level
 * @property {number} exp_to_next_level
 * @property {number} exp_for_last_day
 * 
 * @property {number} gp
 * @property {number} crystals
 * 
 * @property {number} merits
 * @property {number} merits_for_last_day
 * 
 * @property {number} members_max
 * 
 * @property {number} settings_bitfield
 * @property {number} deputy_permissions_bitfield
 * 
 * @property {string} image_upload_token
 * 
 * @property {RolesData} roles
 * @property {MembersData} members
 * @property {TalentsData} talents
 * @property {SpeedrunsDataActive | SpeedrunsDataNonActive} speedruns
 * @property {QuestsData} quests
 * @property {ServicesData} services
 * @property {EventTicketsData} event_tickets
 */

/**
 * @typedef {Object} GuildConfig
 * @property {number} create_guild_price
 * 
 * @property {number} name_change_price
 * 
 * @property {number} guild_name_min_length
 * @property {number} guild_name_max_length
 * 
 * @property {number} guild_description_max_lines
 * @property {number} guild_description_max_length
 * 
 * @property {number} guild_exp_booster_value
 * @property {number} guild_exp_booster_duration_days
 * 
 * @property {number} chat_input_max_lines
 * @property {number} chat_input_max_length
 * 
 * @property {number} role_name_max_length
 */

/**
 * @typedef {Object} GuildConfigs
 * @property {GuildConfig} guild_config
 * @property {TalentsConfig} talents_config
 * @property {QuestsConfig} quests_config
 * @property {ServicesConfig} services_config
 * @property {EventTicketsConfig} event_tickets_config
 */

/**
 * @typedef {Omit<GuildData, "createdAt" | "roles" | "members" | "talents" | "quests" | "services">} GuildPatchDataType
 * 
 * @typedef {Object} GuildPatchDataExtra
 * @property {RolesPatchData} roles
 * @property {MembersPatchData} members
 * @property {TalentsPatchData} talents
 * @property {QuestsPatchData} quests
 * @property {ServicesPatchData} services
 * 
 * @typedef {GuildPatchDataType & GuildPatchDataExtra} GuildPatchData
 */

class Guild extends UpdateManager {
	/** @type {number | undefined} */
	nameChangeUnavailableUntil

	/** @type {{ boughtAt: number, expiresAt: number }} */
	booster

	/**
	 * @param {GuildConfigs} data
	 */
	constructor(data) {
		super()

		this.isValid = false

		const {
			guild_config,
			talents_config,
			quests_config,
			services_config,
			event_tickets_config,
		} = data

		this.createGuildPrice = parseNumber(guild_config.create_guild_price)

		this.nameChangePrice = parseNumber(guild_config.name_change_price)

		this.guildNameMinLength = parseNumber(guild_config.guild_name_min_length)
		this.guildNameMaxLength = parseNumber(guild_config.guild_name_max_length)

		this.guildDescriptionMaxLines = parseNumber(guild_config.guild_description_max_lines)
		this.guildDescriptionMaxLength = parseNumber(guild_config.guild_description_max_length)

		this.expBoosterValue = parseNumber(guild_config.guild_exp_booster_value) / 100
		this.expBoosterDurationDays = parseNumber(guild_config.guild_exp_booster_duration_days)

		this.chatInputMaxLines = parseNumber(guild_config.chat_input_max_lines)
		this.chatInputMaxLength = parseNumber(guild_config.chat_input_max_length)

		this.roleNameMaxLength = parseNumber(guild_config.role_name_max_length)

		this.createdAt = Number()

		this.id = String()

		this.name = String()
		this.image = String()
		this.description = String()

		this.exp = Number()
		this.level = Number()
		this.expToNextLevel = Number()
		this.expForLastDay = Number()

		this.gp = Number()
		this.crystals = Number()

		this.merits = Number()
		this.meritsForLastDay = Number()

		this.maxMembers = Number()

		this.settings = new SettingsBitField(0)
		this.deputyPermissions = new DeputyPermissionsBitField(0)

		this.imageUploadToken = String()

		this.roles = new RolesManager(this)
		this.members = new MembersManager(this)
		this.talents = new TalentsManager(talents_config, this)
		/** @type {Speedruns} */
		this.speedruns = undefined
		this.quests = new QuestsManager(quests_config, this)
		this.services = new ServicesManager(services_config, this)

		this.joinRequests = new JoinRequestsManager(this)
		this.auditLogs = new AuditLogsManager(this)

		this.messages = new MessagesManager(this)

		this.eventTickets = new EventTicketsManager(event_tickets_config, this)

		this.setupRequestUpdate("Guild:Init", 10)
	}

	/**
	 * @param {GuildData} guildData
	 */
	populate(guildData, speedrunsData) {
		this.isValid = true

		// this.createdAt = parseNumber(guildData.created_at)
		this.createdAt = parseDateTime(guildData.created_at)

		this.id = String(guildData.id)

		this.name = String(guildData.name)
		this.image = ImageUtils.resolveGuildImage(String(guildData.image))
		this.description = guildData.description && guildData.description !== "" ? String(guildData.description) : undefined

		if ("name_change_unavailable_until" in guildData)
			this.nameChangeUnavailableUntil = parseDateTime(guildData.name_change_unavailable_until)

		if ("booster" in guildData)
			this.booster = {
				boughtAt: parseDateTime(guildData.booster.bought_at),
				expiresAt: parseDateTime(guildData.booster.expires_at),
			}

		this.exp = parseNumber(guildData.exp)
		this.level = parseNumber(guildData.level)
		this.expToNextLevel = parseNumber(guildData.exp_to_next_level)
		this.expForLastDay = parseNumber(guildData.exp_for_last_day)

		this.gp = parseNumber(guildData.gp)
		this.crystals = parseNumber(guildData.crystals)

		this.merits = parseNumber(guildData.merits)
		this.meritsForLastDay = parseNumber(guildData.merits_for_last_day)

		this.maxMembers = parseNumber(guildData.members_max)

		this.settings.bitfield = BitField.resolve(guildData.settings_bitfield)
		this.deputyPermissions.bitfield = BitField.resolve(guildData.deputy_permissions_bitfield)
		
		if ("image_upload_token" in guildData) {
			const imageUploadToken = guildData.image_upload_token
			if (imageUploadToken) {
				this.imageUploadToken = String(imageUploadToken)
			}
		}

		this.roles.populate(guildData.roles)
		this.members.populate(guildData.members)
		this.talents.populate(guildData.talents)
		this.speedruns = new Speedruns(speedrunsData, this)
		this.quests.populate(guildData.quests)
		this.services.populate(guildData.services)

		this.joinRequests.startRepeatableRequestUpdate(true)

		this.messages.startRepeatableRequestUpdate(true)

		this.eventTickets.populate(guildData.event_tickets)
	}

	/**
	 * @param {GuildPatchData} patchData
	 */
	patch(patchData) {
		if (!this.isValid) return

		if ("name" in patchData) this.patchPropertyWithEvent("name", String(patchData.name))
		if ("image" in patchData) this.patchPropertyWithEvent("image", ImageUtils.resolveGuildImage(String(patchData.image)))
		if ("description" in patchData) this.patchPropertyWithEvent("description", patchData.description === "" ? undefined : String(patchData.description))
		
		if ("name_change_unavailable_until" in patchData) this.patchPropertyWithEvent("nameChangeUnavailableUntil", parseDateTime(patchData.name_change_unavailable_until))

		if ("booster" in patchData)
			this.patchPropertyWithEvent("booster", {
				boughtAt: parseDateTime(patchData.booster.bought_at),
				expiresAt: parseDateTime(patchData.booster.expires_at),
			})

		if ("exp" in patchData) this.patchPropertyWithEvent("exp", parseNumber(patchData.exp))
		if ("level" in patchData) this.patchPropertyWithEvent("level", parseNumber(patchData.level))
		if ("exp_to_next_level" in patchData) this.patchPropertyWithEvent("expToNextLevel", parseNumber(patchData.exp_to_next_level))
		if ("exp_for_last_day" in patchData) this.patchPropertyWithEvent("expForLastDay", parseNumber(patchData.exp_for_last_day))

		if ("gp" in patchData) this.patchPropertyWithEvent("gp", parseNumber(patchData.gp))
		if ("crystals" in patchData) this.patchPropertyWithEvent("crystals", parseNumber(patchData.crystals))

		if ("merits" in patchData) this.patchPropertyWithEvent("merits", parseNumber(patchData.merits))
		if ("merits_for_last_day" in patchData) this.patchPropertyWithEvent("meritsForLastDay", parseNumber(patchData.merits_for_last_day))

		if ("members_max" in patchData) this.patchPropertyWithEvent("maxMembers", parseNumber(patchData.members_max))

		if ("settings_bitfield" in patchData) {
			GUILD.settings.bitfield = SettingsBitField.resolve(patchData.settings_bitfield)
			this.patchPropertyWithEvent("settings", GUILD.settings)
		}
		if ("deputy_permissions_bitfield" in patchData) {
			GUILD.deputyPermissions.bitfield = SettingsBitField.resolve(patchData.deputy_permissions_bitfield)
			this.patchPropertyWithEvent("deputyPermissions", GUILD.deputyPermissions)
		}

		if ("roles" in patchData) this.roles.patch(patchData.roles)
		if ("members" in patchData) this.members.patch(patchData.members)
		if ("talents" in patchData) this.talents.patch(patchData.talents)
		if ("quests" in patchData) this.quests.patch(patchData.quests)
		if ("services" in patchData) this.services.patch(patchData.services)

		if ("join_requests" in patchData) this.joinRequests.patch(patchData.join_requests)
		if ("audit_logs" in patchData) this.auditLogs.patch(patchData.audit_logs)

		if ("chat_messages" in patchData) this.messages.patch(patchData.chat_messages)

		if ("event_tickets" in patchData) this.eventTickets.patch(patchData.event_tickets)
	}

	/**
	 * @param {string} key
	 * @param {unknown} value
	 */
	patchPropertyWithEvent(key, value) {
		this[key] = value

		GuildEvents.Call("Guild:Patch", {
			guild: this,
			key,
		})
	}

	reset() {
		this.isValid = false

		this.createdAt = Number()

		this.id = String()

		this.name = String()
		this.image = String()
		this.description = String()

		this.booster = undefined

		this.nameChangeUnavailableUntil = undefined

		this.exp = Number()
		this.level = Number()
		this.expToNextLevel = Number()
		this.expForLastDay = Number()

		this.gp = Number()
		this.crystals = Number()

		this.merits = Number()
		this.meritsForLastDay = Number()

		this.maxMembers = Number()

		this.roles.reset()
		this.members.reset()
		this.talents.reset()
		this.speedruns = undefined
		this.quests.reset()
		this.services.reset()

		this.joinRequests.reset()
		this.auditLogs.reset()

		this.messages.reset()

		this.eventTickets.reset()
	}

	onPreSendUpdateRequest() {
		isReady = false

		this.reset()
	}

	get me() {
		return this.members.cache.get(localPlayerSteamId64)
	}

	get isFull() {
		return this.members.cache.size >= this.maxMembers
	}

	/**
	 * @param {number} leftTime
	 * @returns {string}
	 */
	formatBoosterLeftTime(leftTime) {
		const durationTable = ms2DurationTable(leftTime)

		const { days } = durationTable
		if (days === 0)
			return `${durationTable.hours}:${String(durationTable.minutes).padStart(2, "0")}:${String(durationTable.seconds).padStart(2, "0")}`

		const daysString = pluralLocalize("#guild_exp_booster_remaining_days", days).replace("{DAYS}", days)

		return `${daysString} ${durationTable.hours}:${String(durationTable.minutes).padStart(2, "0")}:${String(durationTable.seconds).padStart(2, "0")}`
	}

	canChangeName() {
		return !this.nameChangeUnavailableUntil || Date.now() > this.nameChangeUnavailableUntil
	}
}