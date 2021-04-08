Raspberry Pi
===========================================================================================

.. contents:: Daftar Isi

Raspberry Pi adalah sebuah board komputer mini. Raspberry Pi bisa berfungsi
sebagai desktop komputer pada umumnya. 

Panduan untuk mulai menggunakan raspberrypi terdapat di `website raspberrypi`_.
Di website tersebut terdapat informasi perihal kelengkapan perangkat, install
sistem operasi, dan pengaturan lainnya.

Getting Started
-------------------------------------------------------------------------------------------

Install OS
*******************************************************************************************

*Operating system* (OS) diinstall dengan cara melakukan flash sebuah image (OS)
pada sebuah microSD. Flash tersebut dilakukan menggunakan sebuah *software*
yang diinstall di komputer (laptop/desktop). Ada banyak *software* yang tersedia
untuk melakukan flash, misalnya **Raspberry Pi Imager** dan **BalenaEtcher**. 

Official OS untuk Raspberry Pi adalah **Raspberry Pi OS**. Tetapi, ada juga OS
dari *third parties*, misalnya Ubuntu. 

Setelah selesai flash, kemudian microSD dimasukkan ke *port* di Raspberry Pi.
Selain itu, diperlukan keyboard, mouse, dan monitor untuk melakukan pengaturan
selanjutnya. 

Apabila tidak tersedia keyboard, mouse, dan monitor, maka pengaturan bisa
dilakukan secara *headless*. Ini dilakukan dengan cara mengatur Raspberry Pi via
*client computer*. Protokol yang digunakan adalah SSH dan VNC. Namun, SSH dan
VNC secara default berada dalam kondisi disable. Oleh karena itu, perlu
di-enable kan untuk penggunaan pertama kalinya.

Kapasitas microSD yang diperlukan sekitas 4 GB. Apabila flash dilakukan ke
microSD yang kapasitasnya besar, maka sisa kapasitas tidak dapat akan digunakan
dikarenakan menjadi *unallocated storage*. Supaya dapat digunakan, gunakanlah
gpated (linux) untuk memperbesar *storage* tersebut. 


Enable SSH
*******************************************************************************************

Secara default, ssh dalam kondisi disable. SSH perlu diaktifkan dengan cara
membuat file ssh sebagai berikut:

::

    $ touch /media/user/boot/ssh

Selanjutnya, koneksi bisa dijalankan dengan cara:

::

    $ ssh pi@ip-address

Enable VNC
*******************************************************************************************

Caranya adalah:

::

    $ sudo raspi-config

Kemudian, pilih interface options > VNC.

Selanjutnya masukkanlah IP Address di VNC viewer yang terinstall di *client
computer*. Apabila ada *issue* dengan *warning* berikut ini, jalankanlah:

::

    cannot currently show the desktop

- ``sudo raspi-config``
- pilih **Display Options**.
- kemudian pilih salah satu resolusi yang ada di pilihan. 

IP Address
*******************************************************************************************

IP Address akan di-assign oleh router melalui DHCP. Oleh karenanya, IP Address
dapat diketahui dengan cara login ke pengaturan router via web.

Cara lainnya adalah dengan menjalankan:

::

    arp -a

IP Address yang dialokasikan oleh DHCP bisa berubah secara dinamis. Agar tidak
berubah, reservasi IP Address harus diatur secara manual di pengaturan router
via web. 

Setting Wifi
*******************************************************************************************

Wifi di Raspberrypi dapat diatur walaupun tidak melalui keyboard dan monitor secara
langsung. Langkah-langkahnya terdapat di website rapsberrypi pada bagian 
`configuration/wireless/headless`_, yaitu:


- Pastikan OS telah terinstall di SD Card
- Buatlah file ``wpa_applicant.conf`` dan simpan di boot folder. Contoh isi file tersebut:

::

        ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
        update_config=1
        country=<Insert 2 letter ISO 3166-1 country code here>

        network={
         ssid="<Name of your wireless LAN>"
         psk="<Password for your wireless LAN>"
        }

Ketika boot, informasi tersebut akan dikopikan ke lokasi yang tepat di Linux
root file system sehingga wifi bisa dijalankan. Kode negara berdasarkan ISO
3166-1 bisa ditemukan di `wikipedia ISO 3166-1`_

