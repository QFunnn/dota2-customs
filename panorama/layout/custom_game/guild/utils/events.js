--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @template Arguments
 * @typedef {(args: Arguments) => void} GuildEventCallback
 */

/**
 * @template CallbackArgs
 * @typedef {(callback: GuildEventCallback<CallbackArgs>, validatorPanel: Panel) => void} PremadeGuildEventSubscriber
 */

/**
 * @typedef {Object} GuildPatchEventArgs
 * @property {Guild} guild
 * @property {(
 * 		"name" | "image" | "description" | "exp" | "level" | "expToNextLevel" | "expForLastDay" | "gp" | "crystals" | "merits" | "meritsForLastDay" | "settings" | "deputyPermissions"
 * )} key
 */

/**
 * @typedef {Object} RoleAddEventArgs
 * @property {Role} role
 */
/**
 * @typedef {Object} RoleDeleteEventArgs
 * @property {string} roleId
 */
/**
 * @typedef {Object} RolePatchEventArgs
 * @property {Role} role
 * @property {"color" | "name" | "order"} key
 */

/**
 * @typedef {Object} MemberAddEventArgs
 * @property {Member} member
 */
/**
 * @typedef {Object} MemberDeleteEventArgs
 * @property {string} memberId
 */
/**
 * @typedef {Object} MemberPatchEventArgs
 * @property {Member} member
 * @property {(
 * 		"role" | "level" | "merits" | "expForLastWeek" | "crystalsDonated" | "lastOnline" | "status"
 * )} key
 */

/**
 * @typedef {Object} TalentPatchEventArgs
 * @property {Talent} talent
 * @propertyA {"level"} key
 */

/**
 * @typedef {Object} QuestPatchEventArgs
 * @property {Quest} quest
 * @propertyA {"isCompleted" | "progress" | "contributors"} key
 */

/**
 * @typedef {Object} ServicePatchEventArgs
 * @property {Service} service
 * @propertyA {"purchases"} key
 */

/**
 * @typedef {Object} JoinRequestsUpdateEventArgs
 * @property {Collection<string, JoinRequest>} joinRequests
 */

/**
 * @typedef {Object} JoinRequestActionArgs
 * @property {string} id
 */

/**
 * @typedef {Object} AuditLogsUpdateEventArgs
 * @property {Collection<string, AuditLog>} auditLogs
 */

/**
 * @typedef {Object} GuildsUpdateEventArgs
 * @property {Collection<string, PartialGuild>} guilds
 */

/**
 * @typedef {Object} MessagesUpdateEventArgs
 * @property {Collection<string, Message>} messages
 */

/**
 * @typedef {Object} MessageAddEventArgs
 * @property {Message} message
 */

/**
 * @typedef {Object} MessageDeleteEventArgs
 * @property {string} id
 */

/**
 * @typedef {Object} EventTicketPatchEventArgs
 * @property {EventTicket} ticket
 * @propertyA {"purchases"} key
 */

/**
 * @param {Panel} validatorPanel
 */
function assertPanel(validatorPanel) {
	if (!validatorPanel) throw new Error("[GuildEvents] event can't be subscribed without `validatorPanel` argument")
	if (!validatorPanel.IsValid) throw new Error("[GuildEvents] provided `validatorPanel` agruments isn't panel")
	if (!validatorPanel.IsValid()) throw new Error("[GuildEvents] provided `validatorPanel` panel agruments isn't valid")
}

class GuildEvents {
	/**
	 * @private
	 */
	static _id = 0
	/**
	 * @private
	 * @type {Object.<number, {callback: GuildEventCallback, validatorPanel?: Panel}>}
	 */
	static _events = {}

	static PremadeEvents = {
		/**
		 * @type {PremadeGuildEventSubscriber<GuildPatchEventArgs>}
		 */
		GuildPatch: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Guild:Patch", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<RolePatchEventArgs>}
		 */
		RolePatch: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Role:Patch", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<RoleAddEventArgs>}
		 */
		RoleAdd: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Role:Add", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<RoleDeleteEventArgs>}
		 */
		RoleDelete: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Role:Delete", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<MemberPatchEventArgs>}
		 */
		MemberPatch: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Member:Patch", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<MemberAddEventArgs>}
		 */
		MemberAdd: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Member:Add", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<MemberDeleteEventArgs>}
		 */
		MemberDelete: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Member:Delete", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<TalentPatchEventArgs>}
		 */
		TalentPatch: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Talent:Patch", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<QuestPatchEventArgs>}
		 */
		QuestPatch: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Quest:Patch", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<ServicePatchEventArgs>}
		 */
		ServicePatch: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Service:Patch", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<JoinRequestsUpdateEventArgs>}
		 */
		JoinRequestsUpdate: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("JoinRequests:Update", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<JoinRequestActionArgs>}
		 */
		AcceptJoinRequest: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("JoinRequests:Accept", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<JoinRequestActionArgs>}
		 */
		RejectJoinRequest: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("JoinRequests:Reject", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<JoinRequestActionArgs>}
		 */
		InvalidJoinRequest: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("JoinRequests:Invalid", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<AuditLogsUpdateEventArgs>}
		 */
		AuditLogsUpdate: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("AuditLogs:Update", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<GuildsUpdateEventArgs>}
		 */
		GuildsUpdate: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Guilds:Update", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<MessagesUpdateEventArgs>}
		 */
		MessagesUpdate: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Messages:Update", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<MessageAddEventArgs>}
		 */
		MessageAdd: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Messages:Add", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<MessageDeleteEventArgs>}
		 */
		MessageDelete: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("Messages:Delete", callback, validatorPanel)
		},
		/**
		 * @type {PremadeGuildEventSubscriber<EventTicketPatchEventArgs>}
		 */
		EventTicketPatch: (callback, validatorPanel) => {
			assertPanel(validatorPanel)
			this.Subscribe("EventTicket:Patch", callback, validatorPanel)
		},
	}

	/**
	 * @param {string} name
	 * @param {GuildEventCallback<unknown>} callback
	 * @param {Panel} [validatorPanel]
	 * @returns
	 */
	static Subscribe(name, callback, validatorPanel) {
		assertPanel(validatorPanel)

		this._events[name] ??= {}

		const id = this._id + 1

		this._id = id

		const event = { callback, validatorPanel }

		this._events[name][id] = event

		return id
	}
	/**
	 * @param {string} name
	 * @param {number} id
	 */
	static UnSubscribe(name, id) {
		if (!this._events[name] || !this._events[name][id]) return

		delete this._events[name][id]
	}
	/**
	 * @param {string} name
	 * @param {any} args
	 */
	static Call(name, args) {
		const events = this._events[name]
		if (!events) return

		const eventIdsToDelete = []

		for (const eventId in events) {
			const { callback, validatorPanel } = events[eventId]

			if (!validatorPanel.IsValid()) {
				eventIdsToDelete.push(eventId)
				continue
			}

			callback(args)
		}

		eventIdsToDelete.forEach((eventId) => {
			delete events[eventId]
		})
	}
}