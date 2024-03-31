local DatastoreService = game:GetService("DataStoreService")
local SecondDatabase = DatastoreService:GetDataStore("SecondData")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(plr)
	
	local seconddata

	local success, errormessage = pcall(function()
		seconddata = SecondDatabase:GetAsync(plr.UserId)
	end)

	if seconddata and seconddata[1] and seconddata[2] then
		plr.leaderstats.Gems.Value = seconddata[1]
		plr.BatteryEquipped.Value = seconddata[2]
	else
		plr.leaderstats.Gems.Value = 0
		plr.BatteryEquipped.Value = 0
	end
	
	if plr.BatteryEquipped.Value == nil then
		plr.BatteryEquipped.Value = 0
	end
	
end)

Players.PlayerRemoving:Connect(function(plr)

	local SeconddataToSave = {}

	table.insert(SeconddataToSave,1,plr.leaderstats.Gems.Value)
	table.insert(SeconddataToSave,2,plr.BatteryEquipped.Value)
	
	local success, errormessage = pcall(function()
		SecondDatabase:SetAsync(plr.UserId, SeconddataToSave)
	end)


end)

game:BindToClose(function()

	for _, plr in pairs(Players:GetChildren()) do

		wait()

		local SeconddataToSave = {}

		table.insert(SeconddataToSave,1,plr.leaderstats.Gems.Value)
		table.insert(SeconddataToSave,2,plr.BatteryEquipped.Value)

		local success, errormessage = pcall(function()
			SecondDatabase:SetAsync(plr.UserId, SeconddataToSave)
		end)

	end

end)
