resource "aws_launch_template" "myajay_ha_lt" {
  name_prefix   = "myajay-ha-"
  image_id      = var.ami
  instance_type = var.instance_type
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.myajay_ha_sg.id]
  }

  user_data = filebase64("userdata.sh")
  key_name  = var.key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.myajay_intance_profile.id
  }

}

resource "aws_autoscaling_group" "myajay_ha_asg" {
  name_prefix         = "terraform-asg-"
  min_size            = 3
  max_size            = 6
  desired_capacity    = 3
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.myajay_ha_lt.id
    version = "$Latest"
  }
  health_check_type         = "ELB"
  health_check_grace_period = 300
  target_group_arns         = [aws_lb_target_group.myajay_tg.arn]
  tag {
    key                 = "Name"
    value               = "myajay-ha"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "myajay_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.myajay_ha_asg.name
  lb_target_group_arn    = aws_lb_target_group.myajay_tg.arn
}


