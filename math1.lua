-- math1.lua, an extension of the math library

-- degrees to radians
function degree_to_radian(deg)
    local RADIAN = (math.pi/180)
    radian = (deg * RADIAN); 
    return radian;
end
----------------
-- chance by percentage
-- ?% chance to be true 
function chance1(percent) 
    if percent >= math.random(1, 100) then 
	    return true 
	end 
	return false 
end
----------------
-- 50% chance to be true
function chance50() 
    local percent = math.random(0, 1) 
	if percent == 1 then 
	    return true 
	end 
	return false 
end
----------------
-- returns your current exp in percentage
function get_exp_percentage(current_exp, exp_to_next_level) 
    local n = current_exp * 100
    local d = exp_to_next_level
 
    local percent = n/d
    return tonumber(string.format("%.2f", percent))
end -- print(get_exp_percentage(6, 14).."%") -- 6 out of 14 EXP.  You need 14 EXP to reach level 2
----------------
function percent_of(percent, number) -- not quite right
    return tonumber("0."..percent) * number
end -- ten_percent_of_100 = percent_of(10, 100)           print(ten_percent_of_100)
----------------
 -- 2 rows, 3 columns
matrix_1 = {
 {1, 2, 3}, -- matrix_1[1]
 {4, 5, 6}, -- matrix_2[2]
}
----------------
-- verified!
function makematrix(row, column)
 local mt = {}
 for i=1, row do
  mt[i] = {} -- each row is a table; column is number per table
  for n=1, column do
   mt[i][n] = 0 -- fill each row with 0's(to set the size of each row)
  end
 end
 
 mt.row = #mt
 mt.column = #mt[1] -- column = size of one row
 return mt
end
----------------
function drawmatrix(mt)
 for i= 1, #mt do 
  io.write("row"..i..": ") -- row index(which row?)
  for n=1, #mt[1] do
   io.write(mt[i][n].." ") -- get the numbers in each row
  
  if n==#mt[1] then -- separate the rows
   print("\n") end
  end
 end
end
----------------
function insertmatrix(num, row, column, mt)
    mt[row][column] = num
end
----------------
-- good!
function getrows(mt) -- get number of rows in a matrix
  return #mt 
end
----------------
-- good!
function getcolumns(mt, row_num)
 if not row_num then
  row_num = 1
 end
 return #mt[row_num] -- size of one row
end
----------------
function add(a, b) return a + b end
function subtract(a, b) return a - b end
function multiple(a, b)return a * b end
function divide(a, b) return a / b end
----------------

function actual_mat_add(mt1, mt2)
 for r = 1, #mt1 do
  for c = 1, mt1.column do
   local matrix = m1[r][c] + m2[r][c]
   print(matrix)
  end
 end
end

----------------
-------------- transformations
function translate(tx, ty, tz) -- or move
 if not tz then tz=0 end
 x = x + tx
 y = y + ty
 z = z + tz
end
----------------
function rotate(angle, rx, ry, rz)
 angle = angle*(math.pi/180) -- angles are measured in radians
 if _2d then
  x = x*(math.cos(angle)) - y*(math.sin(angle))
  y = x*(math.sin(angle)) + y*(math.cos(angle))
 end
 
 if _3d then
  if rx == 1 then
   x=x
   y = y*(math.cos(angle)) - z*(math.sin(angle))
   z = y*(math.sin(angle)) + z*(math.cos(angle))
  end
  
  if ry == 1 then
   x=x*(math.cos(angle)) + z*(math.sin(angle))
   y =y
   z= x*(math.sin(angle)) - z*(math.cos(angle))
  end
  
  if rz == 1 then
   x=x*(math.cos(angle)) - y*(math.sin(angle))
   y= x*(math.sin(angle)) + y*(math.cos(angle))
   z=z
  end
 end
end -- eof
----------------
function scale(sf, sx, sy, sz)
 if _2d then
  sx = sf
  sy = sx  
  x = x*sx 
  y = x*sy
 end
 
 if _3d then
  if sx == 1 then
   x=x*sf
  end
  if sy == 1 then
   y=y*sf
  end
  if sz == 1 then
  z=z*sf
  end
 end
