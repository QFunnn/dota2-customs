--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "units/player_portraits/player_portrait_7"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["5"] = 2,
		["6"] = 3,
		["7"] = 4,
		["10"] = 7,
		["11"] = 8,
		["12"] = 9,
		["13"] = 9,
		["14"] = 9,
		["16"] = 9,
		["17"] = 10,
		["20"] = 11,
		["21"] = 11,
		["22"] = 11,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["30"] = 17,
		["31"] = 17,
		["32"] = 17,
		["34"] = 17,
		["35"] = 18,
		["38"] = 19,
		["39"] = 20,
		["40"] = 21,
		["41"] = 21,
		["42"] = 21,
		["43"] = 21,
		["45"] = 21,
		["46"] = 22,
		["47"] = 23,
		["49"] = 25,
		["50"] = 28,
		["51"] = 28,
		["52"] = 28,
		["53"] = 28,
		["54"] = 28,
		["55"] = 28,
		["56"] = 28,
		["57"] = 28,
		["58"] = 28,
		["59"] = 28,
		["60"] = 28,
		["61"] = 28,
		["62"] = 28,
		["63"] = 28,
		["64"] = 28,
		["65"] = 28,
		["66"] = 28,
		["67"] = 28,
		["68"] = 28,
		["69"] = 28,
		["70"] = 28,
		["71"] = 28,
		["72"] = 28,
		["73"] = 28,
		["74"] = 28,
		["75"] = 28,
		["76"] = 28,
		["77"] = 28,
		["78"] = 28,
		["79"] = 28,
		["80"] = 28,
		["81"] = 28,
		["82"] = 28,
		["83"] = 28,
		["84"] = 28,
		["86"] = 65,
		["87"] = 65,
		["91"] = 65,
		["93"] = 65,
		["94"] = 65,
		["95"] = 65,
		["97"] = 65,
		["98"] = 66,
		["99"] = 67,
		["101"] = 68,
		["102"] = 68,
		["103"] = 69,
		["104"] = 70,
		["105"] = 71,
		["107"] = 68,
		["112"] = 75,
		["113"] = 75,
		["114"] = 76,
		["115"] = 77,
		["116"] = 78,
		["117"] = 78,
		["118"] = 78,
		["120"] = 78,
		["122"] = 78,
		["123"] = 78,
		["124"] = 78,
		["126"] = 78,
		["128"] = 78,
		["129"] = 79,
		["130"] = 80,
		["131"] = 81,
		["132"] = 82,
		["134"] = 84,
		["135"] = 85,
		["136"] = 86,
		["137"] = 87,
		["141"] = 75,
		["145"] = 93,
		["146"] = 96,
		["147"] = 96,
		["148"] = 96,
		["149"] = 96,
		["150"] = 96,
		["151"] = 96,
		["152"] = 96,
		["153"] = 96,
		["154"] = 96,
		["155"] = 96,
		["156"] = 96,
		["157"] = 96,
		["158"] = 96,
		["159"] = 96,
		["160"] = 96,
		["161"] = 96,
		["162"] = 96,
		["163"] = 96,
		["164"] = 96,
		["165"] = 96,
		["166"] = 96,
		["167"] = 96,
		["168"] = 96,
		["169"] = 96,
		["170"] = 121,
		["171"] = 121,
		["172"] = 121,
		["173"] = 121,
		["174"] = 121,
		["175"] = 121,
		["176"] = 121,
		["177"] = 121,
		["178"] = 121,
		["179"] = 121,
		["180"] = 121,
		["181"] = 121,
		["182"] = 121,
		["183"] = 121,
		["184"] = 121,
		["185"] = 121,
		["186"] = 121,
		["187"] = 121,
		["188"] = 121,
		["189"] = 140,
		["190"] = 142,
		["191"] = 144,
		["193"] = 2,
	}
)
function Spawn(self, e)
	local f = Client:GetPlayerPortraitData(7)
	if not f then
		return
	end
	local g = f.unit_name
	local h = f.playerID
	local i = KeyValues.UnitsKv[g]
	if i == nil then
		i = KeyValues.CosmeticsKV[g]
	end
	local j = i
	if j == nil then
		return
	end
	local k = j.Model
	if k == nil then
		k = j.resource
	end
	local l = k
	local m = l
	local n = Wearable:getUnitPortraitReplaceModel(m, h)
	if n then
		m = n
	end
	local o = KeyValues.Portrait[m]
	if o == nil then
		o = {}
	end
	local p = c(o, KeyValues.PortraitCustom[m])
	if p == nil then
		return
	end
	local q = p.cameras.default or p.cameras.Default
	local r = Wearable:getUnitPortraitReplaceSkin(m, h)
	local s = tostring
	local t = j.Skin
	if t == nil then
		t = ""
	end
	local u = s(t)
	if r then
		u = tostring(r)
	end
	local v = {}
	local w = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = m,
		skin = u,
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
	local x
	if j ~= nil then
		x = j.Creature
	end
	local y
	if x ~= nil then
		y = x.AttachWearables
	end
	local z = y
	if z == nil then
		z = {}
	end
	local A = z
	local B = Wearable:getUnitWearablesModifier(l, h)
	if B then
		do
			local C = 0
			while C <= 9 do
				local D = B[C + 1]
				if D then
					w["item_def" .. tostring(C)] = D
				end
				C = C + 1
			end
		end
	else
		do
			local C = 0
			while C <= 9 do
				local E = "item_def" .. tostring(C)
				local F = "style_index" .. tostring(C)
				local G = j["wearable" .. tostring(C + 1)]
				if G == nil then
					local H = A[tostring(C + 1)]
					if H ~= nil then
						H = H.ItemDef
					end
					local I = H
					if I == nil then
						I = -1
					end
					G = I
				end
				local D = G
				local J = j[("wearable" .. tostring(C + 1)) .. "style"]
				w[E] = D
				if J ~= nil then
					w[F] = J
				else
					local K = KeyValues.ItemsGame[tostring(D)]
					if K ~= nil then
						if K.visuals and K.visuals.skin then
							w[F] = K.visuals.skin
						end
					end
				end
				C = C + 1
			end
		end
	end
	table.insert(v, w)
	table.insert(
		v,
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
		v,
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
	SpawnEntityListFromTableSynchronous(v)
	if p.PortraitParticle ~= nil then
		local L = ParticleManager:CreateParticle(p.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end