local mod = RegisterMod("The Stars Align", 1)
local game = Game()

-- Funzione per controllare se c'è un Planetarium nel livello corrente
local function hasPlanetarium()
    local level = game:GetLevel()
    local rooms = level:GetRooms()
    
    for i = 0, rooms.Size - 1 do
        local roomDesc = rooms:Get(i)
        if roomDesc.Data.Type == RoomType.ROOM_PLANETARIUM then
            return true
        end
    end
    
    return false
end

-- Funzione chiamata quando entri in un nuovo livello
function mod:onNewLevel()
    if not game:IsGreedMode() and hasPlanetarium() then
        self.show = true
    end
end

-- Funzione di aggiornamento per mostrare il messaggio
function mod:onUpdate()
    if game:IsGreedMode() then return end
    if self.show then
        game:GetHUD():ShowItemText("The stars align...")
        SFXManager():Play(SoundEffect.SOUND_SUPERHOLY, 2)
        self.show = false
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.onNewLevel)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onUpdate)
