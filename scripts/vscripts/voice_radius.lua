--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


if voice_radius == nil then
	_G.voice_radius = class({})
end

voice_radius.THINK_INTERVAL = 0.5
voice_radius.DEFAULT_RADIUS = 1200

function voice_radius:IsEnabled()
	return pro_mod == true and pro_mod_data.enable_voice_radius == true
end

function voice_radius:GetRadius()
	local radius = tonumber(pro_mod_data.voice_radius)
	if not radius or radius <= 0 then
		radius = self.DEFAULT_RADIUS
	end
	return radius
end

function voice_radius:Init()
	if not IsServer() then
		return
	end

	self.hear_sig = {}

	if not self:IsEnabled() then
		CustomNetTables:SetTableValue("voice_radius", "config", { enabled = 0, radius = 0 })
		return
	end

	CustomNetTables:SetTableValue("voice_radius", "config", { enabled = 1, radius = self:GetRadius() })

	Convars:SetInt("sv_allchat", 1)
	Convars:SetInt("sv_alltalk", 1)
	SendToServerConsole("sv_allchat 1")
	SendToServerConsole("sv_alltalk 1")

	Timers:CreateTimer({
		useGameTime = false,
		endTime = 1,
		callback = function()
			self:Think()
			return self.THINK_INTERVAL
		end,
	})
end

function voice_radius:Think()
	local radius = self:GetRadius()
	local origins = {}

	for id = 0, 24 do
		if ValidId(id) then
			local hero = PlayerResource:GetSelectedHeroEntity(id)
			if hero and not hero:IsNull() then
				origins[id] = hero:GetAbsOrigin()
			end
		end
	end

	for id = 0, 24 do
		if ValidId(id) then
			local list = {}
			local origin = origins[id]

			if origin then
				for other_id, other_origin in pairs(origins) do
					if other_id ~= id and (other_origin - origin):Length2D() <= radius then
						list[#list + 1] = other_id
					end
				end
				table.sort(list)
			end

			local signature = table.concat(list, ",")
			if self.hear_sig[id] ~= signature then
				self.hear_sig[id] = signature
				CustomNetTables:SetTableValue("voice_radius", tostring(id), { players = list, count = #list })
			end
		end
	end
end