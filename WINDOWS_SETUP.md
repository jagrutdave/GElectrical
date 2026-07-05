# Running this GElectrical fork from source on Windows

GElectrical is Python + GTK3. On Windows, GTK/PyGObject must come from MSYS2
(plain `pip` cannot install them).

## 1. One-time environment setup

1. Install MSYS2 from https://www.msys2.org (default path C:\msys64).
2. Open the **"MSYS2 MinGW 64-bit"** shell and run:

       pacman -Syu        # (restart shell if asked, run again)
       pacman -S --needed \
         mingw-w64-x86_64-python \
         mingw-w64-x86_64-python-pip \
         mingw-w64-x86_64-python-gobject \
         mingw-w64-x86_64-python-cairo \
         mingw-w64-x86_64-gtk3 \
         mingw-w64-x86_64-python-numpy \
         mingw-w64-x86_64-python-scipy \
         mingw-w64-x86_64-python-pandas \
         mingw-w64-x86_64-python-matplotlib \
         mingw-w64-x86_64-python-shapely \
         mingw-w64-x86_64-python-pillow \
         mingw-w64-x86_64-python-openpyxl \
         mingw-w64-x86_64-python-jinja \
         mingw-w64-x86_64-python-cffi

3. Then the pure-python deps via pip (same shell):

       pip install pandapower weasyprint appdirs undo mistune==0.8.4

   (If a package complains, check the versions used by the project's
   snapcraft.yaml / build_flatpak.sh for the known-good set.)

## 2. Run the fork

    cd /d/GElectrical_fork
    python gelectrical_launcher.py

Your user library (AppData\Local\kavilgroup\GElectrical\1\database - the
LK U-Power ACBs and Polycab cables) is picked up by the source build too,
since it lives in the user profile, not the install.

## 3. Build your own Windows installer (optional)

    pacman -S mingw-w64-x86_64-python-pyinstaller mingw-w64-x86_64-nsis
    cd /d/GElectrical_fork
    pyinstaller pyinstaller_spec.spec
    # then compile installer.nsi with NSIS against the dist/ output

## 4. Keeping the fork in sync

    git fetch upstream
    git checkout local-fixes
    git merge upstream/master     # bring in upstream changes, keep your fixes

## 5. Publishing to your GitHub

Create an empty repo/fork on GitHub, then:

    git remote set-url origin https://github.com/<your-username>/GElectrical.git
    git push -u origin local-fixes master

## Local changes carried on branch `local-fixes`

- `gelectrical/elementmodel/line.py`: cable sizes extended 300 -> 1000 sq.mm.
  (sizes 400/500/630/800/1000 added; IEC 60364-5-52 Annex D power-law
  coefficients extrapolated above 300 sq.mm. Verified against Polycab LT XLPE
  catalogue: air/tray methods within ~2%, buried methods ~4-6% optimistic
  above 500 sq.mm - cross-check buried >500 sq.mm designs with IEC 60287 or
  manufacturer data.)
