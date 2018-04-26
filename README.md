# mac-toggle-wifi
Automatically toggle Wi-Fi on / of based on if another network is available. Typical use is to turn Wi-Fi off when a wired (ethernet) connection is available and to turn Wi-Fi on when no ethernet connection is available.
## Setup
### Configure network service order
In "System Preferences" -> "Network" reorder networks so you prioritize wired networks over Wi-Fi.
### Download sources
```
git clone git@github.com:skjaidev/mac-toggle-wifi.git
```
### Run install script
```
./install.sh
```
