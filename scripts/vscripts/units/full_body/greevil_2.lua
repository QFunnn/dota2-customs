--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "units/full_body/greevil_2"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["4"] = 2,
		["5"] = 4,
		["6"] = 5,
		["7"] = 6,
		["10"] = 7,
		["11"] = 8,
		["14"] = 9,
		["15"] = 10,
		["16"] = 13,
		["17"] = 13,
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
		["52"] = 51,
		["53"] = 54,
		["54"] = 54,
		["55"] = 54,
		["56"] = 54,
		["57"] = 54,
		["58"] = 54,
		["59"] = 54,
		["60"] = 54,
		["61"] = 54,
		["62"] = 54,
		["63"] = 54,
		["64"] = 54,
		["65"] = 54,
		["66"] = 54,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 54,
		["71"] = 54,
		["72"] = 54,
		["73"] = 54,
		["74"] = 54,
		["75"] = 54,
		["76"] = 54,
		["77"] = 79,
		["78"] = 79,
		["79"] = 79,
		["80"] = 79,
		["81"] = 79,
		["82"] = 79,
		["83"] = 79,
		["84"] = 79,
		["85"] = 79,
		["86"] = 79,
		["87"] = 79,
		["88"] = 79,
		["89"] = 79,
		["90"] = 79,
		["91"] = 79,
		["92"] = 79,
		["93"] = 79,
		["94"] = 79,
		["95"] = 79,
		["96"] = 98,
		["97"] = 100,
		["98"] = 101,
		["100"] = 2,
	}
)
function Spawn(self, d)
	local e = "greevil_2"
	local f = KeyValues.GreevilAbilityKV[e]
	if f == nil then
		return
	end
	local g = KeyValues.PortraitFullBody[e]
	if g == nil then
		return
	end
	local h = g.cameras.default or g.cameras.Default
	local i = {}
	local j = {
		classname = "portrait_world_unit",
		parentname = "root",
		origin = "0 0 0",
		angles = "0 -60 0",
		model = "models/units/greevil_custom/greevil_custom.vmdl",
		skin = tostring(f.ModelSkin),
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
	table.insert(i, j)
	table.insert(
		i,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = h.PortraitPosition,
			angles = h.PortraitAngles,
			fov = h.PortraitFOV,
			ZFar = h.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		i,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = g.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = g.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = g.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = g.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = g.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = g.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = g.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = g.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = g.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = g.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = g.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = g.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = g.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = g.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = g.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(i)
	if g.PortraitParticle ~= nil then
		local k = ParticleManager:CreateParticle(g.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end