build {
  sources = [
    "source.amazon-ebs.goldenami"
  ]
  provisioner "ansible" {
    playbook_file   = "./ansible/main.yml"
    extra_arguments = ["-v"]
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False"
    ]
    user = var.username
  }
}
