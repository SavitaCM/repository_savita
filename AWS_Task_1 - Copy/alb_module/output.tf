output "tg_arn" {
  value = aws_lb_target_group.sampleapp_http_tg.arn
}

output "vpc" {
  value = module.vpc
}
