resource "aws_route53_record" "myajay_route53_record" {
    zone_id = "Z017744921XM45LEYQ2D7"
    name = "myajay-demo-app.myajay.com"
    type = "A"
    alias {
      name = aws_lb.myajay_lb.dns_name
      zone_id = "ZQSVJUPU6J1EY"
      evaluate_target_health = true
    }
  
}