end
----------------
function reflect(o) -- or flip
 if _2d then
  if o == "h" then-- horizontal flip requested
   if x == x then -- x is a positive
    x=-x          -- change x to a negative
   end
   if x == -x then -- x is a negative
    x=math.abs(x) -- change x to a positive
   end
  end
  if o == "v" then -- vertical flip requested
   if y==y then -- y is a positive
    y=-y         -- change y to a negative
   end
   if y==-y then -- y is a negative
    y=math.abs(y) -- change y to a positive
   end
  end
 end
 
 if _3d then -- ??
  if o == "h" then
  end
  if o == "v" then
  end
 end
end
----------------
function shear(shx, shy, shz)
 if _2d then
  x = x + (shx*y) -- if shx is 0, no shear on x axis
  y = y + (shy*x) -- if shy is 0, no shear on y axis
 end
 
 if _3d then 
  -- xz direction
  x = x + (shx*y)
  y = y
  z = z + (shz*y)
 
  -- yz direction
  x = x 
  y = y + (shy*x)
  z = z + (shz*x)  
 end
end
----------------
-- fractions

function fraction_add(a, b, c, d) -- n is numerator, d is denomenator
 local n = (a*d) + (b*c) -- numerator
 local d = (b*d)
 print(tostring(n.."/"..d))
end
----------------
function fraction_sub(a, b, c, d)
 local n = (a*d) - (b*c)
 local d = (b*d)
 print(tostring(n.."/"..d))
end
----------------
fraction_mul = function(a, b, c, d) 
 local n = (a*c) -- multiply directly - numerator with numerator and denomenator with denominator
 local d = (b*d)
 print(tostring(n.."/"..d))
end
----------------
fraction_div = function(a, b, c, d) 
 local n = (a*d) -- flip the right-sided fraction then multiply
 local d = (b*c)
 print(tostring(n.."/"..d))
end
----------------
--- inequalities
function is_equal(a, b) 
 if a == b then
  return true
 end
 return false
end
----------------
function is_less_than(a, b) end
----------------
function is_greater_than(a, b) 
 if a > b then
  return true
 end
 return false
end
----------------
function is_less_than_or_equal(a, b) 
 if a >= b then
  return true
 end
 return false
end
----------------
function is_greater_than_or_equal(a, b) 
 if a <= b then
  return true
 end
 return false
end
----------------

-- factors
function get_factors(n) -- 4 = 1 x 4 and 2 x 2 
 for i = 0, 100 do
  for f = 0, 100 do
   if n == i*f then
    print(i..", "..f)
   end
  end
 end
end
----------------
function get_prime_factorization(n) -- 12 = 2 x 2 x 3 
 for i = 0, 100 do
  for f = 0, 100 do
   for p = 0, 100 do
    if i ~= 1 and p ~= 1 and f ~= 1 then  
    if n == i*f*p then
     print(i..", "..f..", "..p)
	 break
    end
	end
   end
  end
 end
end
----------------
-- prime numbers - only factors are 1 and itself
function is_prime_number(n)
 for i = 0, 1000 do
  for p = 0, 1000 do
    --if i == n and p == 1 or
	 if i == 1 and p == i then
	  return true

   end
  end
 end
 return false
end
----------------



-- Mixed number to improper fraction
function mixed_number_to_improper_fraction(x, a, b)
 answer = ((b)*(x)) + a
 --answer = answer / b
 return answer.."/"..b
end
----------------
to_improper = mixed_number_to_improper_fraction
----------------

function is_pythagorean_triple(a, b, c) -- 3, 4, 5
 if (math.pow(a, 2) + math.pow(b, 2)) == math.pow(c, 2) then
  return true
 end 
 return false
end
----------------

-- distance formula
function calculate_distance(x1, y1, x2, y2)
 return math.sqrt((x2 - x1)*(2)  +  (y2 - y1)*(2))
end
----------------

