variable users {
    type=map 
    default = {
        gaurav = 20
        saurav = 18
        harsh = 54
        himanshu = 14
    }
}

variable "username" {
  type=string
}

#cmdline terraform plan -var=‘user_info={“gaurav”:”20”,”saurav”:”19”}’

