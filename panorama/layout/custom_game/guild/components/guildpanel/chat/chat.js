--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


let chatOpened = false
let isFirstChatOpen = true
let lastUnreadCount = 0

function _getChatRoot() {
	try {
		if (!ROOT_MAIN_LAYER) return null
		if (!ROOT_MAIN_LAYER.guildPanel) return null
		if (!ROOT_MAIN_LAYER.guildPanel.contentContainer) return null
		const cc = ROOT_MAIN_LAYER.guildPanel.contentContainer
		const chat = cc.chat && (!cc.chat.IsValid || cc.chat.IsValid()) ? cc.chat : null
		return { cc, chat }
	} catch (e) {
		return null
	}
}

function openChat() {
	cancelCloseChatSchedule()

	chatOpened = true
	try {
		Game.EmitSound("ui.chat_open")
	} catch (e) { }

	const root = _getChatRoot()
	if (!root) return
	if (root.cc.chatBlur)
		root.cc.chatBlur.visible = true

	const chat = root.chat
	if (!chat) return

	chat.SetHasClass("opened", true)
	chat.visible = true

	if (chat.list && chat.list.handleNewMessagesDivider)
		chat.list.handleNewMessagesDivider()

	if (chat.inputArea && chat.inputArea.textEntry && chat.inputArea.textEntry.input && chat.inputArea.textEntry.input.SetFocus)
		chat.inputArea.textEntry.input.SetFocus()

	updateFreshestSawMessageTimestamp()

	updateChatButtonUnread()

	if (isFirstChatOpen) {
		isFirstChatOpen = undefined

		$.Schedule(0.1, function () {
			if (!chat.list || !chat.list.IsValid()) return

			chat.list.ScrollToBottom()
		})
	}
}

let closeChatScheduleId

function cancelCloseChatSchedule() {
	if (!closeChatScheduleId) return

	$.CancelScheduled(closeChatScheduleId)
	closeChatScheduleId = undefined
}

function closeChat() {
	closeActiveContextMenu()
	cancelCloseChatSchedule()

	chatOpened = false
	try {
		Game.EmitSound("ui.chat_close")
	} catch (e) { }

	const root = _getChatRoot()
	if (!root) return
	if (root.cc.chatBlur)
		root.cc.chatBlur.visible = false

	const chat = root.chat
	if (!chat) return

	chat.SetHasClass("opened", false)

	dropInputFocus()

	closeChatScheduleId = $.Schedule(0.2, function () {
		if (!chat || (chat.IsValid && !chat.IsValid())) return
		chat.visible = false
	})
}

function toggleChat() {
	if (chatOpened)
		closeChat()
	else
		openChat()
}

function chatIsOpened() {
	return chatOpened
}

let freshestSawMessageTimestamp

function updateFreshestSawMessageTimestamp() {
	const freshestMsg = GUILD.messages.cache.first()

	freshestSawMessageTimestamp = freshestMsg ? freshestMsg.timestamp : 0
}

function updateChatButtonUnread() {
	if (!freshestSawMessageTimestamp) {
		ROOT_MAIN_LAYER.guildPanel.topNav.chat.unread.visible = false
		lastUnreadCount = 0
		return
	}

	const unreadCount = GUILD.messages.cache.count(({ timestamp, content }) => {
		return timestamp > freshestSawMessageTimestamp
	})

	if (unreadCount === 0) {
		ROOT_MAIN_LAYER.guildPanel.topNav.chat.unread.visible = false
	} else {
		ROOT_MAIN_LAYER.guildPanel.topNav.chat.unread.visible = true
		ROOT_MAIN_LAYER.guildPanel.topNav.chat.unread.text = unreadCount <= 9 ? unreadCount : "9+"
	}

	// Soft notification sound: only when we go from 0 -> >0 and chat is closed.
	if (!chatIsOpened() && lastUnreadCount === 0 && unreadCount > 0) {
		try {
			Game.EmitSound("Chat.All.Received")
		} catch (e) { }
	}
	lastUnreadCount = unreadCount
}

function ChatButton(parent) {
	const chat = div(parent, { parentKey: "chat" })
	btn(chat, { parentKey: "button", onLeftClick: () => toggleChat() })
	span(chat, { parentKey: "unread" })
		.visible = false

	return chat
}

/**
 * @param {Panel} parent
 * @param {Message} msg
 */