.. _wikipedia ISO 3166-1: https://en.wikipedia.org/wiki/ISO_3166-1
.. _configuration/wireless/headless: https://www.raspberrypi.org/documentation/configuration/wireless/headless.md


Ganti Password
*******************************************************************************************

Secara default, username dan passwordnya adalah:

::

        username: pi
        password: raspberry

Password tersebut bisa diganti dengan *command*: ``passwd``

Ganti Hostname
*******************************************************************************************

Default hostname-nya adalah ``pi@raspberrypi``. Hostname tersebut bisa diganti dengan cara:

::

        sudo vim /etc/hostname

File di atas hanya terdiri dari satu line, yaitu nama host. Gantilah nama tersebut sesuai 
dengan yang diinginkan.

Ada sebuah file yang berkaitan dengan hostname ini, tetapi hanya berhubungan dengan software.
Cara editnya adalah:

::

        sudo vim /etc/hosts

Carilah line yang diawali dengan ``127.0.0.1``. Kemudian gantilah hostname-nya.

Resize SD Card
*******************************************************************************************

Setelah sebuah SD card telah di-flash, maka akan terbuatlah 2 partisi yaitu boot dan 
roots. Secara default, besar partisi tersebut telah ditentukan. Jadi apabila memakai SD card 
yang berkapasitas besar, maka sisa *storage* nya tidak akan terpakai (*unallocated*). 
Untuk memaksimalkan kapasitas SD card, maka partisi ``roots`` bisa diperbesar dengan 
software ``gparted``. Resize SD card ini dilakukan di komputer terlebih dahulu. Barulah setelah
itu dimasukkan kembali ke Raspberry Pi.

**Referensi**

- `Resize SD Card <https://elinux.org/RPi_Resize_Flash_Partitions>`_

Cloning SD Card
*******************************************************************************************

Cloning SD Card bisa dilakukan menggunakan ``Win32 Disk Imager``. 

Remote Desktop
*******************************************************************************************

- Install VNC Server

:: 

        sudo apt-get update
        sudo apt-get install realvnc-vnc-server realvnc-vnc-viewer

Setelah install VNC server, lakukan berikut ini:

::

        sudo raspi-config

Navigasikan ke ``interfacing options``, ``P3 VNC``, dan pilih ``Yes``.

- Install VNC viewer di laptop

Download software dari website `realvnc.com`_. Buka aplikasinya kemudian ketikkan ipaddress pada 
kolom yang tersedia di software tersebut.


.. _rename hostname: https://thepihut.com/blogs/raspberry-pi-tutorials/19668676-renaming-your-raspberry-pi-the-hostname
.. _spin.atomicobject.com: https://spin.atomicobject.com/2019/06/09/raspberry-pi-laptop-display/
.. _realvnc.com: https://www.realvnc.com/en/connect/download/viewer/

Secure Copy (SCP)
*******************************************************************************************

Kopi data antar 2 komputer bisa menggunakan ``secure copy`` (SCP). Tutorialnya ada di
website Raspberrypi bagian `remote-access/ssh/scp`_.

**Command Kopi File**

::

    scp filename user@hostname:"complete path"

Misalnya:

::

    scp filename.txt pi@192.168.2.100:"/mnt/data"

**Command Kopi Folder**

::
    
    scp -rp folder user@hostname:"complete path"


**Kopi Multiple Files**

::

        scp myfile.txt myfile2.txt pi@192.168.1.3:

Alternatifnya menggunakan sebuah *wildcard* untuk mengkopi semua file dengan ekstensi tertentu

::

        scp *txt pi@192.168.1.3:

**Note**

Jika *complete path* tidak diberikan, maka file akan tersimpan di:

::

    /home/user/


.. _remote-access/ssh/scp: https://www.raspberrypi.org/documentation/remote-access/ssh/scp.md

Resolusi Monitor
*********************************************************************************

Untuk ukuran monitor Philips pilih resolusi 1680x1050 60 Hz (16:10).

Caranya adalah ketik sudo raspi-config di terminal kemudian

- navigasi ke Advanced Options
- navigasi ke  A5 Resolution
- pilih DMT Mode 58 1680x1050 60 Hz (16:10)

Setting Static IP Address
*********************************************************************************

Buka file berikut:

::

   sudo vim /etc/dhcpcd.conf

Tambahkan line berikut:

::

   interface eth0
   static ip_address = 192.168.0.X
   static routers = 192.168.0.1
   static domain_name_servers=

