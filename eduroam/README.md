# GT Eduroam

## Setup

1. Follow [Connecting to Eduroam using GT's New Certificate-based Authentication](https://shibata.nyiyui.ca/log/07-eduroam-cert/) to make sure the device can connect.
2. Download the P12 file and put the path in `assr.eduroam.client-cert`.
3. Put a path in `assr.eduroam.env` to a shell script like the following:
```env
EDUROAM_PRIVATE_KEY_PASSWORD='<the passphrase>'
```
