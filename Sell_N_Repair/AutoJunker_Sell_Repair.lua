         
local colorYellow 		= "|cFFFF00" 	-- yellow 
local colorRed 			= "|cFF0000" 	-- Red
-------------------------------------------------------------------------------------------------
--  Repair All Items (called from: EVENT_OPEN_STORE) --
-------------------------------------------------------------------------------------------------

local function RepairAllItems()
	if AutoJunker.SavedVariables["AUTOREPAIRITEMS"] == "All" then
		local iRepairCost = GetRepairAllCost() 
		RepairAll()
		-- true/false tells us if were repairing ALL items --
		AutoJunker.PrintRepairMessage(true, iRepairCost)
	end
end

local function RepairEquippedItems()
	if AutoJunker.SavedVariables["AUTOREPAIRITEMS"] == "Equipped" then
		local tEquipSlots =
		{
			[1]		= EQUIP_SLOT_HEAD,
			[2]		= EQUIP_SLOT_NECK,
			[3]		= EQUIP_SLOT_CHEST,
			[4]		= EQUIP_SLOT_SHOULDERS,
			[5]		= EQUIP_SLOT_MAIN_HAND,
			[6]		= EQUIP_SLOT_OFF_HAND,
			[7]		= EQUIP_SLOT_WAIST,
			[8]		= EQUIP_SLOT_LEGS,
			[9]		= EQUIP_SLOT_FEET,
			[10]	= EQUIP_SLOT_COSTUME,
			[11]	= EQUIP_SLOT_RING1,
			[12]	= EQUIP_SLOT_RING2,
			[13]	= EQUIP_SLOT_HAND,
			[14]	= EQUIP_SLOT_BACKUP_MAIN,
			[15] 	= EQUIP_SLOT_BACKUP_OFF,
		}
		local iRepairCost = 0
	
		for k,v in pairs(tEquipSlots) do
			iRepairCost = iRepairCost + GetItemRepairCost(BAG_WORN, v)
			RepairItem(BAG_WORN, v) 
		end
		-- true/false tells us if were repairing ALL items --
		AutoJunker.PrintRepairMessage(false, iRepairCost)
	end
end

local function RepairItemsCheck()
	if AutoJunker.SavedVariables["AUTOREPAIRITEMS"] == "All" then
		RepairAllItems()
	elseif AutoJunker.SavedVariables["AUTOREPAIRITEMS"] == "Equipped" then
		RepairEquippedItems()
	end
end


function AutoJunker.SellJunk()
	local iBagId = BAG_BACKPACK 
	local iInventory = INVENTORY_BACKPACK
	
	local tItemSellTable = {}
	
	local tSlots = PLAYER_INVENTORY.inventories[INVENTORY_BACKPACK].slots
    local iBagSize = GetBagSize(BAG_BACKPACK)
	
	for iSlotId = 0, iBagSize-1 do
		if tSlots[iSlotId] and IsItemJunk(iBagId, iSlotId) then     
			local _, iStack  = GetItemInfo(iBagId, iSlotId)
			table.insert(tItemSellTable, {bagId = iBagId, slotId = iSlotId, quantity = iStack})
		end
	end
	if tItemSellTable then
		-- sellDelay in milliseconds
		local sellDelay = AutoJunker.AccountSavedVariables["AUTOSELLDELAY"]
		local next = next
		
		EVENT_MANAGER:RegisterForUpdate("AutoSellJunk", sellDelay, function() 
			local item = tItemSellTable[1]
			SellInventoryItem(item.bagId, item.slotId, item.quantity)
			table.remove(tItemSellTable, 1)
			
			if next(tItemSellTable) == nil then
				EVENT_MANAGER:UnregisterForUpdate("AutoSellJunk")
			end
		end)
		
		--[[
		local iCount = 1
		for k,v in pairs(tItemSellTable) do
			zo_callLater(function() SellInventoryItem(v.bagId, v.slotId, v.quantity) end, (iCount*sellDelay))
		end
		--]]
	end
	d(colorRed.."AutoJunker: "..colorYellow.."All junk sold.")
end

