
P2 = {}
P2.__index = P2
-- PGM is an acronym of 'Portable Gray Map'


function P2:new(name --[[str]], comments --[[str]], width --[[number]], height --[[number]], maxValue --[[number]])
   if maxValue < 0 or maxValue > 65536 then
      print('The value in the variable "maxValue" is less than 0 or greater than 65536.')
      error('Invalid value in variable "maxValue" of function "P2:draw()".')
   end
   
   self = setmetatable({}, self)
   self.name --[[str]] = (name .. '.pgm')
   self.comments --[[str]] = comments
   self.maxValue --[[number]] = maxValue -- max is 65536
   self.width --[[number]] = width
   self.height --[[number]] = height
   self.img --[[str]]  = ''

   return self
end

function P2:draw( mode --[[number: 0 or 1]], ...)
   local args --[[table]] = ...
   local str --[[str]] = ''
   local width --[[number]] = self.width
   local size --[[number]] = (self.width*self.height)
   local is_correct --[[boolean]] = false

   for i, value in ipairs(args) do
      is_correct = type(value) == 'number' and (value >= 0 and value <= 65536)

      if i <= size then
         if mode == 0 and is_correct then
            if i < size then
               str = (str .. tostring(value) .. ' ')
            else
               str = (str .. tostring(value))
            end
            
         elseif mode == 1 and is_correct then
            if i ~= width then
               str = (str .. tostring(value) .. ' ')
            elseif i == width and i ~= size then
               str = (str .. tostring(value) .. '\n')
               width = width + self.width
            else
               str = (str .. tostring(value))
            end
            
         else
            error('Some invalid value in the "P2:draw()".')
         end
      end
   end

   self.img = str
   return str
end

function P2:mount_image()
   local str --[[str]] = 'P2\n'..self.comments..'\n'..self.width..' '..self.height..'\n'..self.maxValue..'\n'..self.img
   return str
end


return P2
