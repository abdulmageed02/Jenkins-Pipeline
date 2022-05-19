resource "aws_lb_target_group" "NLB_target_group" {
  name        = "NLB-TG"
  port        = 3000
  protocol    = "TCP"
  # target_id = aws_instance.private-EC2.id
  vpc_id      = module.network.vpc_id
  }



resource "aws_lb_target_group_attachment" "one" {
  target_group_arn = aws_lb_target_group.NLB_target_group.arn
  target_id        = aws_instance.private-EC2.id
  port             = 3000
}
resource "aws_lb" "NLB" {
  name               = "NLB"
  internal           = false
  load_balancer_type = "network"
#   security_groups    = [aws_security_group.SG-2.id]
  subnets            = [module.network.pub2_id ,module.network.pub1_id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.NLB.arn
  port              = "80"
  protocol          = "TCP"
  # vpc_id            = module.network.vpc_id
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.NLB_target_group.arn
  }
}

