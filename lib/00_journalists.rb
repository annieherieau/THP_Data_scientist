# 2.2. Big data
require_relative "./arrays.rb"

# ____________METHODS__________

# Nettoyer les data (bulshit) >> return  Array 
def clean_data(array)
  # garder les elements commençant par @
  new_array = array.filter{|element| element[0]=="@"}

  # garder les handles uniques
  new_array.uniq!

  return  new_array
end

# 1- Combien de handles? >> return Integer
def find_nb_of_handles(array)
  # compter les entrées commançant par @
  return array.count{|element| element[0]=="@"}
end

# 2- le handle le plus court >> return String
def find_the_shorter(array)
  #trier l'array par taille croissante
  result = array.min_by{|element| element.length}
  # renvoyer le 1er element
  return result
end

# 3- Nombre de handle contenant x caractères (@ exclu) >> return Integer
def find_nb_of_xcaract(array, nb_caract)
  return array.count{|element| element.length == nb_caract+1} 
end

# demande du nombre de caractères >> return Integer
def ask_nd_caract
  print "Entre le nombre de caractères du handle (sans @) : "
  nb_caract =0
  while nb_caract ==0
    nb_caract = gets.chomp.to_i
  end
  return nb_caract
end

# 4- Nombre de handles commençant par une majuscule >> return Integer
def find_nb_of_capitalized(array)
  result = array.count{ |element|  /[[:upper:]]/.match(element[1]) }
  return result
end 

# 5. Trie par ordre alphabétique (non sensible à la casse) >> return Array
def sort_by_alpha(array)
return array.sort_by{|element| element.downcase}
end

# 6. Trie la liste de handle par taille des handle croissant
def sort_by_length(array)
  return array.sort_by{|handle| handle.length}
end

# 7. Position (index) de la personne @epenser ? >> return Integer
def find_index(array)
  # demande le handle à rechercher
  print "Entre le handle à rechercher (avec @): "
  search_string =""
  while search_string[0] != "@"
    search_string = gets.chomp
  end
  return array.index{|element| element == search_string}
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

# Affichage de la répartition
def print_distribution(hash, k_label, v_label)
  hash.each do |k, v| 
    v == 1 ? s = "" : s = "s"
    puts "#{k} #{k_label} : #{v} #{v_label}#{s}" 
  end
end

# créer le hash les stats >> return Hash
def generate_stats_hash(menu, result)
  # puts result.class
  hash[menu]= {label => result}
  return hash
end

def print_titre
  puts "______________________________"
  puts ""
  puts "   BIG DATA Handles Twitter   "
  puts "______________________________"
  puts ""
end

# Afficher le menu >> puts + return Hash
def print_menu
menu= Hash.new(0)
menu[1]="Nombre de handles des journalistes"
menu[2]="Le handle le plus court"
menu[3]="Nombre de handles contenant n caractères"
menu[4]="Nombre de handles commançant par une majuscule"
menu[5]="Tri des handles par ordre alphabétique"
menu[6]="Tri des handles par longueur"
menu[7]="Recherche position d'un handle @xxxx"
menu[8]="Répartition des handles par longueur"

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
    puts "#{menu[num]} : #{find_nb_of_xcaract(array, ask_nd_caract)}"
  
  when 4
    puts "#{menu[num]} : #{find_nb_of_capitalized(array)}"
 
  when 5
    puts "#{menu[num]} : "
    puts sort_by_alpha(array)
  
  when 6
    puts "#{menu[num]} : "
    puts sort_by_length(array)
  
  when 7
    puts "#{menu[num]} : #{find_index(array)}"
  
  when 8
    puts "#{menu[num]} : "
    print_distribution(length_distribution(array), "caract.", "mot")
  else
    num_menu = get_user_input
  end
end

def go_next
  # puts "> pour CLEAR ta console : Appuie sur 'c' ou 'C'"
  puts "> pour QUITTER : Appuie sur 'q' ou 'Q'"
  puts "> pour CONTINUER : Appuie sur 'Entrer'"
  user_quit = gets.chomp.downcase
  if user_quit == "c" then system("clear")end
  return user_quit
end

#___________ P E R F O R M ___________
def perform
  quit = "0"
  while quit != "q"

  quit = ""
  while quit != "q"
    system("clear")
    # affiche du titre et Menu des questions
    print_titre
    menu = print_menu
    puts "____________________________________"
    
    #choix de l'utilisateur
    num_menu = get_user_input
    
    # calcule et imprime les résultats de la question
    menu_select(menu, num_menu, journalists)
    puts "____________________________________"
    puts ""

    # Passer à la suite
    quit = go_next

  end
  puts "Tu peux reprendre une activité normale !\n Ciao, bon dimanche 👋 🤓"
end

#_________ EXECUTE ________

perform