function sides_to_name(side) 
 if side == 3 then
  side = "Triangle"
 end
 
 if side == 4 then   side = "Quad" end
 
 if side == 5 then   side = "Pentagon" end
 
  if side == 6 then   side = "Hexagon" end
 
 if side == 7 then   side = "Heptagon" end
 
  if side == 8 then   side = "Octagon" end
 

 
  if side == 10 then   side = "Decagon" end
 

  if side == 12 then   side = "Dodecagon" end
  
  
  ----
  
   if side == 9 then   side = "Nonagon, Enneagon" end
   if side == 11 then   side = "Undecagon, Hendecagon" end
  
     if side == 13 then   side = "Tridecagon, Triskaidecagon" end
	 
   if side == 14 then   side = Tetradecagon, Tetrakaidecagon end
      if side == 15 then   side = "Pentadecagon, Pentakaidecagon" end
   if side == 16 then   side = Hexadecagon, Hexakaidecagonend end
      if side == 17 then   side = "Heptadecagon, Heptakaidecagon" end
   if side == 18 then   side = Octadecagon, Octakaidecagon end
   
      if side == 19 then   side = "Enneadecagon, Enneakaidecagon" end
   if side == 20 then   side = Icosagon end
   
   
      if side == 30 then   side = "Triacontagon" end
   if side == 40 then   side = Tetracontagon end
   
   
      if side == 50 then   side = Pentacontagon end
   if side == 60 then   side = "Hexacontagon" end
   
  
  
     if side == 70  then   side = Heptacontagon end
   if side == 80 then   side = Octacontagon end
 
 
    if side == 90 then   side = "Enneacontagon" end
   if side == 100 then   side = Hectogon, Hecatontagon end
 
     if side == 1000 then   side = "Chiliagon" end
   if side == 10000 then   side = Myriagon end
 
end


function get_area(shape) 
 if shape.type == "SQUARE" then
  square.area = math.pow(6,6)
 end

end





function power(n, power_)
 math.pow(n, power_)
end



function polygon_type(polygon) 

if equal_sides_and_same_lenght then
 return "Regular"
end 

if equal_angles then
 return "Equiangular"
end

if equal_side_lengths then
 return "Equilateral"
end

end



function decimal_place(n)

if string.len(n) == 1 then
 return "Ones"
end
--[[
1 - ones
2 - tens
3 - hundreds
4 - thousands
5 - ten thousands
6 - hundred thousands
7 - millions
8 - ten millions
9 - hundred millions
10 - billion
11 - ten billion
12 - hundren billion
13 - trillion(1 with 12 zeros)
16 - quadrillion(1 with 15 zeros)
sextillion	1 with 21 zeros
septillion	1 with 24 zeros
octillion	1 with 27 zeros
googol	1 with 100 zeros
googolplex 1 with a googol of zeros

1, 000, 000, 000, 000(one trillion)
]]--
end 


-- CONVERSIONS

function percent_to_decimal(number, percent)
-- convert the percentage to decimals
 decimal = tonumber("0."..percent)
 result = (decimal*number)
 return result
end


function number_to_roman_numerals() end



--------------------------------





function squared(a)
 return a*a
end
function cubed(a)
 return a*a*a
end

--VALID! BUT NEEDS IMPROVEMENTS
function squareroot(a) -- 9
 -- ?? x ?? = a

 -- math.sqrt(a) -- THIS COULD HAVE BEEN EASIER
 
 for n = 0, 99999 do
  if squared(n) == a then
   sq_root = n
  else 
   print(a.." is a surd.") -- meaning it cannot be simplified any further
  end
 end
 return sq_root
end

function pythag(a, b, c)
 a = squared(a)
 b = squared(b)
 
 result = a + b
 if result == squared(c) then
  print("You are right")
  print(a.." + "..b.." = "..result)
 else
  print(a.." + ".. b.." is not equal to "..squared(c))
  print(a.." + "..b.." = "..result)
 end
 
 
 if c == nil then
  c = squared(c)
  print(a.."^2 + "..b.."^2 is "..squared(c))
  --return result
 end
end


