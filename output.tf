output "pubEC2" {
  value = aws_instance.public-EC2.public_ip
}


output "privEC2" {
  value = aws_instance.private-EC2.private_ip
}

output "key" {
  value = tls_private_key.private_key_pair.private_key_pem
  sensitive = true

}
output "rds_add" {
  value = aws_db_instance.rds.address

}
output "rds_port" {
  value = aws_db_instance.rds.port

}
output "redis_add" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address

}

output "redis_port" {
  value = aws_elasticache_cluster.redis.port

}


output "app_link" {
  value = aws_lb.NLB.public_ip

}