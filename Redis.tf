
resource "aws_elasticache_subnet_group" "WP" {
  name       = "redis-SG"
  subnet_ids = [module.network.private1_id,module.network.private2_id]
}


resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  security_group_ids =   [aws_security_group.DB-test.id]
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.WP.name
}   