--[[
  3 dimension
0 point(0d) - also called a vertex, vector
1 line(1d) - between 2 points
2 square(2d) -- plane
3 cube(3d) --solid

planes are flat 2d surfaces like a square circle triangle, etc



triangle = 3 dots

x-axis = left(-), right(+)=(horizontal)
y-axis = up(+), down(-)=(vertical)
z-axis = foward(-), backwards(+), length(diagonal)

origin = 0, 0, 0
coordinates = {
 x = 0
 y = 0
 z = 0

}
z-axis can push foward or backwards! DEPTH
]]--


-- NO EQUAL SIDES
function scalene(triangle)
 angle_a = triangle.angle_a 
 angle_b = triangle.angle_b 
 angle_c = triangle.angle_c

 if triangle.angle_a ~= angle_b or
  triangle.angle_a ~= angle_c or
  
  triangle.angle_b ~= angle_a or
  triangle.angle_b ~= angle_c or
	
  triangle.angle_c ~= angle_a or
  triangle.angle_c ~= angle_b then
  
  print("The triangle is scalene.")
  return true
 end
end

-- ONLY TWO EQUAL SIDES
function isosceles(triangle)
 -- ANGLE A AND B ARE EQUAL, BUT NOT C
 if triangle.angle_a == triangle.angle_b and triangle.angle_a ~= triangle.angle_c or
 -- ANGLE B AND C ARE EQUAL, BUT NOT A
  triangle.angle_b == triangle.angle_c and triangle.angle_b ~= triangle.angle_a or
  -- ANGLE C AND A ARE EQUAL, BUT NOT B
  triangle.angle_c == triangle.angle_a and triangle.angle_c ~= triangle.angle_b then
  
  print("The triangle is an isoceles.")
  return true
 end
end

-- MUST HAVE THREE EQUAL SIDES
function equailateral(triangle)
 -- A IS B AND B IS C
 if triangle.angle_a == triangle.angle_b and triangle.angle_b == triangle.angle_c then
 
  print("The triangle is equilateral.")
  return true
 end
end

----------------------------------------
--AT LEAST ONE ANGLE MUST BE NINETY DEGREES
function right(triangle)
 ninety_deg = 90
 if triangle.angle_a == ninety_deg or triangle.angle_b == ninety_deg or triangle.angle_c == ninety_deg then
  print("The triangle has a right angle.")
  return true
 end 
end

-- ALL ANGLES MUST BE LESS THAN NINETY DEGREES
function acute(triangle)
 ninety_deg = 90
 if triangle.angle_a < ninety_deg and triangle.angle_b < ninety_deg and triangle.angle_c < ninety_deg then
  print("The triangle has acute angles.")
  return true
 end
end

--AT LEAST ONE ANGLE MUST BE ABOVE NINETY DEGREES
function obtuse(triangle)
 if triangle.angle_a > ninety_deg or triangle.angle_b > ninety_deg or triangle.angle_c > ninety_deg then
  print("The triangle has an obtuse angle.")
  return true
 end
end

--[[
polygons = 2d shapes.

meshs(model) = 3d shapes.

]]--

INFINITY = math.pi

Polygon = {}
function Polygon.new(type_, sides, points, faces, edges)
 local polygon = {}
 
 polygon.type = type_
 
  if polygon.type == CIRCLE then
  polygon.side = INFINITY
 end
 if polygon.type == TRIANGLE then
  polygon.side = 3
 end
 if polygon.type == SQUARE then
  polygon.side = 4
 end
  if polygon.type ==  PENTAGON then
  polygon.side = 5
 end
  if polygon.type == HEXAGON then
  polygon.side = 6
 end
  if polygon.type == HEPTAGON then
  polygon.side = 7
 end
  if polygon.type == OCTAGON then
  polygon.side = 8
 end
  if polygon.type == NONAGON then
  polygon.side = 9
 end
  if polygon.type == DECAGON then
  polygon.side = 10
 end
 
 
 
  if polygon.type == RECTANGLE then
  polygon.side = 4
 end
  if polygon.type == OVAL then
  polygon.side = INFINITY
 end
  if polygon.type == RHOMBUS then
  polygon.side = 4
 end
  if polygon.type == HEART then
  polygon.side = "??"
 end
  if polygon.type == STAR then
  polygon.side = "??"
 end
  if polygon.type == DIAMOND then
  polygon.side = "??"
 end
  if polygon.type == CRESCENT then
  polygon.side = "?"
 end
 
 
 
 setmetatable(polygon, {__index = Polygon})
 return polygon
