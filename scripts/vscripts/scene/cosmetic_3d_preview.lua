--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "scene/cosmetic_3d_preview"
entityName = "cosmetic_3d_preview"
data = Client:GetSceneEntityData(entityName)
local b = tostring
local c = data and data.cosmetic_id
if c == nil then
	c = ""
end
cosmeticID = b(c)
cosmeticData = KeyValues.info_item_cosmetic[cosmeticID]
camera = "camera_1"
defaultCameraConfig = { distance = 800, height = 90, fov = 20 }
cameraConfigByType = {
	[COSMETIC_TYPE.HEAD] = { distance = 650, height = 175, fov = 18 },
	[COSMETIC_TYPE.SHOULDER] = { distance = 750, height = 125, fov = 20 },
	[COSMETIC_TYPE.BACK] = { distance = 900, height = 105, fov = 24 },
	[COSMETIC_TYPE.TAIL] = { distance = 800, height = 65, fov = 22 },
	[COSMETIC_TYPE.WING] = { distance = 1000, height = 115, fov = 26 },
	[COSMETIC_TYPE.MISC] = defaultCameraConfig,
}
function Spawn(self, d)
	local e
	if cosmeticData ~= nil then
		e = cosmeticData.model
	end
	if e == nil then
		return
	end
	SpawnEntityFromTableSynchronous(
		"prop_dynamic_clientside",
		{
			parentname = "root",
			targetname = cosmeticID,
			origin = "0 0 0",
			angles = "0 0 0",
			scales = "1 1 1",
			model = cosmeticData.model,
			StartingAnim = "ACT_DOTA_IDLE",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		}
	)
	local f = cameraConfigByType[tostring(cosmeticData.type)] or defaultCameraConfig
	local g = KeyValues.portraits_weapon.default
	local h = {}
	table.insert(
		h,
		{
			classname = "point_camera",
			targetname = camera,
			origin = (tostring(f.distance) .. " 0 ") .. tostring(f.height),
			angles = "0 180 0",
			fov = f.fov,
			ZFar = math.max(1600, f.distance + 800),
			ZNear = 4,
			UseScreenAspectRatio = 0,
			aspectRatio = 0,
			fogEnable = 0,
			dof_enabled = 0,
		}
	)
	local i = StringToVector(g.PortraitSpecularDirection) or vec3_zero
	local j = StringToVector(g.PortraitAmbientDirection) or vec3_zero
	table.insert(
		h,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = g.PortraitLightPosition,
			angles = g.PortraitLightAngles,
			fov = g.PortraitLightFOV,
			nearz = g.PortraitLightDistance,
			Color = g.PortraitLightColor,
			ambientcolor2 = g.PortraitShadowColor,
			ambientscale2 = g.PortraitShadowScale,
			ambientcolor1 = g.PortraitAmbientColor,
			ambientscale1 = g.PortraitAmbientScale,
			specularcolor = g.PortraitSpecularColor,
			specularpower = g.PortraitSpecularPower,
			specularangles = VectorToAngles(i),
			lightscale = g.PortraitLightScale,
			groundscale = g.PortraitGroundShadowScale,
			ambientangles = VectorToAngles(j),
		}
	)
	SpawnEntityListFromTableSynchronous(h)
end