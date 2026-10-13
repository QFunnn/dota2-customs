--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


_G.client_profile = {
	names = setmetatable({}, { __mode = "k" }),
	time = {},
	count = {},
	depth = 0,
	total = 0,
	gap = 0,
	last = Plat_FloatTime(),
	window = Plat_FloatTime(),
	memory = collectgarbage("count"),
}

function ClientProfileWrap(class, field, func)
	local key = (client_profile.names[class] or "?") .. "." .. field
	return function(...)
		local profile = client_profile
		local start = Plat_FloatTime()
		local top = profile.depth == 0
		if top then
			profile.gap = math.max(profile.gap, start - profile.last)
			if start - profile.window > 0.1 then
				ClientProfileFlush(start)
			end
		end

		profile.depth = profile.depth + 1
		local ok, a, b, c = pcall(func, ...)
		profile.depth = profile.depth - 1

		local spent = Plat_FloatTime() - start
		profile.time[key] = (profile.time[key] or 0) + spent
		profile.count[key] = (profile.count[key] or 0) + 1
		if top then
			profile.total = profile.total + spent
			profile.last = start + spent
		end

		if not ok then
			error(a, 0)
		end
		return a, b, c
	end
end

function ClientProfileFlush(now)
	local profile = client_profile
	local memory = collectgarbage("count")

	if profile.total > 0.008 or profile.gap > 0.06 then
		local list = {}
		for key, _ in pairs(profile.time) do
			table.insert(list, key)
		end
		table.sort(list, function(a, b)
			return profile.time[a] > profile.time[b]
		end)

		print(
			string.format(
				"CLIENT LUA %.1f ms, window %.0f ms, gap %.0f ms, heap %.1f -> %.1f MB",
				profile.total * 1000,
				(now - profile.window) * 1000,
				profile.gap * 1000,
				profile.memory / 1024,
				memory / 1024
			)
		)
		for i = 1, math.min(10, #list) do
			print(string.format("  %s %.2f ms x%d", list[i], profile.time[list[i]] * 1000, profile.count[list[i]]))
		end
	end

	profile.time = {}
	profile.count = {}
	profile.total = 0
	profile.gap = 0
	profile.window = now
	profile.memory = memory
end