end







function rotate(object, x, y, z)
end
function rotate2d(degree)
end
function translate(object, x, y, z)
 object.x = object.x + x
 object.y = object.y + y
 object.z = object.z + z
end

function reflect(object, x, y, z) -- flip

end

function scale(degree)
end
-- move 10 units right, 30 units up
--translate(polygon, 10, 30)




function reshapeToSphere(object)
end

function addTexture(object, texture)
end

function trangulate(object)
end
function wireframe(object)
end


function EclipseArea(a, b)
 local area = math.pi *a *b
end



-- ALWAYS EQUAL TO TWO
function eulerFormula(object)
 e = object.face + objet.vertex - object.edge
 return e
end



--[[
CUBE 6F 12E 8V
CYINDER 3F 2E 0V
CONE 2F 1E 1V
SPHERE 1F 0E 0V

PYRAMID
TORUS -- RING
convergent 
]]--

-- math.modf(10.4) removes the fraction 0.4 from the 10 and returns the 10



--[[
VELOCITY = SPEED OF SOMETHING IN A GIVEN DIRECTION
 RATE IN WHICH AN OBJECT CHANGES ITS POSITION, VECTOR QUUANTITY
 
 SPEED = SCALAR QUANTITY, HOW FAST AN OBJECT MOVES





]]--

--[[
object = {}
-- VELOCITY ALWAYS REQUIRE A DIRECTION
function velocity(object, rate, direction)
 v = distance(how much ground has been covered) + direction / rate
end
velocity(object, 50miles, "north"); -- if 0, you are not changing your position, but can still be moving.
function speed(rate)
end
speed(object, 10.0)

-- speed = distance / time -- (HOW LONG IT TAKES YOU TO GET THERE)HOW FAR YOU GO, LOSING(DIVIDED BY) SOME TIME IT TAKES TO GET THERE
-- velocity = displacement / time(HOW FAR YOU MOVE BETWEEN TIMES)
-- OR velocity = displacement + direction / time

-- object that returns to its original location has no velocity

-- 	velocity = distance(50 miles) and direction(west) / change in time(use up 4 hours) ex. it takes 4 hours to go 50 miles to the west
-- velocity = 50 miles / 4 hours = 12.5 miles per every he went(move 12.5 miles each hour)

-- final_velocity = inital_velocity + (acceleration * time)
--5km to get to the north in 1 hour


seconds = 1.0

distance_to_school = 2 miles
velocity = distance_to_school / 30 minutes  -- how long took it took to get to school 
-- it takes me 30 minutes to get to school, and I walked two miles to get 
--there, so that is 0.0666666666666667 miles every minute I walked
]]--













----------------- FORMULAS ---------------------
-- AREA


function get_area(shape)
if shape.type == "SQUARE" then
 area = (side_len*side_len)
end
-- rectangle = ab
--[[
parallelogram = bh

 	
square = a 2 

rectangle = ab 

parallelogram = bh 

trapezoid = h/2 (b1 + b2) 

circle = pi r 2 

ellipse = pi r1 r2 

 
triangle =	1/2(b*h)

  
equilateral triangle =	sqrt(3) / 4(a*a)

]]--
end






-- VOLUME

function get_volume(shape)

--[[

cube = a 3 

rectangular prism = a b c 

irregular prism = b h 

cylinder = b h = pi r 2 h 

pyramid = (1/3) b h 

cone = (1/3) b h = 1/3 pi r 2 h 

sphere = (4/3) pi r 3 

ellipsoid = (4/3) pi r1 r2 r3  




]]--
end




function get_surface_area(shape)
--[[
Surface Area of a Cube = 6 a 2
Surface Area of a Rectangular Prism = 2ab + 2bc + 2ac

]]--
end


if not dokun then
function Vector1(x) return x end
function Vector2(x, y) return x, y end
function Vector3(x, y, z) return x, y, z end
function Vector4(x, y, z, a) return x, y, z, a end
end