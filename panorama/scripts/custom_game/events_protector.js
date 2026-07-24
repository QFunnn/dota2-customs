--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


(() => {
	if (GameEvents.Subscribe_old !== undefined) {
		GameEvents.Subscribe = GameEvents.Subscribe_old
		GameEvents.SendCustomGameEventToServer = GameEvents.SendCustomGameEventToServer_old
		GameEvents.OnLoadedListeners = []
	}
	const client_key = Math.floor(Math.random() * Math.pow(2, 30))
	let server_key = undefined

	GameEvents.Subscribe_old = GameEvents.Subscribe

	GameEvents.Subscribe_custom = (name, listener) => GameEvents.Subscribe_old(name, data => {
		if (data.n === server_key)
			listener(data)
	})
	
	GameEvents.SendCustomGameEventToServer_old = GameEvents.SendCustomGameEventToServer

	GameEvents.SendCustomGameEventToServer_custom = (name, data) => {
		data.n = client_key
		GameEvents.SendCustomGameEventToServer_old(name, data)
		data.n = undefined
	}

	GameEvents.OnLoadedListeners = []
	GameEvents.Subscribe_old("ok", data => {
		if (data.n === client_key) {
			server_key = data.k
			GameEvents.OnLoadedListeners.forEach(f => f())
			GameEvents.OnLoadedListeners = []
		}
	})

	GameEvents.OnLoaded = listener => {
		if (server_key !== undefined)
			listener()
		else
			GameEvents.OnLoadedListeners.push(listener)
	}
	
	function ObtainKey() {
		if (server_key !== undefined)
			return
		GameEvents.SendCustomGameEventToServer_old("ok", {
			n: client_key
		})
		$.Schedule(0.2, ObtainKey)
	}
	ObtainKey()
})()