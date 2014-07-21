#!/usr/bin/env sh

# --password-store=<basic|gnome|kwallet>
# Set the password store to use.  The default is to automatically
# detect based on the desktop environment.  basic selects the
# built in, unencrypted password store.  gnome selects Gnome
# keyring.  kwallet selects (KDE) KWallet.  (Note that KWallet may
# not work reliably outside KDE.)
chromium-browser --password-store=kwallet

