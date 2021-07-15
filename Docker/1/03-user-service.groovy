public_key = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcA2KlhBqtuJvo7pzfkATLIBtJKKpi3bCfjKyEurbwK0h+7r/b/rRaRhNdSGaOj8+vJbnQ88lcUVsKOAX1j+ABJw4GlXvbLHkqfLIYtPmX4Ru3vDLEPV7ec4JWX5SB8da+0ySC35SI+7iZM8WlzZtEZrxDK+zc5lYWfMy/NcqhvgVCsrQO4ju6KmeGN4bsrqBUC7v76gvXudfXp8UEIRPyWfW44V644OUfXPUDkVmUYgE+R5UnEE635oPLdTvWwiWCL/ZqaxLGULSJrA2ZCDQvUaniX6UO68UQwzValnPK0JyqVErLjykzEkWaAmoGgE8jhkiWBzdgCrWMMMXzjOwN rkuzn@PF2AJ8YZ'
user = hudson.model.User.get('service')
user.setFullName('Service User')
keys = new org.jenkinsci.main.modules.cli.auth.ssh.UserPropertyImpl(public_key)
user.addProperty(keys)
user.save()
