resource "null_resource" "setup-httpd" {
	triggers {
		build_number = "${timestamp()}"
	}
	provisioner "local-exec" {
		command = "setup-apache-httpd.sh"
	}
}
