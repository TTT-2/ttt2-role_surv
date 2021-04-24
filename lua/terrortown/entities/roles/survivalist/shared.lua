AddCSLuaFile()

if SERVER then
	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_surv.vmt")
end

function ROLE:PreInitialize()
	self.color = Color(80, 140, 90, 255)

	self.abbr = "surv"
	self.score.killsMultiplier = 2
	self.score.teamKillsMultiplier = -8
	self.unknownTeam = true

	self.defaultTeam = TEAM_INNOCENT
	self.defaultEquipment = SPECIAL_EQUIPMENT

	self.conVarData = {
		pct = 0.15,
		maximum = 2,
		minPlayers = 7,
		credits = 1,
		togglable = true,
		shopFallback = SHOP_FALLBACK_DETECTIVE
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_INNOCENT)
end