function MessagePanel(parent, msg) {
	const msgPanel = btn(parent, { className: "message" })
	msgPanel.onLeftClick = () => {
		dropInputFocus()
	}
	msgPanel.onRightClick = () => {
		openMessageContextMenu(msg, msgPanel)
	}

	playerAvatar(msgPanel, { parentKey: "avatar", steamId: msg.authorId })

	div(msgPanel, { parentKey: "right" })

	div(msgPanel.right, { parentKey: "top" })

	playerName(msgPanel.right.top, { parentKey: "name", steamId: msg.authorId })

	const authorMember = GUILD.members.cache.get(msg.authorId)

	if (authorMember) {
		const roleColor = authorMember.role.color

		msgPanel.right.top.name.style.color = roleColor

		const roleLabel = span(msgPanel.right.top, { parentKey: "role", text: authorMember.role.name })

		roleLabel.style.textAlign = "center"

		roleLabel.style.backgroundColor = `gradient(linear, 0% 0%, 100% 50%, from(${roleColor}20), to(${roleColor}0a))`
		roleLabel.style.border = `1px solid ${roleColor}4d`
		roleLabel.style.borderRadius = "4px"
		roleLabel.style.color = `${roleColor}e4`
	} else if (msg.isSystem) {
		msgPanel.right.top.name.style.color = "#f00"

		const roleLabel = span(msgPanel.right.top, { parentKey: "role", text: "SYSTEM" })

		roleLabel.style.textAlign = "center"

		roleLabel.style.backgroundColor = `gradient(linear, 0% 0%, 100% 50%, from(#ff000020), to(#ff00000a))`
		roleLabel.style.border = `1px solid #ff00004d`
		roleLabel.style.borderRadius = "4px"
		roleLabel.style.color = `#fff`
	} else {
		msgPanel.right.top.name.style.color = "#8a9ba870"
	}

	span(msgPanel.right.top, { parentKey: "timestamp", text: msg.shortTimestampString })
	msgPanel.right.top.timestamp.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent(
			"DOTAShowTextTooltip",
			msgPanel.right.top.timestamp,
			msg.fullTimestampString
		)
	})
	msgPanel.right.top.timestamp.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip"))

	div(msgPanel.right, { parentKey: "bottom" })
	span(msgPanel.right.bottom, { parentKey: "content", text: msg.content })

	return msgPanel
}

/**
 * @param {Panel} parent
 */
