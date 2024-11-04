#cloud-config
repo_update: true
repo_upgrade: true
apt:
  preserve_sources_list: true
runcmd:
  - |
    IP_ADDRESS=$(hostname -I | awk '{print $1}')

    echo '<!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Картинка из бакета</title>
        <style>
            img {
                max-width: 100%;
                height: auto;}
        </style>
    </head>
    <body>
        <h1>Привет из облака</h1>
        <img src="https://storage.yandexcloud.net/${bucket}/${key}" alt="Картинка">
        <p>IP адррес ВМ: '$IP_ADDRESS'</p>
    </body>
    </html>' > /var/www/html/index.html
  - systemctl restart apache2
users:
  - name: dadmin
    groups: sudo
    shell: /bin/bash
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    ssh-authorized-keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtecP2KqLIuP77Quw4EdREvONwUBq3p2lbSbaUmOher