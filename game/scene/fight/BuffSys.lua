--handle buff lifetime
local ecs = require "ecs.ecs"
local skynet = require "skynet"
local mt = ecs.class(ecs.system)
-- ECS.TypeManager.RegisterScriptMgr("UMO.BuffSys", BuffSys)

function BuffSys:OnCreate(  )
	ECS.ComponentSystem.OnCreate(self)
	self.group = self:GetComponentGroup({"UMO.Buff"})
end

function mt:on_update(  )
	local deltaTime = Time.deltaTime
	self:foreach(ecs.all("UMO.Buff"), function(ed)
		local buffList = ed["UMO.Buff"]
		for i,v in ipairs(buffList) do
			v.action:Update(deltaTime)
			local isDone = v.action:IsDone()
			if isDone then
				--Cat_Todo : 加载移除队列
			end
		end
	end)
	-- local buffs = self.group:ToComponentDataArray("UMO.Buff")
	-- local entities = self.group:ToEntityArray()
	-- local deltaTime = Time.deltaTime
	-- for i=1,buffs.Length do
	-- 	local buffList = buffs[i]
	-- 	for i,v in ipairs(buffList) do
	-- 		v.action:Update(deltaTime)
	-- 		local isDone = v.action:IsDone()
	-- 		if isDone then
	-- 			--Cat_Todo : 加载移除队列
	-- 		end
	-- 	end
	-- end
end

return mt