Line tersebut sebenarnya berupa template yang sudah tersedia di file
``dhcpcd.conf`` dalam bentuk *comment*. 

Selanjutnya bisa digunakan untuk komunikasi via metode berikut:

- SSH

::

   ssh username@ipaddress

- Samba

::

   smb://ipaddress

Note:

- Mengaktifkan LAN, maka wifi menjadi tidak jalan
- Solusi: pastikan ``wpa_supplicant`` telah disetting sebagai berikut:

::

   sudo vim /etc/wpa_supplicant/wpa_supplicant.conf

Isi dengan konten berikut:

::

   network={
      ssid="NETWORKNAME"
      psk="PASSWORD"
      scan_ssid=1
      proto=RSN
      key_mgmt=WPA-PSK
      pairwise=CCMP TKIP
      group=CCMP TKIP
      id_str="home"
      priority=5
   }

- Atur file ``interfaces``    

::

   #backup
   sudo vim /etc/network/interfaces /etc/network/interfaces_BKP
   #edit file
   sudo vim /etc/network/interfaces

Isi dengan konten berikut:

::

   auto lo
   iface lo inet loopback

   auto eth0
   allow-hotplug eth0
   iface eth0 inet static
   address 192.168.0.X
   netmask 255.255.255.0

   auto wlan0
   allow-hotplug wlan0
   iface wlan0 inet static
   wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
   address 192.168.2.X
   netmask 255.255.255.0
   brodcast 192.168.2.255
   gateway 192.168.2.1

   iface default inet dhcp

- Tes koneksi

via LAN : ssh pi@192.168.0.X

via Wifi: ssh pi@192.168.2.X

**Referensi**

- `parallel LAN and Wifi <http://www.knight-of-pi.org/de/paralleler-ethernet-und-wifi-zugriff-fuer-den-raspberry-pi-3/>`_
- `setting LAN and Wifi <https://raspberrypi.stackexchange.com/questions/8851/setting-up-wifi-and-ethernet>`_

Mounting USB Drive
*********************************************************************************

**Kumpulkan Informasi Disk**

- Cari informasi mengenai disk, misalnya nama ``device``, ``size``, dan ``type``

::

        sudo fdisk -l

- UUID

UUID adalah ID untuk sebuah disk. 

::

        sudo ls -l /dev/disk/by-uuid/

**Mount USB drive secara otomatis**


- Buat folder untuk *mount point*. Misalnya /mnt/usb
- Buka file ``/etc/fstab``
- Tambahkan line berikut di akhir line

::

        UUID=2014-3D52(contoh)  /mnt/usb        vfat    uid=pi,gid=pi   0       0

Ganti UUID dengan UUID drive yang digunakan. 

- Save dan exit
- Reboot atau coba dengan *command* berikut:

::

        sudo mount -a

Note:

Jika format storage-nya adalah ntfs, maka install:

::

    $ sudo apt-get update
    $ sudo apt install ntfs-3g

**Referensi**

- `Mount a usb drive <https://raspberrytips.com/mount-usb-drive-raspberry-pi/>`_

CHMOD: File Permission
*********************************************************************************

- `howtogeek.com: chmod on linux <https://www.howtogeek.com/437958/how-to-use-the-chmod-command-on-linux/>`_


Softwares
-------------------------------------------------------------------------------------------

- Vim
- Git  

Web Server (Apache2)
-------------------------------------------------------------------------------------------

.. moving apache web root: https://www.digitalocean.com/community/tutorials/how-to-move-an-apache-web-root-to-a-new-location-on-ubuntu-16-04

Berikut ini adalah tutorial untuk serve HTML files melalui HTTP menggunakan Apache2.

Install Apache2
*******************************************************************************************

Tutorialnya berikut ini didapat dari website Raspberrypi bagian `remote-access/web-server/apache`_.

Sebelum install, update package terlebih dahulu:

::

        sudo apt update

Kemudian install ``apache2``:

::

        sudo apt install apache2 -y

Untuk cek versi apache2:

::

        sudo apache2 -v

Setelah instalasi, maka akan dibuatkan folder dengan path berikut:

::

        var/www/html


Test Web Server
*******************************************************************************************

Secara default, di folder ``var/www/html`` terdapat sebuah file ``index.html``. File tersebut bisa digunakan untuk test apakah web server berhasil diinstall.

