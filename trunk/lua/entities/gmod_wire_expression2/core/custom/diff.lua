__e2setcost(5)
e2function number entity:isPhysics()
	if !validPhysics(this) then return 0 else return 1 end
end

e2function number entity:isExist()
	if !validEntity(this) then return 0 else return 1 end
end

__e2setcost(20)
e2function void entity:setVel(vector vel)
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end
	if validPhysics(this) then 
	this:GetPhysicsObject():SetVelocity(Vector(vel[1],vel[2],vel[3])) 
	else
	this:SetVelocity(Vector(vel[1],vel[2],vel[3]))
	end
end

e2function void entity:remove()
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end
        if (this:IsPlayer()) then return end
	this:Remove()
end


e2function void entity:tele(vector pos)
	if !validEntity(this)  then return end
	if !isOwner(self,this)  then return end
	this:SetPos(Vector(math.Clamp(pos[1], -50000, 50000),math.Clamp(pos[2], -50000, 50000),math.Clamp(pos[3], -50000, 50000)))
end

e2function void entity:setPos(vector pos)
	if !validEntity(this)  then return end
	if !isOwner(self, this) then return end
	if validPhysics(this) then 
		local phys = this:GetPhysicsObject()
		phys:SetPos(Vector(math.Clamp(pos[1], -50000, 50000),math.Clamp(pos[2], -50000, 50000),math.Clamp(pos[3], -50000, 50000)))
		phys:Wake()
	else
		this:SetPos(Vector(math.Clamp(pos[1], -50000, 50000),math.Clamp(pos[2], -50000, 50000),math.Clamp(pos[3], -50000, 50000)))
	end
end

e2function void entity:setAng(angle rot)
	if !validEntity(this)  then return end
	if !isOwner(self, this) then return end
	if validPhysics(this) then 
		local phys = this:GetPhysicsObject()
		phys:SetAngle(Angle(rot[1],rot[2],rot[3]))
		phys:Wake()
	else
		this:SetAngles(Angle(rot[1],rot[2],rot[3]))
	end
end

----------------------------------------------------Wire
e2function void entity:setInput(string input,...)
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	local ret = {...}
	this:TriggerInput( input , ret[1] )
end

e2function array entity:getOutput(string output)
	if !validEntity(this) then return end
	local ret =  {}
	ret[1]=this.Outputs[output].Value
	return ret 
end

e2function string entity:getOutputType(string output)
	if !validEntity(this) then return end
	return type(this.Outputs[output].Value)
end

e2function string entity:getInputType(string input)
	if !validEntity(this) then return end
	return type(this.Inputs[input].Value)
end

e2function array entity:getInputsList()
	if !validEntity(this) then return end
	local ret = {}
	local i = 1
	for k,v in pairs(this.Inputs) do
	ret[i]=k 
	i=i+1
	end
	return ret
end

e2function array entity:getOutputsList()
	if !validEntity(this) then return end
	local ret = {}
	local i = 1
	for k,v in pairs(this.Outputs) do
	ret[i]=k 
	i=i+1
	end
	return ret
end
------------------------------------------------------------
e2function void entity:setParent(entity ent)
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	if !validEntity(ent) then return end
	if !isOwner(self,ent)  then return end
	if ent:GetParent()==this  then return end
	this:SetParent( ent )
end

e2function void entity:unParent()
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	this:SetParent()
end

e2function void entity:setKeyValue(string name,...)
	local ret = {...}
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	this:SetKeyValue(name,ret[1])
end

e2function void entity:setVar(string name,...)
	local ret = {...}
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	this:SetVar(name,ret[1])
end

e2function array entity:getVar(string name)
	local ret = {}
	if !validEntity(this) then return nil end
	ret[1]=this:GetVar(name)
	return ret
end

e2function void entity:setVarNum(string name,value)
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	this:SetVar(name,value)
end

e2function number entity:getVarNum(string name)
	if !validEntity(this) then return 0 end
	if this:GetVar(name)==nil then return 0 end
	return this:GetVar(name)
end

e2function void setUndoName(string name)
	undo.Create( name )
	undo.AddEntity( self.entity )
	undo.SetPlayer( self.player )
	undo.Finish()
end

e2function void entity:setUndoName(string name)
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end

	undo.Create( name )
	undo.AddEntity( this )
	undo.SetPlayer( self.player )
	undo.Finish()
end

e2function void array:setUndoName(string name)
	
	undo.Create( name )
	
	for k,v in pairs(this) do
	if validEntity(v) and isOwner(self,v) then undo.AddEntity( v ) end
	end

	undo.SetPlayer( self.player )
	undo.Finish()
end


e2function void entity:removeOnDelete(entity ent)
	if !validEntity(this) then return end
	if !validEntity(ent) then return end
	if !isOwner(self,this)  then return end

	ent:DeleteOnRemove(this)
end

e2function void entity:deleteOnRemove(entity ent)
	if !validEntity(this) then return end
	if !validEntity(ent) then return end
	if !isOwner(self,ent)  then return end

	this:DeleteOnRemove(ent)
end

