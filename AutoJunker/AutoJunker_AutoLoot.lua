


-------------------------------------------------------------------------------------------------
--  Get Loot: Called from Looted() (which is called from: EVENT_LOOT_UPDATED) --
-------------------------------------------------------------------------------------------------
function AutoJunker.GetLoot()
	if not AutoJunker.SavedVariables["LOOTMODE"] then return end
	local bShouldLootStolen = AutoJunker.SavedVariables["LOOTSTOLENITEMS"]
	local iNumLootItems = GetNumLootItems()
	LootMoney() 
	
	for iLootIndex = 1, iNumLootItems do
		local iInstancedLootId  = GetLootItemInfo(iLootIndex)
		local lItemLootLink = GetLootItemLink(iInstancedLootId, LINK_STYLE_DEFAULT)
		if (not AutoJunker.IsItemJunk(lItemLootLink)) then
			if not IsItemLinkStolen(lItemLootLink) or bShouldLootStolen then
				LootItemById(iInstancedLootId)
			end
		end
	end
end










