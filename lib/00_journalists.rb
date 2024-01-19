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
  result = array.min_by{|item| item.length}
  # renvoyer le 1er item
  return result
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
def generate_stats_hash(menu, result)
  # puts result.class
  hash[menu]= {label => result}
  return hash
end

# Afficher le menu >> puts + return Hash
def print_menu
menu= Hash.new(0)
menu[1]="Nombre de handles (uniques)"
menu[2]="Le handle le plus court"
menu[3]="Nombre de handle contenant 5 caractères"
menu[4]="Nombre de handle commançant par une mujuscule"
menu[5]="Tri par ordre alphabétique"
menu[6]="Tri par longueur"
menu[7]="Recherche position de @epenser"
menu[8]="Répartition par longueur"

# affichage
menu.each{|key, value| puts "#{key} - #{value}"}

return menu
end

# User input: entre le numéro de question >> return Integer
def get_user_input
    # l'utilisatuer rentre un numéro de question
  #TODO faire le menu
  puts "\nEntre un numéro entre 1 et 8 : "
  user_input = 0
  while !user_input.between?(1,8)
    user_input = gets.chomp.to_i
  end
 return user_input
end

# selection / execution de la question en fonction du choix du user
def menu_select(menu, num, array)
  # lance 1 méthode en fonction de numéro du menu
  case num
  when 1
    puts "#{menu[num]} : #{find_nb_of_handles(array)}"
  
  when 2
    puts "#{menu[num]} : #{find_the_shorter(array)}"
  
  when 3
    # demande le nombre de caractères
    print "Entre le nombre de caractères : "
    nb_caract =0
    while nb_caract ==0
      nb_caract = gets.chomp.to_i
    end

    puts "#{menu[num]} : #{find_nb_of_xcaract(array, nb_caract)}"
  
  when 4
    puts "#{menu[num]} : \n #{find_nb_of_capitalized(array)}"
 
  when 5
    puts "#{menu[num]} : "
    puts sort_by_alpha(array)
  
  when 6
    puts "#{menu[num]} : "
    puts sort_by_length(array)
  
  when 7
    # demande le handle à rechercher
    print "Entre le handle à rechercher : "
    hendle =""
    while hendle ==""
      hendle = gets.chomp
    end

    puts "#{menu[num]} : #{find_index(array, hendle)}"
  
  when 8
    puts "#{menu[num]} : "
    length_distribution(array).each { |k, v| puts "#{k.to_s.rjust(2, " ")} caract. : #{v} mots"}
  else
    num_menu = get_user_input
  end
end


#___________ P E R F O R M ___________
def perform
  pg =0
  while pg=0
    system("clear")
    # affiche du menu des questions
    menu = print_menu
    #choix de l'utilisateur
    num_menu = get_user_input
    # calcule et imprime les résultats de la question
    menu_select(menu, num_menu, journalists)
    puts "(PS, pensez a ctrl + L(windows) ou cmd + K (Mac) pour clear votre console)"
    puts gets.chomp   
  end
end

#_________ EXECUTE ________

perform

#TODO
#(PS, pensez a ctrl + L(windows) ou cmd + K (Mac) pour clear votre console)

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
