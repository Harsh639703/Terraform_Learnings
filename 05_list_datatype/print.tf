output printe {
    value="first user is ${var.users[0]}"   #${var.users[0]} :- this will give the first value of the index
}

#terraform plan -var 'users=["gayrav","saurav","fte"]'