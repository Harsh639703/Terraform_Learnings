output print {
    value= "${join(":-", var.users)}"//join function Take two arguments
}


output printe{
    value="${upper(var.users[0])}"  #upper function change the string into the upper case 
}

output pr{
    value="${lower(var.users[1])}"   # lower function change the string into the lower case
}

output pqr{
    value="${title(var.users[1])}"   # title function change the strings element first letter into the upper case
}