local function SellJunkCheck()
	if AutoJunker.SavedVariables["AUTOSELLJUNK"] and HasAnyJunk(BAG_BACKPACK)  then
		if AutoJunker.SavedVariables["AUTOSELLJUNKCONFIRM"] then
			ZO_Dialogs_ShowDialog("AutoJunker_CONFIRM_SELL_JUNK", nil, {titleParams={"Sell All Junk"}, mainTextParams={"Do you wish to sell all junk?"}})
		else
			AutoJunker.SellJunk()
		end
	end
end
function AutoJunker.SellFenceItems()
	local iBagId = BAG_BACKPACK 
	local iInventory = INVENTORY_BACKPACK
	
	local tItemSellTable = {}
	
	local tSlots = PLAYER_INVENTORY.inventories[INVENTORY_BACKPACK].slots
    local iBagSize = GetBagSize(BAG_BACKPACK)
	
	for iSlotId = 0, iBagSize-1 do
		if tSlots[iSlotId] and IsItemStolen(iBagId, iSlotId) then     
			local _, iStack  = GetItemInfo(iBagId, iSlotId)
			table.insert(tItemSellTable, {bagId = iBagId, slotId = iSlotId, quantity = iStack})
		end
	end
	if tItemSellTable then
		local iCount = 1
		for k,v in pairs(tItemSellTable) do
			zo_callLater(function() SellInventoryItem(v.bagId, v.slotId, v.quantity) end, (iCount*0.02))
		end
	end
	d(colorRed.."AutoJunker: "..colorYellow.."All stolen items sold.")
end
local function SellFenceItemsCheck()
	if AutoJunker.SavedVariables["AUTOSELLFENCE"] and AreAnyItemsStolen(BAG_BACKPACK)  then
		if AutoJunker.SavedVariables["AUTOSELLFENCECONFIRM"] then
			ZO_Dialogs_ShowDialog("AutoJunker_CONFIRM_SELL_FENCE", nil, {titleParams={"Sell All Stolen Items"}, mainTextParams={"Do you wish to sell all stolen items?"}})
		else
			AutoJunker.SellFenceItems()
		end
	end
end

function AutoJunker.StoreOpened()
	RepairItemsCheck()
	SellJunkCheck()
end

function AutoJunker.OnFenceOpened()
	SellFenceItemsCheck()
end
--[[
    GetEquippedItemInfo(integer equipSlot)
        Returns: string icon, bool slotHasItem, integer sellPrice, bool isHeldSlot, bool isHeldNow, bool locked 

    GetHeldSlots()
        Returns: integer heldMain, integer heldOff, integer lastHeldMain, integer lastHeldOff 

    GetItemRepairCost(integer bagId, integer slotIndex)
        Returns: integer repairCost 

    RepairItem(Bag bagId, integer slotIndex) 
	
    slots =
    {
        [EQUIP_SLOT_HEAD]       = ZO_CharacterEquipmentSlotsHead,
        [EQUIP_SLOT_NECK]       = ZO_CharacterEquipmentSlotsNeck,
        [EQUIP_SLOT_CHEST]      = ZO_CharacterEquipmentSlotsChest,
        [EQUIP_SLOT_SHOULDERS]  = ZO_CharacterEquipmentSlotsShoulder,
        [EQUIP_SLOT_MAIN_HAND]  = ZO_CharacterEquipmentSlotsMainHand,
        [EQUIP_SLOT_OFF_HAND]   = ZO_CharacterEquipmentSlotsOffHand,
        [EQUIP_SLOT_WAIST]      = ZO_CharacterEquipmentSlotsBelt,
        [EQUIP_SLOT_LEGS]       = ZO_CharacterEquipmentSlotsLeg,
        [EQUIP_SLOT_FEET]       = ZO_CharacterEquipmentSlotsFoot,
        [EQUIP_SLOT_COSTUME]    = ZO_CharacterEquipmentSlotsCostume,
        [EQUIP_SLOT_RING1]      = ZO_CharacterEquipmentSlotsRing1,
        [EQUIP_SLOT_RING2]      = ZO_CharacterEquipmentSlotsRing2,
        [EQUIP_SLOT_HAND]       = ZO_CharacterEquipmentSlotsGlove,
        [EQUIP_SLOT_BACKUP_MAIN]= ZO_CharacterEquipmentSlotsBackupMain,
        [EQUIP_SLOT_BACKUP_OFF] = ZO_CharacterEquipmentSlotsBackupOff,
    }
--]]