Untuk mengetesnya, bukalah ``http://IP-Address``, contohnya ``http://192.168.1.10``. 


Serve Static Web
*******************************************************************************************

Simpanlah file html anda di folder ``var/www/html``. Bukalah alamat web tersebut di browser. 

Ganti Document Root
*******************************************************************************************

Ini bertujuan agar data yang disimpan di usb drive dapat disajikan melalui web server.

Sebelum mengganti ``document root``, *external storage* harus dimounting terlebih dahulu.
Caranya ada website raspberrypi bagian `configuration/external-storage`_.

Secara default, Raspberry Pi akan memunculkan data usb di ``/media/pi/<storage-label>``. Agar 
device tersebut selalu muncul di lokasi tertentu, maka harus diset secara manual.

Caranya:

- plug usb drive ke Raspberry Pi
- identifikasi nama sistem file. Contoh yang didapatkan adalah nama filesystem, misalnya
  ``/dev/sda1``

::

        df -h

- Dapatkan UUID dan Type dari nama filesystem ``/dev/sda1``

::

        sudo blkid /dev/sda1

Contoh hasil dari *command* di atas:

::

        /dev/sda1: LABEL="myusb" UUID="xxxx-xxxx" TYPE="vfat"

Jika storagenya menggunakan sistem file exFAT, maka install exFAT driver:

::

        sudo apt update
        sudo apt install exfat-fuse

Jika storagenya menggunakan sistem file NTFS, maka install ntfs-3g driver:
        
::

        sudo apt update
        sudo apt install ntfs-3g


- Buatlah target folder, misal nama foldernya adalah myusb

::

        sudo mkdir /mnt/myusb

- Mount storage 

::

        sudo mount /dev/sda1 /mnt/myusb

- Cek keberhasilan mount storage

::

        ls /mnt/myusb

- jadikan user (misalnya ``pi``) menjadi pemilik folder

::

        sudo chown -R pi:pi /mnt/myusb

- Editlah file ``fstab``

::

        sudo vim /etc/fstab

Tambahkan line berikut dengan UUID dan Type yang telah didapatkan sebelumnya.

::

        UUID=[UUID] /mnt/myusb [TYPE] gid=1000,uid=1000,dmask=027,umask=022 0 1


- Restart untuk mengetahui hasil perubahan ini

::

        sudo reboot


Setelah melakukan hal di atas barulah ganti ``document root``. File yang perlu diedit adalah:

::

        $ sudo vim /etc/apache2/sites-available/000-default.conf

Tutorialnya ada di website `digitalocean-change-web-root`_.


.. _digitalocean-change-web-root: https://www.digitalocean.com/community/tutorials/how-to-move-an-apache-web-root-to-a-new-location-on-ubuntu-16-04
.. _remote-access/web-server/apache: https://www.raspberrypi.org/documentation/remote-access/web-server/apache.md
.. _configuration/external-storage: https://www.raspberrypi.org/documentation/configuration/external-storage.md 
.. https://pimylifeup.com/raspberry-pi-mount-usb-drive/

Multiple Web 
*******************************************************************************************

Berikut ini tutorial untuk menjalankan dua buah website secara lokal. Struktur folder html  yang 
saya gunakan adalah:

::

        | /mnt/ysi
        | ├── www
        | │   ├── cs
        | │   └── phd

Folder ysi adalah *storage* dari usb drive yang telah dimounting. Folder ``cs`` dan ``phd`` 
adalah folder-folder yang berisi static html.

Sementara struktur folder dari apache2 adalah:

::

        | /etc/apache2/
        | ├── conf-available
        | ├── conf-enabled
        | ├── mods-available
        | ├── mods-enabled
        | ├── sites-available          
        | │   ├── 000-default.conf
        | │   ├── default-ssl.conf
        | │   ├── cs.conf
        | │   └── phd.conf
        | ├── sites-enabled          
        | │   ├── cs.conf
        | │   └── phd.conf
        | ├── envvars
        | ├── magic
        | ├── ports.conf
        | └── apache2.conf


Isi file ``cs.conf``:

::

        <VirtualHost *:81>
                ServerName cs
                ServerAlias www.cs.com
                DocumentRoot /mnt/ysi/www/cs
                ErrorLog ${APACHE_LOG_DIR}/cs_error.log
                CustomLog ${APACHE_LOG_FIR}/cs_access.log combined
        </VirtualHost>


