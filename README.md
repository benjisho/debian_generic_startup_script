# generic_startup_script

This is also a useful script that will install whatever u need on your `Debian` machine during the startup.
I wrote 2 versions of it.
- `startup.sh` - just update the list of packages and it will install it if it wasan't already installed.
- `startup_with_version_check.sh` - Better for a closed LAN environments, it is a bit of a smarter version that will also check if the **exact version** of the package you are trying to install already exists and if not it will install exactly it.
    
    > even if it means to downgrade a package you upgraded!
    > So if you choose the second script - keep an eye your versioning :)

- Feel free to edit it as you see fit:

#### Startup script installation
1. Save the  this way - `/opt/startup.sh`

2. Create the service file - `/etc/systemd/system/startup.service`
```bash
[Unit]
Description=Startup script service

[Service]
Type=simple
ExecStart=/bin/bash /opt/startup.sh

[Install]
WantedBy=multi-user.target
```
> The unit file has three sections: Unit, Service, and Install.

> - The Unit section contains general metadata, such as a description of the service.

> - The Service section describes the process and daemonizing behavior, along with the command to start the service.

> - The Install section specifies when the service should be started, in this case, when the system reaches the multi-user target.

3. Enable the service with the systemctl command:
```bash
$ sudo systemctl enable startup.service
```
This will create a symbolic link from `/etc/systemd/system/multi-user.target.wants/startup.service` to `/etc/systemd/system/startup.service`, which tells systemd to start the service at boot time.

4. You can also start, stop, restart, or check the status of your service manually with the systemctl command
```bash
$ sudo systemctl start startup.service
$ sudo systemctl stop startup.service
$ sudo systemctl restart startup.service
$ sudo systemctl status startup.service
```
## Contributing

Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

- benjisho

See also the list of contributors who participated in this project.

## License

This project is licensed under the GNU License - see the LICENSE.md file for details.
