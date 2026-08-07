--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "units/portraits/beast_master"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["6"] = 1,
		["7"] = 1,
		["8"] = 5,
		["9"] = 5,
		["10"] = 5,
		["11"] = 5,
		["12"] = 6,
		["13"] = 7,
		["14"] = 7,
		["15"] = 7,
		["17"] = 7,
		["18"] = 8,
		["21"] = 9,
		["22"] = 9,
		["23"] = 9,
		["25"] = 9,
		["26"] = 11,
		["27"] = 11,
		["28"] = 11,
		["30"] = 11,
		["31"] = 12,
		["34"] = 13,
		["35"] = 15,
		["36"] = 23,
		["37"] = 23,
		["38"] = 23,
		["39"] = 23,
		["41"] = 18,
		["42"] = 18,
		["43"] = 18,
		["44"] = 18,
		["45"] = 18,
		["46"] = 18,
		["47"] = 18,
		["48"] = 18,
		["49"] = 18,
		["50"] = 18,
		["51"] = 18,
		["52"] = 18,
		["53"] = 18,
		["54"] = 18,
		["55"] = 18,
		["56"] = 18,
		["57"] = 18,
		["58"] = 18,
		["59"] = 18,
		["60"] = 18,
		["61"] = 18,
		["62"] = 18,
		["63"] = 18,
		["64"] = 18,
		["65"] = 18,
		["66"] = 18,
		["67"] = 18,
		["68"] = 18,
		["69"] = 18,
		["70"] = 18,
		["71"] = 18,
		["72"] = 18,
		["73"] = 18,
		["74"] = 18,
		["75"] = 18,
		["77"] = 55,
		["78"] = 55,
		["82"] = 55,
		["84"] = 55,
		["85"] = 55,
		["86"] = 55,
		["88"] = 55,
		["90"] = 57,
		["91"] = 57,
		["92"] = 58,
		["93"] = 59,
		["94"] = 60,
		["95"] = 60,
		["96"] = 60,
		["98"] = 60,
		["100"] = 60,
		["101"] = 60,
		["102"] = 60,
		["104"] = 60,
		["106"] = 60,
		["107"] = 61,
		["108"] = 61,
		["109"] = 61,
		["111"] = 61,
		["112"] = 62,
		["113"] = 63,
		["114"] = 64,
		["116"] = 66,
		["117"] = 67,
		["118"] = 68,
		["119"] = 69,
		["123"] = 57,
		["126"] = 74,
		["127"] = 77,
		["128"] = 77,
		["129"] = 77,
		["130"] = 77,
		["131"] = 77,
		["132"] = 77,
		["133"] = 77,
		["134"] = 77,
		["135"] = 77,
		["136"] = 77,
		["137"] = 77,
		["138"] = 77,
		["139"] = 77,
		["140"] = 77,
		["141"] = 77,
		["142"] = 77,
		["143"] = 77,
		["144"] = 77,
		["145"] = 77,
		["146"] = 77,
		["147"] = 77,
		["148"] = 77,
		["149"] = 77,
		["150"] = 77,
		["151"] = 102,
		["152"] = 102,
		["153"] = 102,
		["154"] = 102,
		["155"] = 102,
		["156"] = 102,
		["157"] = 102,
		["158"] = 102,
		["159"] = 102,
		["160"] = 102,
		["161"] = 102,
		["162"] = 102,
		["163"] = 102,
		["164"] = 102,
		["165"] = 102,
		["166"] = 102,
		["167"] = 102,
		["168"] = 102,
		["169"] = 102,
		["170"] = 121,
		["171"] = 123,
		["172"] = 124,
		["174"] = 5,
		["175"] = 5,
	}
)
local e = {}
local f = require("lib.dota_ts_adapter")
local g = f.registerEntityFunction
g(nil, "Spawn", function(h, i)
	local j = "beast_master"
	local k = KeyValues.UnitsKv[j]
	if k == nil then
		k = KeyValues.CosmeticsKV[j]
	end
	local l = k
	if l == nil then
		return
	end
	local m = l.Model
	if m == nil then
		m = l.resource
	end
	local n = m
	local o = KeyValues.Portrait[n]
	if o == nil then
		o = {}
	end
	local p = c(o, KeyValues.PortraitCustom[n])
	if p == nil then
		return
	end
	local q = p.cameras.default or p.cameras.Default
	local r = {}
	local s = tostring
	local t = l.Skin
	if t == nil then
		t = ""
	end
	local u = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = n,
		skin = s(t),
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
	local v
	if l ~= nil then
		v = l.Creature
	end
	local w
	if v ~= nil then
		w = v.AttachWearables
	end
	local x = w
	if x == nil then
		x = {}
	end
	local y = x
	do
		local z = 0
		while z <= 9 do
			local A = "item_def" .. tostring(z)
			local B = "style_index" .. tostring(z)
			local C = l["wearable" .. tostring(z + 1)]
			if C == nil then
				local D = y[tostring(z + 1)]
				if D ~= nil then
					D = D.ItemDef
				end
				local E = D
				if E == nil then
					E = -1
				end
				C = E
			end
			local F = C
			local G = l[("wearable" .. tostring(z + 1)) .. "style"]
			if G == nil then
				G = 0
			end
			local H = G
			u[A] = F
			if H ~= 0 then
				u[B] = H
			else
				local I = KeyValues.ItemsGame[tostring(F)]
				if I ~= nil then
					if I.visuals and I.visuals.skin then
						u[B] = I.visuals.skin
					end
				end
			end
			z = z + 1
		end
	end
	table.insert(r, u)
	table.insert(
		r,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = q.PortraitPosition,
			angles = q.PortraitAngles,
			fov = q.PortraitFOV,
			ZFar = q.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		r,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = p.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = p.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = p.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = p.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = p.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = p.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = p.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = p.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = p.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = p.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = p.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = p.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = p.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = p.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = p.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(r)
	if p.PortraitParticle ~= nil then
		local J = ParticleManager:CreateParticle(p.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end)
return e