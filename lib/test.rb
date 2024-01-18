require_relative "./arrays.rb"

monarray = ["@jcunnyiet","@PaulLampon","@Azilyiz31","@ssouMier","@marionsouzeau","@gaeyllombart"]


puts monarray.count{ |handle|  /[[:upper:]]/.match(handle[1]) }