Isi file ``phd.conf``:

::

        <VirtualHost *:80>
                ServerName phd
                ServerAlias www.phd.com
                DocumentRoot /mnt/ysi/www/phd
                ErrorLog ${APACHE_LOG_DIR}/phd_error.log
                CustomLog ${APACHE_LOG_FIR}/phd_access.log combined
        </VirtualHost>


Sebelum bisa digunakan, ``cs.conf`` dan ``phd.conf`` harus diaktifkan:

::

        $ sudo a2ensite cs.conf

::
        
        $ sudo a2ensite phd.conf


Untuk menonaktifkan:

::

        $ sudo a2dissite cs.conf

Pengaturan ports dilakukan di:

::

        $ sudo vim /etc/apache2/ports.conf

Isi file ``ports.conf``:

::

        Listen 80
        Listen 81

Kemudian restart apache:

::

        $ sudo systemctl restart apache2

Untuk mengakses website, bukalah browser kemudian ketikkan address berikut:

::

        192.168.x.xxx:80
        192.168.x.xxx:81

**Referensi**

- `digitalocean-setup-virtual-hosts`_.
- `pimylifeup-setup-apache-web-server`_


.. _digitalocean-setup-virtual-hosts: https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-18-04
.. _pimylifeup-setup-apache-web-server: https://pimylifeup.com/raspberry-pi-apache/

Web Server (Nginx - Docker)
-------------------------------------------------------------------------------------------

Berikut ini adalah cara menjalankan Nginx menggunakan docker. 

Struktur foldernya adalah sebagai berikut:

::

    web
    ├── conf          
    │   └── default.conf
    ├── html         
    └── docker-compose.yml

Isi default.conf:

::

	server {
	    location / {
	       root /var/www/html;
	       try_files $uri $uri/index.html $uri.html =404;
	    }
	  }

Isi docker-compose.yml:

::

	version: '3.1'

	services:
	   web:
	     image: nginx
	     container_name: w3
	     ports:
	       - 80:80
	     restart: always
	     volumes:
	       - ./html:/var/www/html
	       - ./conf/default.conf:/etc/nginx/conf.d/default.conf

Kemudian jalankan:

::

	$ docker-compose up -d


File Sharing (Samba)
-------------------------------------------------------------------------------------------

Samba memungkinkan pertukaran data antara linux dengan windows melalui network dalam bentuk
``shared folder``. Berikut ini adalah cara-cara untuk menyetting samba:

- terlebih dahulu update package

::

        sudo apt-get update
        sudo apt-get upgrade

- install samba

::

        sudo apt-get install samba samba-common-bin

- sebelum dishare melalui network, buatlah terlebih dahulu folder yang akan dishare. Misalnya sebuah folder yang bernama ``shared``.

::

        mkdir /home/pi/shared

- aturlah konfigurasi samba dengan membuka file ``smb.conf`` berikut:

::

        sudo vim /etc/samba/smb.conf

tambahkan *script* berikut pada bagian akhir file ``smb.conf``:

::

        [shared]
        path = /home/pi/shared
        writeable = Yes
        create mask = 0777
        directory mask = 0777
        public = no

- setup user for samba. Sebagai contoh user "pi" dengan password "raspberry"

::

        sudo smbpasswd -a pi

- restart samba service

::

        sudo systemctl restart smbd

**Referensi**

- `How to setup a raspberry pi samba server`_

.. _How to setup a raspberry pi samba server: https://pimylifeup.com/raspberry-pi-samba/

Wireless Printer
----------------------------------------------------------------------------------

Berikut ini adalah langkah-langkah untuk menjadikan usb printer menjadi wireless
printer. Konsep dasarnya adalah dengan cara menghubungkan usb printer ke
raspberryPi. Kemudian raspberryPi melakukan sharing ke network.

- Install **Common Unix Printing System (CUPS)**

::

        sudo apt-get install cups

- Masukkan user ke usergroup. Usergroup yang dibuat oleh CUPS adalah **lpadmin**
  dan default user untuk raspberrypi adalah **pi**

::

        sudo usermod -a -G lpadmin pi

- Bukalah localhost:631 di browser dan lakukan konfigurasi

**Referensi**

- `Add a printer to a raspberry
  <https://www.howtogeek.com/169679/how-to-add-a-printer-to-your-raspberry-pi-or-other-linux-computer/>`_

