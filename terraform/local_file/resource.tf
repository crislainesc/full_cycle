resource "local_file" "example" {
  filename="example.txt"
  content = var.content
}

data "local_file" "example" {
    filename="example.txt"

}

output "data_source" {
  value=data.local_file.example.content_base64
}

variable "content" {
  type = string
}

output "file_info" {
  value = [resource.local_file.example.id,var.content]
}

output "content" {
  value = var.content
}


