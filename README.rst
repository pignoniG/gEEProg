gEEProg
=======

Python module and GUI for controlling the 2801Prog, 2006Prog, 1400Prog and other
EEPROM programmers.

Homepage: http://www.dasarodesigns.com/

Source home: https://github.com/markchil/gEEProg

Releases (including packaged binaries): https://github.com/markchil/gEEProg/releases

Requirements:

- Python 3.8 or newer
- PySerial 3.0 or newer (installed automatically by pip)
- Tkinter (included with most Python installations)

Version 2.2 ports the software from Python 2.7 to Python 3. Python 2 is no
longer supported.

To install/run from source:

1) Ensure you have Python 3 installed: https://www.python.org/downloads/

2) Ensure Tkinter is available by running `python3 -m tkinter`. If it fails,
   see https://tkdocs.com/tutorial/install.html (on Linux this is usually a
   package such as `python3-tk`).

3) From the top-level directory of this source tree, execute the command::

    python3 -m pip install .

   (Using a virtual environment is recommended:
   `python3 -m venv venv && . venv/bin/activate` first.)

4) You can now access the gEEProg package's raw commands with `import gEEProg`.

5) The GUI is a Python script called gEEProgGUI, installed in the `bin`
   (or `Scripts` on Windows) directory of your Python environment. With that
   directory on your PATH, launch the GUI by typing `gEEProgGUI` at the shell.
   You can also run it directly from the source tree with
   `python3 src/gEEProgGUI`.

To build a self-contained macOS app:

Run `sh build/osx/build_app.sh`. This creates `dist/gEEProg.app` and
`dist/gEEProg.zip` using PyInstaller. The script uses Homebrew's Python 3.11 by
default; set the `PYTHON` environment variable to use a different interpreter
(it must have a working Tkinter). The app is ad-hoc signed, so on other Macs it
must be opened the first time via right-click, Open. Distributing it without
Gatekeeper warnings requires signing with an Apple Developer ID and
notarization.
