
local table = require 'table'

P3 = {}
P3.__index = P3
-- PPM is an acronym of 'Portable Pix Map'

function P3:new(name --[[str]], comments --[[str]], width --[[number]], height --[[number]], maxValue --[[number]])
   
   if maxValue < 0 or maxValue > 255 then
      print('The value in the variable "maxValue" is less than 0 or greater than 255.')
      error('Invalid value in variable "maxValue" of function "P3:draw()".')
   end
   
   self = setmetatable({}, self)
   self.name --[[str]] = (name .. '.ppm')
   self.comments --[[str]] = comments
   self.maxValue --[[number]] = maxValue -- max is 255
   self.width --[[number]] = width
   self.height --[[number]] = height
   self.img --[[str]] = ''

   return self
end

function P3:draw( mode --[[number: 0, 1 or 2]], ...)
   local args --[[table]] = ...
   local str --[[str]] = ''
   local width --[[number]] = (self.width * 3)
   local add_width --[[number]] = width
   local size --[[number]] = (width * self.height)
   local three --[[number]] = 3
   local is_correct --[[boolean]] = false
   
   for i, value in ipairs(args) do
      is_correct = type(value) == 'number' and (value >= 0 and value <= 255)

      if i <= size then
         if mode == 0 and is_correct then
            str = (i ~= size and (str .. tostring(value) .. ' ') or (str .. tostring(value)))
            
         elseif mode == 1 and is_correct then
            
            if i ~= three then
               str = (str .. tostring(value) .. ' ')
            elseif i == three and i ~= size then
               str = (str .. tostring(value) .. '\n')
               three = three + 3
            else
               str = (str .. tostring(value))
            end
            
         elseif mode == 2 and is_correct then
            
            if i ~= width then
               str = (str .. tostring(value) .. ' ')
            elseif i == width and i ~= size then
               str = (str .. tostring(value) .. '\n')
               width = width + add_width
            else
               str = (str .. tostring(value))
            end
            
         else
            print('The "value":', value)
            error('Some invalid value in the "P3:draw()".')
         end
      end
   end
   self.img --[[str]] = str
   return str
end

function P3:mount_image()
   local str --[[str]] = 'P3\n'..self.comments..'\n'..self.width..' '..self.height..'\n'..self.maxValue..'\n'..self.img
   return str
end

return P3

