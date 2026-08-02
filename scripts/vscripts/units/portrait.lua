--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "units/portrait"
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
		["14"] = 9,
		["15"] = 10,
		["16"] = 11,
		["17"] = 12,
		["20"] = 13,
		["21"] = 14,
		["24"] = 15,
		["25"] = 17,
		["26"] = 20,
		["27"] = 20,
		["28"] = 20,
		["29"] = 20,
		["30"] = 20,
		["31"] = 20,
		["32"] = 20,
		["33"] = 20,
		["34"] = 20,
		["35"] = 20,
		["36"] = 20,
		["37"] = 20,
		["38"] = 20,
		["39"] = 20,
		["40"] = 20,
		["41"] = 20,
		["42"] = 20,
		["43"] = 20,
		["44"] = 20,
		["45"] = 20,
		["46"] = 20,
		["47"] = 20,
		["48"] = 20,
		["49"] = 20,
		["50"] = 20,
		["51"] = 20,
		["52"] = 20,
		["53"] = 20,
		["54"] = 20,
		["55"] = 20,
		["56"] = 20,
		["57"] = 20,
		["58"] = 20,
		["59"] = 20,
		["61"] = 56,
		["62"] = 56,
		["66"] = 56,
		["68"] = 56,
		["69"] = 56,
		["70"] = 56,
		["72"] = 56,
		["74"] = 58,
		["75"] = 58,
		["76"] = 59,
		["77"] = 60,
		["78"] = 61,
		["80"] = 61,
		["82"] = 61,
		["83"] = 61,
		["84"] = 61,
		["86"] = 61,
		["87"] = 62,
		["88"] = 63,
		["89"] = 64,
		["90"] = 65,
		["91"] = 66,
		["94"] = 58,
		["97"] = 70,
		["98"] = 73,
		["99"] = 73,
		["100"] = 73,
		["101"] = 73,
		["102"] = 73,
		["103"] = 73,
		["104"] = 73,
		["105"] = 73,
		["106"] = 73,
		["107"] = 73,
		["108"] = 73,
		["109"] = 73,
		["110"] = 73,
		["111"] = 73,
		["112"] = 73,
		["113"] = 73,
		["114"] = 73,
		["115"] = 73,
		["116"] = 73,
		["117"] = 73,
		["118"] = 73,
		["119"] = 73,
		["120"] = 73,
		["121"] = 73,
		["122"] = 98,
		["123"] = 98,
		["124"] = 98,
		["125"] = 98,
		["126"] = 98,
		["127"] = 98,
		["128"] = 98,
		["129"] = 98,
		["130"] = 98,
		["131"] = 98,
		["132"] = 98,
		["133"] = 98,
		["134"] = 98,
		["135"] = 98,
		["136"] = 98,
		["137"] = 98,
		["138"] = 98,
		["139"] = 98,
		["140"] = 98,
		["141"] = 117,
		["142"] = 119,
		["143"] = 120,
		["145"] = 5,
		["146"] = 5,
	}
)
local d = {}
local e = require("lib.dota_ts_adapter")
local f = e.registerEntityFunction
f(nil, "Spawn", function(g, h)
	if _G._tPortraitList == nil or _G._tPortraitList[1] == nil then
		return
	end
	local i = _G._tPortraitList[1].name
	table.remove(_G._tPortraitList, 1)
	local j = KeyValues.UnitsKv[i]
	if j == nil then
		return
	end
	local k = KeyValues.Portrait[j.Model] or KeyValues.PortraitCustom[j.Model]
	if k == nil then
		return
	end
	local l = k.cameras.default or k.cameras.Default
	local m = {}
	local n = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = j.Model,
		EnableAutoStyles = 0,
		ModelScale = 1,
		suppress_intro_effects = 1,
		spawn_background_models = 0,
		rare_loadout_anim_chance = -1,
		suppress_anim_event_sounds = 0,
		skip_pet_spawn = 0,
		flying_courier = 0,
		spawn_wearable_item_defs = 1,
		activity = "ACT_DOTA_CAPTURE",
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
	local o
	if j ~= nil then
		o = j.Creature
	end
	local p
	if o ~= nil then
		p = o.AttachWearables
	end
	local q = p
	if q == nil then
		q = {}
	end
	local r = q
	do
		local s = 0
		while s <= 9 do
			local t = "item_def" .. tostring(s)
			local u = "style_index" .. tostring(s)
			local v = r[tostring(s + 1)]
			if v ~= nil then
				v = v.ItemDef
			end
			local w = v
			if w == nil then
				w = -1
			end
			local x = w
			local y = KeyValues.ItemsGame[tostring(x)]
			if y ~= nil then
				n[t] = x
				if y.visuals and y.visuals.skin then
					n[u] = y.visuals.skin
				end
			end
			s = s + 1
		end
	end
	table.insert(m, n)
	table.insert(
		m,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = l.PortraitPosition,
			angles = l.PortraitAngles,
			fov = l.PortraitFOV,
			ZFar = l.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		m,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = k.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = k.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = k.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = k.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = k.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = k.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = k.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = k.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = k.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = k.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = k.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = k.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = k.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = k.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = k.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(m)
	if k.PortraitParticle ~= nil then
		local z = ParticleManager:CreateParticle(k.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end)
return d