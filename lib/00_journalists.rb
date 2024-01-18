# 2.2. Big data
require_relative "./arrays.rb"

# ____________METHODS__________

# Nettoyer les data (bulshit) >> return  Array 
def clean_data(array)
  # garder les items commençant par @
  new_array = array.filter{|item| item[0]=="@"}

  # garder les handles uniques
  new_array.uniq!

  return  new_array
end

# 1- Combien de handles? >> return Integer
def find_nb_of_handles(array)

  # compter les entrées commançant par @
  return array.count{|item| item[0]=="@"}
end

# 2- le handle le plus court >> return String
def find_the_shorter(array)
  #trier l'array par taille croissante
  result = sort_by_length(array)
  # renvoyer le 1er item
  return result.first
end

# 3- Nombre de handle contenant 5 caractères (@ exclu) >> return Integer
# TODO vaudrait mieux exclure le @ au lieu de number+1
def find_nb_of_xcaract(array, number)
  return array.count{|item| item.length == number+1} 
end

# 4- Nombre de handles commençant par une majuscule >> return Integer
def find_nb_of_capitalized(array)
  result = array.count{ |item|  /[[:upper:]]/.match(item[1]) }
  return result
end 

# 5. Trie par ordre alphabétique (non sensible à la casse) >> return Array
def sort_by_alpha(array)
return array.sort_by{|item| item.downcase}
end

# 6. Trie la liste de handle par taille des handle croissant
def sort_by_length(array)
  return array.sort_by{|handle| handle.length}
end

# 7. Position (index) de la personne @epenser ? >> return Integer
def find_index(array, search_string)
  return array.index{|item| item == search_string}
end

# 8. Répartition par longueur de caractères >> return Hash
def length_distribution(array)
  # trier par longueur
  sorted_array = sort_by_length(array)
  max_length = sorted_array.last.length - 1 # on exlu le @

  result = {}  # hash {longueur => nombreDeHandle}

  # pour chaque longeur : on compte le nombre de handle
  ( 1..max_length).each do |lg|
    nb = find_nb_of_xcaract(array, lg)
    if nb != 0
      result[lg] = nb
    end
  end

  return result
end

# affichage d'un hash >> return Array
def print_hash(hash)
  array = []
  hash.each{|key, value| array.push("** #{key} **\n #{value}")}
  return array
end

# affichage d'un array sur une ligne >> return String
def print_array(array)
  return array.join(" ,")
end

# créer le hash les stats >> return Hash
def generate_stats_hash(hash, menu, label, result)
  # puts result.class
  hash[menu]= {label => result}
  return hash
end

# Afficher le menu
def menu
menu=new.hash
menu[1]
end

#___________ P E R F O R M ___________
def perform
  # hash pour stocker les résultats
  data_stats={}
  
  # l'utilisatuer rentre un numéro de question
  #TODO faire le menu
  puts "Entre un numéro entre 1 et 8 : "
  user_input = 0
  while !user_input.between?(1,8)
    user_input = gets.chomp.to_i
  end

  # lance 1 méthode en fonction de numéro du menu
  #TODO l'encapsuler dans une methode
    case user_input
    when 1
      generate_stats_hash(data_stats, 1, "Nombre de handles (uniques)", find_nb_of_handles(journalists))
    when 2
      generate_stats_hash(data_stats, 2, "Le handle le plus court",  find_the_shorter(journalists))
    when 3
      generate_stats_hash(data_stats, 3, "Nombre de handle contenant 5 caractères", find_nb_of_xcaract(journalists, 5))
    when 4
      generate_stats_hash(data_stats, 4, "Nombre de handle commançant par une mujuscule" ,  find_nb_of_capitalized(journalists))
    when 5
      generate_stats_hash(data_stats, 5, "Tri par ordre alphabétique",  find_nb_of_capitalized(journalists))
    when 6
      generate_stats_hash(data_stats, 6, "Tri par longueur",  print_array(sort_by_length(journalists)))
    when 7
      generate_stats_hash(data_stats, 7, "Position de @epenser",  find_index(journalists, "@epenser"))
    when 8
      generate_stats_hash(data_stats, 8, "Répartition par longueur", length_distribution(journalists))
    else
      user_input= gets.chomp.to_i
    end

  # imprime les résultats de la question
  puts print_hash(data_stats[user_input])

end
#_________ EXECUTE ________

perform



#__________ TESTS ___________
# puts bulshit_array.length
# puts clean_data(bulshit_array).length
# puts bulshit_array.length
# puts find_nb_of_handles(bulshit_array)
# puts sort_by_length(bulshit_array)
# cap = find_nb_of_capitalized(["@aertRh", "@Azert", "@azer"])
# puts cap.length
# puts sort_by_alpha(bulshit_array)
# puts length_distribution(["@aertRh", "@Azert", "@azer"])
