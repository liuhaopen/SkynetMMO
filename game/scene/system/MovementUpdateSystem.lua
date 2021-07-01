local ecs = require "ecs.ecs"

local mt = ecs.class("movement_system", ecs.system)
-- ECS.TypeManager.RegisterScriptMgr("UMO.mt", mt)
-- function mt:OnCreate(  )
-- 	ECS.ComponentSystem.OnCreate(self)
-- 	self.group = self:GetComponentGroup({"UMO.Position", "UMO.TargetPos", "UMO.MoveSpeed", "UMO.AOIHandle"})
-- end

function mt:OnUpdate(  )
	local dt = Time.deltaTime
	self.filter = self.filter or ecs.all("UMO.Position", "UMO.TargetPos", "UMO.MoveSpeed", "UMO.AOIHandle")
	self:foreach(self.filter, function(ed)
		local startPos = ed["UMO.Position"]
		startPos = Vector3(startPos.x, startPos.y, startPos.z)
		local targetPos = ed["UMO.TargetPos"]
		targetPos = Vector3(targetPos.x, targetPos.y, targetPos.z)
        local speed = ed["UMO.MoveSpeed"].curSpeed
        if speed > 0 then
	        local moveDir = Vector3.Sub(targetPos, startPos)
	        local groundDir = moveDir
	        groundDir.y = 0
	        local moveDistance = Vector3.Magnitude(groundDir)
	        groundDir = Vector3.Normalize(groundDir)
	        local isMoveWanted = moveDistance>0.01
	        local newPos
	        -- print('Cat:mt.lua[33] moveDistance, dt', moveDistance, dt)
            if (moveDistance < speed*dt) then
                --目标已经离得很近了
                newPos = targetPos
            else
                newPos = startPos+groundDir*speed*dt
            end
            ed["UMO.Position"] = {x=newPos.x, y=newPos.y, z=newPos.z}
            self.sceneMgr.aoi:set_pos(ed["UMO.AOIHandle"].value, newPos.x, newPos.y, newPos.z)
	    end
	end)

	-- local positions = self.group:ToComponentDataArray("UMO.Position")
	-- local targetPositions = self.group:ToComponentDataArray("UMO.TargetPos")
	-- local speeds = self.group:ToComponentDataArray("UMO.MoveSpeed")
	-- local aoi_handles = self.group:ToComponentDataArray("UMO.AOIHandle")
	-- local dt = Time.deltaTime
	-- for i=1,positions.Length do
	-- 	local startPos = positions[i]
	-- 	startPos = Vector3(startPos.x, startPos.y, startPos.z)
	-- 	local targetPos = targetPositions[i]
	-- 	targetPos = Vector3(targetPos.x, targetPos.y, targetPos.z)
    --     local speed = speeds[i].curSpeed
    --     if speed > 0 then
	--         local moveDir = Vector3.Sub(targetPos, startPos)
	--         local groundDir = moveDir
	--         groundDir.y = 0
	--         local moveDistance = Vector3.Magnitude(groundDir)
	--         groundDir = Vector3.Normalize(groundDir)
	--         local isMoveWanted = moveDistance>0.01
	--         local newPos
	--         -- print('Cat:mt.lua[33] moveDistance, dt', moveDistance, dt)
    --         if (moveDistance < speed*dt) then
    --             --目标已经离得很近了
    --             newPos = targetPos
    --         else
    --             newPos = startPos+groundDir*speed*dt
    --         end
    --         positions[i] = {x=newPos.x, y=newPos.y, z=newPos.z}
    --         self.sceneMgr.aoi:set_pos(aoi_handles[i].value, newPos.x, newPos.y, newPos.z)
	--     end
	-- end
end

return mt