function Chat(parent) {
	const chat = btn(parent, {
		parentKey: "chat",
		onLeftClick: () => {
			dropInputFocus()
		},
	})
	chat.visible = false

	/**
	 * @type {Collection<string, { panel: Panel, message: Message }>}
	 */
	const messagePanelsData = new Collection()

	divbtn(chat, { parentKey: "list" })
	chat.list.fill = () => {
		deleteChildByKey(chat.list, "loading")

		messagePanelsData.clear()

		const { messages } = GUILD

		chat.list.messages.RemoveAndDeleteChildren()

		messages.cache.forEach((msg) => {
			messagePanelsData.set(msg.id, {
				panel: MessagePanel(chat.list.messages, msg),
				message: msg,
			})
		})

		$.Schedule(0, function () {
			if (!chat.list.IsValid()) return

			chat.list.ScrollToBottom()
		})
	}
	chat.list.handleNewMessagesDivider = () => {
		deleteChildByKey(chat.list.messages, "newMessagesDivider")

		if (!freshestSawMessageTimestamp)
			return

		/** @type {Panel} */
		let prevMsgPanel

		for (const msg of GUILD.messages.cache.values()) {
			if (freshestSawMessageTimestamp >= msg.timestamp) {
				if (!prevMsgPanel)
					break

				const divider = div(chat.list.messages, { parentKey: "newMessagesDivider" })
				div(chat.list.messages.newMessagesDivider, { className: "line" })
				span(chat.list.messages.newMessagesDivider, { className: "label", text: "#guild_chat_new_messages" })
				div(chat.list.messages.newMessagesDivider, { className: "line" })

				chat.list.messages.MoveChildAfter(divider, prevMsgPanel)
				break
			}

			prevMsgPanel = messagePanelsData.get(msg.id).panel
		}
	}
	/**
	 * @param {string} msgId
	 */
	chat.list.deleteMessage = (msgId) => {
		const { panel } = messagePanelsData.get(msgId)

		safeDeletePanel(panel)

		messagePanelsData.delete(msgId)

		deleteChildByKey(chat.list.messages, "newMessagesDivider", (divider) => {
			return chat.list.messages.GetChild(1) === divider
		})
	}

	btn(chat.list, { parentKey: "update", text: "#guild_join_requests_update" })
	chat.list.update.onLeftClick = () => {
		if (!GUILD.messages.requestUpdate()) return

		messagePanelsData.clear()
		chat.list.messages.RemoveAndDeleteChildren()

		deleteChildByKey(chat.list, "loading")
		div(chat.list, { parentKey: "loading" })
		div(chat.list.loading, { parentKey: "inner" })
	}

	div(chat.list, { parentKey: "messages" })

	let firstUpdate = true

	GuildEvents.PremadeEvents.MessagesUpdate(({ messages }) => {
		if (firstUpdate) {
			chat.list.fill()
			firstUpdate = undefined

			updateFreshestSawMessageTimestamp()
			return
		}

		if (chatIsOpened()) {
			const isManualUpdate = !!chat.list.loading
			if (isManualUpdate)
				chat.list.fill()

			chat.list.handleNewMessagesDivider()

			updateFreshestSawMessageTimestamp()

			if (isManualUpdate)
				return
		} else {
			updateChatButtonUnread()

			if (chat.list.loading) {
				chat.list.fill()
				return
			}
		}

		const absSortedMessagesIntersection = Array.from(
			new Set([
				...messages.values(),
				...messagePanelsData.map(({ message }) => message)
			])
		)
			.sort(({ timestamp: t1 }, { timestamp: t2 }) => t1 - t2)

		absSortedMessagesIntersection.forEach((msg) => {
			const { id: msgId } = msg

			if (!messages.has(msgId)) {
				if (messagePanelsData.has(msgId))
					chat.list.deleteMessage(msgId)
			} else {
				if (messagePanelsData.has(msgId))
					return

				const firstMsgPanel = chat.list.messages.GetChild(0)

				const msg = messages.get(msgId)
				const msgPanel = MessagePanel(chat.list.messages, msg)

				if (firstMsgPanel)
					chat.list.messages.MoveChildBefore(msgPanel, firstMsgPanel)

				messagePanelsData.set(msgId, {
					panel: msgPanel,
					message: msg,
				})
			}
		})
	}, chat)
	GuildEvents.PremadeEvents.MessageAdd(({ message: addedMsg }) => {
		if (chatIsOpened()) {
			freshestSawMessageTimestamp = addedMsg.timestamp
		}

		const scrollToBottom = chat.list.contentheight > chat.list.actuallayoutheight
			&& (chat.list.actuallayoutheight - chat.list.contentheight) >= (chat.list.scrolloffset_y - 2)

		const msgPanel = MessagePanel(chat.list.messages, addedMsg)

		messagePanelsData.set(addedMsg.id, {
			panel: msgPanel,
			message: addedMsg,
		})

		for (const msg of GUILD.messages.cache.values()) {
			if (addedMsg.timestamp > msg.timestamp) {
				chat.list.messages.MoveChildBefore(msgPanel, messagePanelsData.get(msg.id).panel)
				break
			}
		}

		if (scrollToBottom)
			$.Schedule(0, function () {
				if (!chat.list || !chat.list.IsValid()) return

				chat.list.ScrollToBottom()
			})
	}, chat)
	GuildEvents.PremadeEvents.MessageDelete(({ id: msgId }) => {
		chat.list.deleteMessage(msgId)
	}, chat)

	div(chat, { parentKey: "inputArea" })
	textEntry(chat.inputArea, { parentKey: "textEntry", placeholder: "#guild_chat_text_area_placeholder", multiline: true, maxLines: GUILD.chatInputMaxLines, maxChars: GUILD.chatInputMaxLength })
	chat.inputArea.textEntry.onChange = () => {
		chat.inputArea.send.enabled = !!chat.inputArea.textEntry.input.text.length
	}
	chat.inputArea.textEntry.onInputSubmit = () => {
		/** @type {string} */
		const text = chat.inputArea.textEntry.input.text.trim()

		if (!text.length) return

		GameEvents.SendCustomGameEventToServer("Guild:SendMessage", { text })

		chat.inputArea.textEntry.input.text = ""
	}
	btn(chat.inputArea, { parentKey: "send", enabled: false })
	img(chat.inputArea.send, { parentKey: "icon", image: ICON.GOLD_ARROW })
	chat.inputArea.send.onLeftClick = () => {
		chat.inputArea.textEntry.onInputSubmit()
	}
	
	chat.list.fill()

	return chat
}

/**
 * @param {Message} msg
 * @param {Panel} msgPanel
 */
function openMessageContextMenu(msg, msgPanel) {
	if (msg.isSystem) return

	const { me } = GUILD

	if (msg.authorId !== me.id) {
		const selfRole = me.role

		if (!(selfRole.isLeader || selfRole.isDeputy))
			return

		const authorMember = GUILD.members.cache.get(msg.authorId)

		if (authorMember && authorMember.isLeader && !selfRole.isLeader)
			return
	}

	const ctxMenu = contextMenu([
		{
			id: "delete",
			type: "button",
			text: "#guild_chat_delete",
			image: ImageUtils.resolve("❌"),
			onClick: () => GameEvents.SendCustomGameEventToServer("Guild:DeleteMessage", { messageId: msg.id }),
		}
	])

	if (!ctxMenu) return
}