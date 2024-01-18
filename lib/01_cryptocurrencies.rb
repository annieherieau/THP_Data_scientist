# 2.3. Blockchain
require_relative "./arrays.rb"

name = currency_names
rate = currency_rates

# combiner 2 array en 1 hash
currencies = Hash[name.zip(rate)]


# Plus grosse valeur  >> return Array [clé, valeur]
def max_value(hash)
   result = hash.max
   return result
end

# Plus petite valeur >> return Array [clé, valeur]
def min_value(hash)
   result = hash.min
   return result
end


# cours (rate) inférieure à 6000 >> return Hash
def rate_under(hash, border)
   border
result = hash.filter{ |key, value| value.to_i <= border}
return result
end

# plus chère parmi celles dont le cours est inférieur à 6000. >> return Array
def expensive(hash)
   result = max_value(rate_under(hash, 6000))
   return result
end

#_______ EXECUTE _______

puts rate_under(currencies, 6000).length
puts min_value(currencies)
puts expensive(currencies)