# Fetch hosted zone
data "aws_route53_zone" "main" {
  name = "allia.health."  # Ensure trailing dot
}

# A record for Ubuntu instance
resource "aws_route53_record" "ubuntu" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "ubuntu.allia.health"
  type    = "A"
  ttl     = 60
  records = [aws_instance.ubuntu_instance.public_ip]

  depends_on = [aws_instance.ubuntu_instance]
}

# A record for Amazon Linux 2 instance
resource "aws_route53_record" "amazon_linux_2" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "al2.allia.health"
  type    = "A"
  ttl     = 60
  records = [aws_instance.amazon_linux_2_instance.public_ip]

  depends_on = [aws_instance.amazon_linux_2_instance]
}

# A record for Amazon Linux 2023 instance
resource "aws_route53_record" "amazon_linux_2023" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "al2023.allia.health"
  type    = "A"
  ttl     = 60
  records = [aws_instance.amazon_linux_2023_instance.public_ip]

  depends_on = [aws_instance.amazon_linux_2023_instance]
}
