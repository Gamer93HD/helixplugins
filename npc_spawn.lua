local PLUGIN = PLUGIN
PLUGIN.name = "NPC Spawns"
PLUGIN.description = "Allows npc to appear at the indicated coordinates"
PLUGIN.author = "Gamer93"


local spawnPositions = {
    {pos = Vector(5229.57, 4160.89, 64.03), ent = "npc_zombie", amount = 1}, -- Change
}

local spawnTime = 240 -- 4 minutes (mobs respawn time in seconds)

if (SERVER) then
    function PLUGIN:Think()
        if CurTime() >= (PLUGIN.nextSpawnTime or 0) then
            PLUGIN.nextSpawnTime = CurTime() + spawnTime

            for _, spawn in ipairs(spawnPositions) do
                local entities = ents.FindInSphere(spawn.pos, 2000) -- Change the radius if you want
                local found = false
                for _, entity in ipairs(entities) do
                    if entity:GetClass() == spawn.ent then
                        found = true
                        break
                    end
                end

                if not found then
                    for i = 1, spawn.amount do
                        local enemy = ents.Create(spawn.ent)
                        enemy:SetPos(spawn.pos)
                        enemy:Spawn()
                    end
                end
            end
        end
    end
 end
