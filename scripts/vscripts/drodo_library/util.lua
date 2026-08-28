--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function JoinTableString(t)
	local str = ""
	for _, v in pairs(t) do
		str = str .. v .. ","
	end
	return string.sub(str, 1, -2)
end

function RemindSelect(keys)
	local caster = keys.caster
	if caster == nil or caster:IsNull() == true or caster:GetClassname() ~= "npc_dota_creature" then
		return
	end
	if caster.is_reminding ~= nil and caster.is_reminding == true then
		return
	end
	caster.is_reminding = true

	local model_scale = caster:GetModelScale()
	local big_duration = keys.big_duration or 0

	for i = 1, 10 do
		SetUnitModel({
			unit = caster,
			delay = i * 0.03,
			scale = model_scale + (i * 0.05),
		})
	end
	for i = 1, 10 do
		SetUnitModel({
			unit = caster,
			delay = 0.3 + big_duration + i * 0.03,
			scale = model_scale + ((10 - i) * 0.05),
		})
	end
	Timers:CreateTimer(big_duration + 1, function()
		if caster == nil or caster:IsNull() == true then
			return
		end
		SetUnitModel({
			unit = caster,
			scale = model_scale,
		})
		caster.is_reminding = nil
	end)
end

function SetUnitModel(keys)
	local unit = keys.unit
	local delay = keys.delay or 0
	if unit == nil or unit:IsNull() == true then
		return
	end
	Timers:CreateTimer(delay, function()
		if unit == nil or unit:IsNull() == true then
			return
		end
		if keys.model ~= nil then
			unit:SetOriginalModel(keys.model)
			unit:SetModel(keys.model)
		end
		if keys.skin ~= nil then
			unit:SetSkin(keys.skin)
		end
		if keys.scale ~= nil then
			unit:SetModelScale(keys.scale)
		end
	end)
end