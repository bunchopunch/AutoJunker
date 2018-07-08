
local LII = LibStub:GetLibrary("LibItemInfo-1.0")

local colorYellow 	= "|cFFFF00" 	-- yellow 
local colorGreen 	= "|c00FF00" 	-- green
local colorRed 		= "|cFF0000" 	-- Red

function AutoJunker.Destroy0ValueJunk()
	if not AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMSKEYBIND"] then return end
	
	local inventory, currentFilter, bagId
	
	if SCENE_MANAGER.currentScene == SCENE_MANAGER.scenes.inventory then
		inventory = PLAYER_INVENTORY.inventories[INVENTORY_BACKPACK]
		currentFilter = inventory.currentFilter
		bagId = BAG_BACKPACK
		
	elseif SCENE_MANAGER.currentScene == SCENE_MANAGER.scenes.bank then
		if INVENTORY_FRAGMENT:IsShowing() then
			inventory = PLAYER_INVENTORY.inventories[INVENTORY_BACKPACK]
			currentFilter = inventory.currentFilter
			bagId = BAG_BACKPACK

		elseif BANK_FRAGMENT:IsShowing() then
			inventory = PLAYER_INVENTORY.inventories[INVENTORY_BANK]
			currentFilter = inventory.currentFilter
			bagId = BAG_BANK
			
		else
			return
		end
	else
		return
	end
	
	if(type(currentFilter) ~= "function" and currentFilter ~= ITEMFILTERTYPE_JUNK) then return end
		
	for k,v in pairs(inventory.slots) do
		if IsItemJunk(bagId, k) then     
			local _, _, sellPrice = GetItemInfo(bagId, k)
			if sellPrice == 0 then
				AutoJunker.DebugWin:AddText(colorRed.."Destroying "..LII:GetFormattedItemLink(bagId, k)..": "..colorYellow.." You clicked or hit the keybind for destroy all junk with 0 Sell Price.")
				DestroyItem(bagId, k)
			end
		end
	end
end
