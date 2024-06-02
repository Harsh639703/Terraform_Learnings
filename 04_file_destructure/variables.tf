# variable username {}


//setting the default value in the variable
# variable username {
#     default = "Sudama"
# }

//Now we are adding the datatype in the variable of terraform

variable age {
    type = number//this will take the input of the age only in the numeber format
}
variable username {
    type = string//this will take take the input in the string otherwise it will give error
}

//In this we are taking the more than one variable as a comman input
# terraform plan -var "username=tillu" -var "age=47"