--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "units/full_body/activity_shanxiayin"
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
		["13"] = 8,
		["16"] = 9,
		["17"] = 10,
		["18"] = 13,
		["19"] = 13,
		["20"] = 13,
		["21"] = 13,
		["22"] = 13,
		["23"] = 13,
		["24"] = 13,
		["25"] = 13,
		["26"] = 13,
		["27"] = 13,
		["28"] = 13,
		["29"] = 13,
		["30"] = 13,
		["31"] = 13,
		["32"] = 13,
		["33"] = 13,
		["34"] = 13,
		["35"] = 13,
		["36"] = 13,
		["37"] = 13,
		["38"] = 13,
		["39"] = 13,
		["40"] = 13,
		["41"] = 13,
		["42"] = 13,
		["43"] = 13,
		["44"] = 13,
		["45"] = 13,
		["46"] = 13,
		["47"] = 13,
		["48"] = 13,
		["49"] = 13,
		["50"] = 13,
		["51"] = 13,
		["52"] = 48,
		["53"] = 51,
		["54"] = 51,
		["55"] = 51,
		["56"] = 51,
		["57"] = 51,
		["58"] = 51,
		["59"] = 51,
		["60"] = 51,
		["61"] = 51,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["65"] = 51,
		["66"] = 51,
		["67"] = 51,
		["68"] = 51,
		["69"] = 51,
		["70"] = 51,
		["71"] = 51,
		["72"] = 51,
		["73"] = 51,
		["74"] = 51,
		["75"] = 51,
		["76"] = 51,
		["77"] = 76,
		["78"] = 76,
		["79"] = 76,
		["80"] = 76,
		["81"] = 76,
		["82"] = 76,
		["83"] = 76,
		["84"] = 76,
		["85"] = 76,
		["86"] = 76,
		["87"] = 76,
		["88"] = 76,
		["89"] = 76,
		["90"] = 76,
		["91"] = 76,
		["92"] = 76,
		["93"] = 76,
		["94"] = 76,
		["95"] = 76,
		["96"] = 104,
		["97"] = 106,
		["98"] = 107,
		["100"] = 5,
		["101"] = 5,
	}
)
local d = {}
local e = require("lib.dota_ts_adapter")
local f = e.registerEntityFunction
f(nil, "Spawn", function(g, h)
	local i = "models/eom/hero/shanxiayin_chai/shanxiayin_chai.vmdl"
	local j = KeyValues.PortraitFullBody[i]
	if j == nil then
		return
	end
	local k = j.cameras.default or j.cameras.Default
	local l = {}
	local m = {
		classname = "portrait_world_unit",
		parentname = "root",
		origin = "0 0 0",
		model = i,
		EnableAutoStyles = 0,
		ModelScale = 1,
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
	table.insert(l, m)
	table.insert(
		l,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = k.PortraitPosition,
			angles = k.PortraitAngles,
			fov = k.PortraitFOV,
			ZFar = k.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		l,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = j.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = j.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = j.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = j.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = j.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = j.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = j.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = j.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = j.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = j.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = j.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = j.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = j.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = j.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = j.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(l)
	if j.PortraitParticle ~= nil then
		local n = ParticleManager:CreateParticle(j.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end)
return d