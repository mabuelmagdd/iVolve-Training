resource "tls_private_key" "priv_key" {
  count     = 2  
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "pub_key_file" {
  count    = 2  
  content  = [tls_private_key.priv_key[count.index].public_key_openssh]
  filename = "pub_key_${count.index == 0 ? "pub_instance" : "priv_instance"}.pem"  # Naming the files based on count.index (az1 and az2)
}

resource "local_file" "priv_key_file" {
  count    = 2  
  content  = [tls_private_key.priv_key[count.index].private_key_pem]
  filename = "priv_key_${count.index == 0 ? "pub_instance" : "priv_instance"}.pem"  # Naming the files based on count.index (az1 and az2)
}

resource "aws_key_pair" "key_pair" {
  count       = 2  
  key_name    = "key_pair_${count.index == 0 ? "pub" : "priv"}"  # Naming the key pair based on count.index (az1 and az2)
  public_key  = [local_file.pub_key_file[count.index].content]
}