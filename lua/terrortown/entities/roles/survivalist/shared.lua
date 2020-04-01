AddCSLuaFile()

if SERVER then
	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_surv.vmt")
end

function ROLE:PreInitialize()
	self.color = Color(80, 140, 90, 255)

	self.abbr = "surv" -- abbreviation
	self.radarColor = Color(150, 150, 150) -- color if someone is using the radar
	self.surviveBonus = 0 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 1 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
	self.unknownTeam = true -- player don't know their teammates

	self.defaultTeam = TEAM_INNOCENT -- the team name: roles with same team name are working together
	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment

	self.conVarData = {
		pct = 0.15, -- necessary: percentage of getting this role selected (per player)
		maximum = 2, -- maximum amount of roles in a round
		minPlayers = 7, -- minimum amount of players until this role is able to get selected
		credits = 1, -- the starting credits of a specific role
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		shopFallback = SHOP_FALLBACK_DETECTIVE
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_INNOCENT)

	if CLIENT then
		-- Role specific language elements
		LANG.AddToLanguage("English", self.name, "Survivalist")
		LANG.AddToLanguage("English", "info_popup_" .. self.name,
			[[You are a Survivalist!
				Try to survive and protect your mates if possible!]])
		LANG.AddToLanguage("English", "body_found_" .. self.abbr, "This was a Survivalist...")
		LANG.AddToLanguage("English", "search_role_" .. self.abbr, "This person was a Survivalist!")
		LANG.AddToLanguage("English", "target_" .. self.name, "Survivalist")
		LANG.AddToLanguage("English", "ttt2_desc_" .. self.name, [[The Survivalist is a better innocent, because he is able to access his own ([C]) shop.
Try to protect the innocents!]])

		LANG.AddToLanguage("Italian", self.name, "Survivalist")
		LANG.AddToLanguage("Italian", "info_popup_" .. self.name,
			[[Sei un Survivalist!
				Prova a sopravvivere e proteggere i tuoi compagni se possibile!]])
		LANG.AddToLanguage("Italian", "body_found_" .. self.abbr, "Era un Survivalist...")
		LANG.AddToLanguage("Italian", "search_role_" .. self.abbr, "Questa persona era un Survivalist!")
		LANG.AddToLanguage("Italian", "target_" .. self.name, "Survivalist")
		LANG.AddToLanguage("Italian", "ttt2_desc_" .. self.name, [[Il Survivalist is è un innocente migliore, perché può accedere al suo shop con ([C]).
Prova a proteggere gli innocenti!]])

		LANG.AddToLanguage("Deutsch", self.name, "Überlebender")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. self.name,
			[[Du bist ein Überlebender!
				Versuche zu überleben und beschütze dein Team, wenn es möglich sein sollte!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. self.abbr, "Er war ein Überlebender...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. self.abbr, "Diese Person war ein Überlebender!")
		LANG.AddToLanguage("Deutsch", "target_" .. self.name, "Überlebender")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. self.name, [[Der Überlebender ist ein besserer Unschuldiger (oder sogar ein besserer Detektiv), denn er hat seinen eigenen ([C]) Shop.
Versuche, die Unschuldigen zu beschützen!]])
	end
end