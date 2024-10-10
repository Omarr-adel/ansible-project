resource "aws_lb" "this" {
  name               = var.lb_name
  internal           = true
  load_balancer_type = "application"
  subnets            = var.subnets
}

resource "aws_lb_target_group" "this" {
  name     = var.lb_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

output "alb_dns" {
  value = aws_lb.this.dns_name
}
# Register the first instance
resource "aws_lb_target_group_attachment" "instance1" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.instance1_id
  port             = 80
}

# Register the second instance
resource "aws_lb_target_group_attachment" "instance2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.instance2_id
  port             = 80
}