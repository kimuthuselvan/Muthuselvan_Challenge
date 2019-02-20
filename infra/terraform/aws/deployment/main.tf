resource "null_resource" "web-deploy" {
	triggers {
		build_number = "${timestamp()}"
	}
	provisioner "local-exec" {
		command = "deploy.sh"
	}
}
