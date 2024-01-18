# 2.3. Blockchain
require_relative "./arrays.rb"

# Nom des devises
name = currency_names

# Cours des devises
# ATTENTION : transformer String en Foat !
rate = currency_rates.map{ |str| str.to_f}

# combiner 2 array en 1 hash
currencies = Hash[name.zip(rate)]
puts "Bitcoin : #{currencies["Bitcoin"]}"


# 1. Plus grosse valeur  >> return Array [clé, valeur]
def max_value(hash)
   max_val = hash.values.max
   result = {hash.key(max_val) => max_val}
   return result
end

# 2. Plus petite valeur >> return Array [clé, valeur]
def min_value(hash)
   min_val = hash.values.min
   result = {hash.key(min_val) => min_val}
   return result
end


# 3. cours (rate) inférieure à 6000 >> return Hash
def rate_under(hash, border)
   border
result = hash.filter{ |key, value| value < border}
return result
end

# 4. plus chère parmi celles dont le cours est inférieur à 6000. >> return Array
def expensive(hash, border)
   result = max_value(rate_under(hash, border))
   return result
end

#_______ EXECUTE _______

puts "Plus grosse valeur: #{max_value(currencies)}"
puts "Plus petite valeur: #{min_value(currencies)}"
puts "Nombre de devises dont le cours inférieur à 6000: #{rate_under(currencies, 6000).length}"
puts "Devise la plus chère parmi celles dont le cours est inférieur à 6000: #{expensive(currencies, 6000)}"