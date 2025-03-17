resource "aws_lb" "kiu_lb" {
  name               = "kiu-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets           = [aws_subnet.kiu_subnet_public[0].id, aws_subnet.kiu_subnet_public[1].id]  # Cambio de subnet_public a kiu_subnet_public
}
