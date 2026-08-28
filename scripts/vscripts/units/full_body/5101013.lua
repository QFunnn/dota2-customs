--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "units/full_body/5101013"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["5"] = 1,
		["6"] = 1,
		["7"] = 5,
		["8"] = 5,
		["9"] = 5,
		["10"] = 5,
		["11"] = 6,
		["12"] = 7,
		["13"] = 7,
		["14"] = 7,
		["16"] = 7,
		["17"] = 8,
		["20"] = 9,
		["21"] = 9,
		["22"] = 9,
		["24"] = 9,
		["25"] = 9,
		["26"] = 9,
		["28"] = 9,
		["29"] = 10,
		["32"] = 11,
		["33"] = 12,
		["34"] = 13,
		["35"] = 14,
		["37"] = 16,
		["38"] = 23,
		["39"] = 23,
		["40"] = 23,
		["42"] = 24,
		["43"] = 24,
		["44"] = 24,
		["45"] = 24,
		["47"] = 24,
		["48"] = 27,
		["49"] = 27,
		["51"] = 27,
		["52"] = 27,
		["54"] = 27,
		["56"] = 27,
		["57"] = 27,
		["58"] = 27,
		["60"] = 19,
		["61"] = 19,
		["62"] = 19,
		["63"] = 19,
		["64"] = 19,
		["65"] = 19,
		["66"] = 19,
		["67"] = 19,
		["68"] = 19,
		["69"] = 19,
		["70"] = 19,
		["71"] = 19,
		["72"] = 19,
		["73"] = 19,
		["74"] = 19,
		["75"] = 19,
		["76"] = 19,
		["77"] = 19,
		["78"] = 19,
		["79"] = 19,
		["80"] = 19,
		["81"] = 19,
		["82"] = 19,
		["83"] = 19,
		["84"] = 19,
		["85"] = 19,
		["86"] = 19,
		["87"] = 19,
		["88"] = 19,
		["89"] = 19,
		["90"] = 19,
		["91"] = 19,
		["92"] = 19,
		["93"] = 19,
		["94"] = 19,
		["96"] = 56,
		["97"] = 56,
		["101"] = 56,
		["103"] = 56,
		["104"] = 56,
		["105"] = 56,
		["107"] = 56,
		["109"] = 58,
		["110"] = 58,
		["111"] = 59,
		["112"] = 60,
		["113"] = 61,
		["114"] = 61,
		["115"] = 61,
		["117"] = 61,
		["119"] = 61,
		["120"] = 61,
		["121"] = 61,
		["123"] = 61,
		["125"] = 61,
		["126"] = 62,
		["127"] = 62,
		["128"] = 62,
		["130"] = 62,
		["131"] = 63,
		["132"] = 64,
		["133"] = 65,
		["135"] = 67,
		["136"] = 68,
		["137"] = 69,
		["138"] = 70,
		["142"] = 58,
		["145"] = 75,
		["146"] = 78,
		["147"] = 78,
		["148"] = 78,
		["149"] = 78,
		["150"] = 78,
		["151"] = 78,
		["152"] = 78,
		["153"] = 78,
		["154"] = 78,
		["155"] = 78,
		["156"] = 78,
		["157"] = 78,
		["158"] = 78,
		["159"] = 78,
		["160"] = 78,
		["161"] = 78,
		["162"] = 78,
		["163"] = 78,
		["164"] = 78,
		["165"] = 78,
		["166"] = 78,
		["167"] = 78,
		["168"] = 78,
		["169"] = 78,
		["170"] = 103,
		["171"] = 103,
		["172"] = 103,
		["173"] = 103,
		["174"] = 103,
		["175"] = 103,
		["176"] = 103,
		["177"] = 103,
		["178"] = 103,
		["179"] = 103,
		["180"] = 103,
		["181"] = 103,
		["182"] = 103,
		["183"] = 103,
		["184"] = 103,
		["185"] = 103,
		["186"] = 103,
		["187"] = 103,
		["188"] = 103,
		["189"] = 131,
		["190"] = 133,
		["191"] = 134,
		["193"] = 5,
		["194"] = 5,
	}
)
local d = {}
local e = require("lib.dota_ts_adapter")
local f = e.registerEntityFunction
f(nil, "Spawn", function(g, h)
	local i = "5101013"
	local j = KeyValues.UnitsKv[i]
	if j == nil then
		j = KeyValues.CosmeticsKV[i]
	end
	local k = j
	if k == nil then
		return
	end
	local l = KeyValues.PortraitFullBody[k.FullBody]
	if l == nil then
		l = KeyValues.PortraitFullBody[k.portrait]
	end
	local m = l
	if m == nil then
		m = KeyValues.PortraitFullBody[i]
	end
	local n = m
	if n == nil then
		return
	end
	local o = n.cameras.default or n.cameras.Default
	local p
	if k.portrait and k.hero and KeyValues.HeroIDCache[k.hero] then
		p = KeyValues.UnitsKv[KeyValues.HeroIDCache[k.hero]]
	end
	local q = {}
	local r = k.Model
	if r == nil then
		r = k.resource
	end
	local s = tostring
	local t = k.Skin
	if t == nil then
		t = ""
	end
	local u = s(t)
	local v = k.FullBodyModelScale
	if v == nil then
		local w
		if p ~= nil then
			w = p.FullBodyModelScale
		end
		v = w
	end
	local x = v
	if x == nil then
		x = 1
	end
	local y = {
		classname = "portrait_world_unit",
		parentname = "root",
		origin = "0 0 0",
		model = r,
		skin = u,
		EnableAutoStyles = 0,
		ModelScale = x,
		suppress_intro_effects = 1,
		spawn_background_models = 0,
		rare_loadout_anim_chance = -1,
		suppress_anim_event_sounds = 0,
		skip_pet_spawn = 0,
		flying_courier = 0,
		spawn_wearable_item_defs = 1,
		activity = "ACT_DOTA_LOADOUT",
		activity_modifier = "",
		item_def0 = 0,
		style_index0 = 0,
		item_def1 = 0,
		style_index1 = 0,
		item_def2 = 0,
		style_index2 = 0,
		item_def3 = 0,
		style_index3 = 0,
		item_def4 = 0,
		style_index4 = 0,
		item_def5 = 0,
		style_index5 = 0,
		item_def6 = 0,
		style_index6 = 0,
		item_def7 = 0,
		style_index7 = 0,
		rendercolor = "255 255 255",
	}
	local z
	if k ~= nil then
		z = k.Creature
	end
	local A
	if z ~= nil then
		A = z.AttachWearables
	end
	local B = A
	if B == nil then
		B = {}
	end
	local C = B
	do
		local D = 0
		while D <= 9 do
			local E = "item_def" .. tostring(D)
			local F = "style_index" .. tostring(D)
			local G = k["wearable" .. tostring(D + 1)]
			if G == nil then
				local H = C[tostring(D + 1)]
				if H ~= nil then
					H = H.ItemDef
				end
				local I = H
				if I == nil then
					I = -1
				end
				G = I
			end
			local J = G
			local K = k[("wearable" .. tostring(D + 1)) .. "style"]
			if K == nil then
				K = 0
			end
			local L = K
			y[E] = J
			if L ~= 0 then
				y[F] = L
			else
				local M = KeyValues.ItemsGame[tostring(J)]
				if M ~= nil then
					if M.visuals and M.visuals.skin then
						y[F] = M.visuals.skin
					end
				end
			end
			D = D + 1
		end
	end
	table.insert(q, y)
	table.insert(
		q,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = o.PortraitPosition,
			angles = o.PortraitAngles,
			fov = o.PortraitFOV,
			ZFar = o.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
			ZNear = 4,
			UseScreenAspectRatio = 0,
			aspectRatio = 1,
			fogEnable = 0,
			fogColor = "0 0 0",
			fogStart = 2048,
			fogEnd = 4096,
			fogMaxDensity = 1,
			rendercolor = "128 128 128",
			override_shadow_farz = 0,
			dof_enabled = 0,
			dof_near_blurry = 250,
			dof_near_crisp = 550,
			dac_dof_far_crisp = 1200,
			dac_dof_far_blurry = 1600,
			dac_dof_tilt_to_ground = 0.75,
		}
	)
	table.insert(
		q,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = n.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = n.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = n.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = n.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = n.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = n.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = n.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = n.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = n.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = n.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = n.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = n.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = n.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = n.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = n.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(q)
	if n.PortraitParticle ~= nil then
		local N = ParticleManager:CreateParticle(n.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end)
return d