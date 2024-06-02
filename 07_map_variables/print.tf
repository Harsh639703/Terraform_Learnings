output pp{
    value = "my name  is ${var.username} , my age is ${lookup(var.users,"${var.username}")}"
}

# output pap{
#     value = "my name  is ${var.username} , my age is ${lookup(var.users,"saurav")}"
# }