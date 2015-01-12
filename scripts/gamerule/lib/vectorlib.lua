--gets modulus of XYZ format vector
--returns integer
function vector_GetLength(a)
	return sqrt(a[1]^2 + a[2]^2 + a[3]^2)
end

--gets yaw of XYZ format vector
--returns integer
function vector_GetYaw(a)
	local yaw = atan(a[1] / a[3])
	if a[3] < 0 then
		yaw = 180 + yaw 
	end
	return yaw
end

--gets pitch of XYZ format vector
--returns integer
function vector_GetPitch(a)
	return atan((b[2]*ymod) / sqrt(b[1]^2 + b[3]^2))
end 

--modifies a vector with independant x,y,z multipliers
--returns vector with a minimum length of lockmin
function vector_mod(a, xmod, ymod, zmod, lockmin)
	a = {a[1]*xmod, a[2]*ymod, a[3]*zmod}
	if vector_GetLength(a) < lockmin then
		a = Length_Direction_3D(lockmin, vector_GetPitch(a), vector_GetYaw(a))
	end
	return a
end

--turns 2D vector angle (with abitray Y component) into 3D coordinate vector
--returns Array of {x,y,z}
function Length_Direction_2D(L, yaw, Y)
	return {sin(yaw)*L, Y, cos(yaw)*L}
end

--turns 3D angle vector into 3D coordinate vector
--returns Array of {x,y,z}
function Length_Direction_3D(L, pitch, yaw)
	return {L*cos(pitch)*sin(yaw), L*sin(pitch), L*cos(pitch)*cos(yaw)}
end

--adds 2 vectors
--returns Array of {x,y,z}
function vector_add(a, b)
	return{a[1]+b[1], a[2]+b[2], a[3]+b[3]}
end

--gets the seperation between two XYZ format vectors
--returns integer
function get_seperation(a, b)
	return sqrt((a[1]-b[1])^2 + (a[2]-b[2])^2 + (a[3]-b[3])^2);
end