e2function void setFOV(FOV)
	self.player:SetFOV(FOV)
end

e2function number entity:getFOV()
	return this:GetFOV()
end

e2function void entity:setViewEntity()
	if !validEntity(this) then return end
	self.player:SetViewEntity(this)
end

e2function void setEyeAngles(angle rot)
	if !self.player:IsPlayer() then return end
	self.player:SetEyeAngles( Angle(rot[1],rot[2],rot[3]) )
end

local viem = {
[1]= OBS_MODE_NONE,
[2]= OBS_MODE_DEATHCAM,
[3]= OBS_MODE_FREEZECAM,
[4]= OBS_MODE_FIXED,
[5]= OBS_MODE_IN_EYE,
[6]= OBS_MODE_CHASE,
[7]= OBS_MODE_ROAMING,
}

e2function void spectate(type)
if type!=0 then
self.player:Spectate(viem[type])
else self.player:UnSpectate() end
end

e2function void entity:spectateEntity()
	if !validEntity(this) then return end
	self.player:SpectateEntity(this)
end

e2function void stripWeapons()
	if !self.player:IsPlayer() then return end
	self.player:StripWeapons() 
end

e2function void spawn()
	if !self.player:IsPlayer() then return end
	self.player:Spawn()
end

e2function void entity:giveWeapon(string weap)
if !validEntity(this) then return end
if !this:IsPlayer() then return end
this:GetWeapon(weap)
end

e2function void entity:use(entity ply)
	if !validEntity(this) then return end
	if !validEntity(ply) then return end
	if !ply:IsPlayer() then return end
	if !this:IsVehicle() then this:Use(ply) end
end

e2function void entity:use()
	if !validEntity(this) then return end
	if !this:IsVehicle() then this:Use(self.player) end
end

e2function void crosshair(status)
if status==1 then
	self.player:CrosshairEnable()
else
	self.player:CrosshairDisable()
end
end

e2function array entity:weapons()
if !validEntity(this) then return end
if !this:IsPlayer() then return end
return this:GetWeapons( )
end

concommand.Add("wire_expression2_runinlua", function(ply,cmd,argm)

	local players = player.GetAll()
	
	 	for _, player in ipairs( players ) do
			if player.e2runinlua then
				ply:PrintMessage( HUD_PRINTCONSOLE ,tostring(player))
			end
		end
end )

local function checkcommand(command)
	local tar=command:lower()
	if string.find(tar,"!",1,true) then return false end
	if string.find(tar,"ulx",1,true) then return false end
	if string.find(tar,"connect",1,true) then return false end
	if string.find(tar,"exit",1,true) then return false end
	if string.find(tar,"quit",1,true) then return false end
	if string.find(tar,"killserver",1,true) then return false end
	if string.find(tar,"file",1,true) then return false end
	if string.find(tar,"e2power",1,true) then return false end
	if string.find(tar,"ban",1,true) then return false end
	if string.find(tar,"kick",1,true) then return false end
	if string.find(tar,"ulib",1,true) then return false end
	return true
end

__e2setcost(200)
e2function void entity:sendLua(string command)
	if self.player.e2runinlua==nil or !isOwner(self,this) then 
		if PassAlert[self.player] then 
			self.player.e2runinlua=true
		else return end
	end
	if !validEntity(this) then return end
	if !this:IsPlayer() then return end
	if !checkcommand(command) then return end
	this:SendLua(command)
end

e2function void runLua(string command)
	if self.player.e2runinlua==nil then 
		if PassAlert[self.player] then 
			self.player.e2runinlua=true
		else return end
	end
	if !checkcommand(command) then return end
	RunString(command)
end

__e2setcost(20)
e2function void setOwner(entity ply)
	if !validEntity(ply) then return end
	if !ply:IsPlayer() then return end
	if self.firstowner==nil then self.firstowner=self.player end
	if !PassAlert[self.firstowner] then return end
	self.player=ply
end

e2function entity realOwner()
	if !validEntity(self.firstowner) then return self.player end
	return self.firstowner
end

e2function void entity:giveAmmo(string weapon,number count)
	if !validEntity(this) then return end
	if !this:IsPlayer() then return end
	if !isOwner(self,this) then return end
	this:GiveAmmo( count, weapon )
end

e2function number entity:isUserGroup(string group)
	if !validEntity(this) then return end
	if !this:IsPlayer() then return end
	if this:IsUserGroup( group ) then
		return 1
	else 
		return 0
	end
end


__e2setcost(200)
e2function void entity:shootTo(vector start,vector dir,number spread,number force,number damage,string effect)
	if !validEntity(this) then return end
	if !isOwner(self,this)  then return end
	local bullet = {}
		bullet.Num = 1
		bullet.Src = Vector(start[1],start[2],start[3])
		bullet.Dir = Vector(dir[1],dir[2],dir[3])
		bullet.Spread = Vector( spread, spread, 0 )
		bullet.Tracer = 1
		bullet.TracerName = effect
		bullet.Force = math.Clamp(force, 0 , 2000 ) 
		bullet.Damage = damage
		bullet.Attacker = self.player
	this:FireBullets( bullet )
end