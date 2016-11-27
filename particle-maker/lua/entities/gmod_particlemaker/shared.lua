--[[
Copyright 2016 Roelof Roos (SirQuack)
Part of Particle Maker Garry's Mod Tool

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

ENT.Type 		= "anim"
ENT.Base 		= "base_gmodentity"

ENT.PrintName	= "Particle Maker"
ENT.Author		= "SirQuack"
ENT.Contact		= "https://github.com/roelofr/GMod-ParticleMaker"

function ENT:SetData(Data)
	for _,v in pairs(Data) do
		if (v.Type == "Int") then
			self.Entity:SetNetworkedInt(v.Name, v.Value)
		elseif (v.Type == "Float") then
			self.Entity:SetNetworkedFloat(v.Name, v.Value)
		elseif (v.Type == "Bool") then
			self.Entity:SetNetworkedBool(v.Name, v.Value)
		elseif (v.Type == "String") then
			self.Entity:SetNetworkedString(v.Name, v.Value)
		end
	end
end

function ENT:GetData(Options)
	local Data = {}

	for k,v in pairs(Options) do
		Data[k] = {}
		local Value

		if (v.Type == "Int") then
			Value = self.Entity:GetNetworkedInt(v.Name, v.Value)
		elseif (v.Type == "Float") then
			Value = self.Entity:GetNetworkedFloat(v.Name, v.Value)
		elseif (v.Type == "Bool") then
			Value = self.Entity:GetNetworkedBool(v.Name, v.Value)
		elseif (v.Type == "String") then
			Value = self.Entity:GetNetworkedString(v.Name, v.Value)
		end

		Data[k].Value = Value
		Data[k].Name = v.Name
		Data[k].Type = v.Type
	end

	self.Ready = true

	return Data
end

function ENT:BoolToNum(Data)
	for k,v in pairs(Data) do
		if (v.Type == "Bool") then
			if (v.Value) then
				Data[k].Value = 1
			else
				Data[k].Value = 0
			end
		end
	end

	return Data
end

function ENT:KeyToNameValue(Data)
	local NewData = {}

	for k,v in pairs(Data) do
		if (type(k) == "number") then
			NewData[v.Name] = v.Value
		end
	end

	return NewData
end
