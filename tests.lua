local P1 = require('./src/P1')
local P2 = require('./src/P2')
local P3 = require('./src/P3')


extensions = {'pbm','pgm','ppm'}

image = {}

image[1] = {
   1, 1, 1, 1, 1, 1, 1, 0, 0,
   1, 1, 1, 1, 1, 1, 1, 0, 0,
   1, 0, 0, 1, 1, 0, 0, 1, 1,

   1, 0, 0, 1, 1, 0, 0, 1, 1,
   1, 1, 1, 0, 0, 1, 1, 1, 1,
   1, 1, 1, 0, 0, 1, 1, 1, 1,

   1, 1, 1, 1, 1, 1, 1, 1, 1,
   1, 1, 1, 1, 1, 1, 1, 1, 1,
   1, 1, 1, 1, 1, 1, 1, 1, 1
}

image[2] = {
   0, 1, 2, 3, 4, 5, 6, 7, 8,
   1, 2, 3, 4, 5, 6, 7, 8, 9,
   2, 3, 4, 5, 6, 7, 8, 9, 10,
  
   3, 4, 5, 6, 7, 8, 9, 10, 11,
   4, 5, 6, 7, 8, 9, 10, 11, 12,
   5, 6, 7, 8, 9, 10, 11, 12, 13,
   
   6, 7, 8, 9, 10, 11, 12, 13, 14,
   7, 8, 9, 10, 11, 12, 13, 14, 15,
   8, 9, 10, 11, 12, 13, 14, 15, 16
}

image[3] = {
   255,   0,   0,   0, 255,   0,   0,   0,   255,
   255,   0,   0,   0, 255,   0,   0,   0,   255
}

size = {{ 9, 9, nil}, { 9, 9, 16}, {3, 2, 255}}

Ps = {}


for i = 1, 3 do
   
   if i == 1 then
      Ps[1] = P1:new('imageP'..tostring(i), '# {-_-}', size[i][1], size[i][2])
   elseif i == 2 then
      Ps[2] = P2:new('imageP'..tostring(i), '# {-_-}', size[i][1], size[i][2], size[i][3])
   else
      Ps[3] = P3:new('imageP'..tostring(i), '# {-_-}', size[i][1], size[i][2], size[i][3])
   end
   
   print('\nimageP' .. i .. '.' .. extensions[i] .. ' === === === === === ===\n')
   
   -- images
   images = Ps[i]
   
   
   for j = 0, 2 do
      if i ~= 2 then
         images:draw( j, image[i])
         print(images:mount_image())
	 print('\n')
      elseif j ~= 2 then
         images:draw( j, image[i])
         print(images:mount_image())
         print('\n')
      end
   end

   arquivo_image= io.open(images.name, 'w')
   
   arquivo_image:write(images:mount_image())
   arquivo_image:close()
end

a = P1:new('imageP1-0', '# {-_-}', 9, 9)
a:draw(2, {
   1, 1, 1, 1, 1, 1, 1, 0, 0,
   1, 1, 1, 1, 1, 1, 1, 0, 0, 
   1, 0, 0, 1, 1, 0, 0, 1, 1,

   1, 0, 0, 1, 1, 0, 0, 1, 1,
   1, 1, 1, 0, 0, 1, 1, 1, 1,
   1, 1, 1, 0, 0, 1, 1, 1, 1,

   1, 1, 1, 1, 1, 1, 1, 1, 1,
   1, 1, 1, 1, 1, 1, 1, 1, 1,
   1, 1, 1, 1, 1, 1, 1, 1, 1,
})
arquivo_image= io.open(a.name, 'w')
arquivo_image:write(a:mount_image())
arquivo_image:close()
a:drawTerminal("imageP1-0.pbm")


local function ansiRGB(_table)
   local red = (_table[1] or 0) * 255
   local green = (_table[2] or 0) * 255
   local blue = (_table[3] or 0) * 255

   return ("\27[48;2;%d;%d;%dm"):format(red, green, blue)
end