DNS Server
---------------------------------------------------------------------------------

DNS adalah singkatan dari *Domain Name System*. DNS berguna untuk menterjemahkan
nama domain ke *IP addresses*. Dalam sebuah jaringan, *devices* hanya
berkomunikasi menggunakan  *IP addresses* dan membutuhkan DNS server untuk
mengkonversi *host name* ke IP. Untuk keperluan tertentu, misalnya menambahkan
*custom* domain untuk *home networking*, dns server bisa diinstall di Raspberry
Pi.  

**Install dnsmasq di Raspberry Pi**

::

	$ sudo apt-get update
	$ sudo apt install dnsmasq

**Konfigurasi DNS**

- Buka 

::

	$ sudo vim /etc/dnsmasq.conf

- Comment out atau tambahkan code berikut

::

	domain-needed
	bogus-priv
	expand-hosts
	no-resolv
	server=8.8.8.8
	server=8.8.4.4

	#custom domain
	address=/contoh.ysi/192.168.2.113

	expand-hosts
	cache-size=1000

	dchp-mac=....
	dchp-reply-delay=....

- Exit dan restart dnsmasq

::

	$ sudo service dnsmasq restart

**Tes**

Tes dijalankan di komputer lain yang terhubung ke network.

- buka command line
- start nslookup

::

	$ nslookup

- secara default nslookup menggunakan DNS saat ini, untuk menggantinya bisa
  mengetikkan 

::

	$ server A.B.C.C

Ganti A.B.C.D dengan IP Address.

Kemudian ketikkan **contoh.ysi**.

**Komputer Klien**

Aturlah DNS di komputer/*mobile phone* yang terhubung ke network agar bisa menggunakan nama
domain yang terdapat pada dns server (Raspberry Pi pada kasus ini). 

**Referensi**

- `how to use your Raspberry Pi as a DNS server`_
- `deviceplus: raspberry pi as a DNS server`_
- `pimylifeup: raspberry pi a DNS server`_

Local Hostname
---------------------------------------------------------------------------------

- Buka file

::

	$ sudo vim /etc/hosts

- Tambahkan IP Address dan nama domain

::

	192.168.1.17 	contoh.ysi

VPN
---------------------------------------------------------------------------------

VPN berguna agar home networking bisa diakses dari luar jaringan. 

**Install PiVPN di Rpi**

- Buka terminal
- Jalankan:

::

    curl -L https://install.pivpn.io | bash

- Ikuti instruksi install. Gunakan konfigurasi berikut:   

    - PiVPN automated installer [Ok]
    - Static IP needed [Ok]
    - DHCP reservation [Yes]
    - Local users [Ok]
    - Choose a user  [pi]
    - Installation mode [WireGuard]
    - Installation packages
    - Wireguard port [default 51820] > bisa pakai port yang lain
    - Confirm custom port number [Yes]
    - DNS provider [Google]
    - Public IP or DNS [Use this public IP]
    - Server information
    - Unattended upgrades
    - Installation complete!
        + create profile: $ pivpn add
        + show qr code: $ pivpn -qr
        + config file disimpan di ~/configs
    - Setting port-mapping di router
        + pilih udp protocol
    - Install WireGuard Client
        + Iphone > scan qr code
        + MacOS dan Windows > install app kemudian import config file
        + Ubuntu > belum berhasil

**Referensi**

- `Install PiVPN <https://www.pivpn.io/>`_
- `Youtube: Install PiVPN <https://www.youtube.com/watch?v=zsN47t2r_WU>`_

Boot dari USB
---------------------------------------------------------------------------------

- Jalankan Rpi dengan sd card
- Update dan upgrade
   + sudo apt update
   + sudo apt full-upgrade
- Ganti boot order
   + sudo raspi-config > advanced options > A6 boot order > usb boot > reboot
- Clone sd card ke usb storage (flashdrive/ssd)


.. Referensi

.. _`how to use your Raspberry Pi as a DNS server`: https://raspberrytips.com/raspberry-pi-dns-server/
.. _`deviceplus: raspberry pi as a DNS server`: https://www.deviceplus.com/raspberry-pi/how-to-use-a-raspberry-pi-as-a-dns-server/
.. _`pimylifeup: raspberry pi a DNS server`: https://pimylifeup.com/raspberry-pi-dns-server/
.. _`website raspberrypi`: https://www.raspberrypi.org/software/

