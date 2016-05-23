/**
 * Copyright 2016 Roelof Roos (SirQuack)
 * Part of Particle Maker Garry's Mod Tool
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

local function RemoveCallback(Particle, HitPos, Normal)

	Particle:SetLifeTime(0)
	Particle:SetDieTime(0)

	Particle:SetStartSize(0)
	Particle:SetEndSize(0)

	Particle:SetStartAlpha(0)
	Particle:SetEndAlpha(0)

end

local function SlideCallback(Particle, HitPos, Normal)

	Particle:SetBounce(1)
	local Vel = Particle:GetVelocity()
	Vel.z = 0
	Particle:SetVelocity(Vel)
	Particle:SetPos(HitPos + Normal)

end

local function StickCallback(Particle, HitPos, Normal)

	Particle:SetAngleVelocity(Angle(0, 0, 0))

	if (Particle.Align) then
		local Ang = Normal:Angle()
		Ang:RotateAroundAxis(Normal, Particle:GetAngles().y)
		Particle:SetAngles(Ang)
	end

	if (Particle.Stick) then
		Particle:SetVelocity(Vector(0, 0, 0))
		Particle:SetGravity(Vector(0, 0, 0))
	end

	Particle:SetLifeTime(0)
	Particle:SetDieTime(Particle.StickLifeTime)

	Particle:SetStartSize(Particle.StickStartSize)
	Particle:SetEndSize(Particle.StickEndSize)

	Particle:SetStartAlpha(Particle.StickStartAlpha)
	Particle:SetEndAlpha(Particle.StickEndAlpha)
end

function EFFECT:Init(Data)
	self.ParticleMaker = Data:GetEntity()

	local Ent = self.ParticleMaker
	Ent.Pos = Data:GetOrigin()
	Ent.NextShot = RealTime()
	Ent.Created = RealTime() + 0.1
end

function EFFECT:Think()
	local Ent = self.ParticleMaker

	if not Ent.Success and Ent:IsValid() then
		Ent.Success = true
		Ent["3D"] = Ent:GetNWBool( "3D" )
		Ent.Ready = true

		Ent.Emitter = ParticleEmitter(Ent.Pos, Ent["3D"])
	end

	if Ent.Ready then

		if not Ent or not Ent:IsValid() then
			if Ent.Emitter then
				Ent.Emitter:Finish()
			end
			return false
		end

		if Ent:GetNetworkedBool("Activated") and Ent.Emitter then
			if Ent.NextShot < RealTime() then
				local Pos = Ent:GetPos()
				Pos = Pos + Ent:GetUp() * 4

				local Ang = Ent:GetUp()

				local Data = Ent:GetData(ParticleOptions)
				Data = Ent:KeyToNameValue(Data)

				Data.Spread = Data.Spread / 180
				if (Data.Material == "") then return true end
				if (Data.Velocity == 500.01) then return true end

				local Double = 1
				if (Data.DoubleSided) then
					Double = 2
				end

				for _=1, Data.Number do

					local Vec = Vector() * 0
					if (Data.Spread != 0) then
						Vec = Vector(math.sin(math.Rand(0, 360)) * math.Rand(-Data.Spread, Data.Spread), math.cos(math.Rand(0, 360)) * math.Rand(-Data.Spread, Data.Spread), math.sin(math.random()) * math.Rand(-Data.Spread, Data.Spread))
					end
					local RandColor
					if (Data.ColorRand) then
						RandColor = {math.random(math.min(Data.ColorR1, Data.ColorR2), math.max(Data.ColorR1, Data.ColorR2)), math.random(math.min(Data.ColorG1, Data.ColorG2), math.max(Data.ColorG1, Data.ColorG2)), math.random(math.min(Data.ColorB1, Data.ColorB2), math.max(Data.ColorB1, Data.ColorB2))}
					else
						RandColor = {Data.ColorR1, Data.ColorG1, Data.ColorB1}
					end


					local RandRoll = math.Rand(-Data.RollRand, Data.RollRand)

					for i=1, Double do
						local P = Ent.Emitter:Add(Data.Material, Pos)

						if (Data.DoubleSided) then
							local Angl
							if (i == 1) then
								Angl = (Ang * -1):Angle()
							elseif (i == 2) then
								Angl = Ang:Angle()
							end
							P:SetAngles(Angl)
						else
							P:SetAngles(Ang:Angle())
						end

						P:SetVelocity((Vec + Ang) * Data.Velocity)
						P:SetColor(unpack(RandColor))
						P:SetColor(unpack(RandColor))
						P:SetDieTime(Data.DieTime)
						P:SetStartAlpha(Data.StartAlpha)
						P:SetEndAlpha(Data.EndAlpha)
						P:SetStartSize(Data.StartSize)
						P:SetEndSize(Data.EndSize)
						P:SetStartLength(Data.StartLength)
						P:SetEndLength(Data.EndLength)
						P:SetRoll(Data.RollRand * 36)
						P:SetRollDelta(Data.RollDelta + RandRoll)
						P:SetAirResistance(Data.AirResistance)
						P:SetBounce(Data.Bounce)
						P:SetGravity(Vector(0, 0, Data.Gravity))
						P:SetCollide(Data.Collide)
						P:SetLighting(Data.Lighting)

						if (Data.Sliding) then
							P:SetCollideCallback(SlideCallback)
						end

						if (Data["3D"]) then
							if (not Data.Sliding) then
								if (i == 1) then
									P:SetCollideCallback(RemoveCallback)
								else
									P:SetCollideCallback(StickCallback)
								end
							end

							P:SetAngleVelocity(Angle(Data.AngleVelX, Data.AngleVelY, Data.AngleVelZ))

							P.Align = Data.Align
							P.Stick = Data.Stick
							P.StickLifeTime = Data.StickLifeTime
							P.StickStartSize = Data.StickStartSize
							P.StickEndSize = Data.StickEndSize
							P.StickStartAlpha = Data.StickStartAlpha
							P.StickEndAlpha = Data.StickEndAlpha
						end
					end
				end

				Ent.NextShot = RealTime() + Data.Delay
			end

			return true
		elseif (Ent.Created < RealTime()) then
			if Ent.Emitter and Ent.Emitter.Finish then
				local ok,_ = pcall(Ent.Emitter.Finish)
			end

			return false
		end
	end

	return true
end


function EFFECT:Render()
end



