# Python Virtual Environment

Installs a local version of Python (Currently v3.7.12) to ~/.local/Python-VERSION and creates a virtual environment for use with the the [AutoParVisualizer](https://github.com/vgene/AutoParVisualizer.git).

Usage:

If we only want to install python:
```
  ./pythonInstaller.py
```

If we want to set up a virtual environment (also installs python if not already installed):
```
  ./setupVirtualEnv.sh
```

To enter virtual environment (from this directory):
```
  source ./virtualEnv/bin/activate 
```

To exit virtual environment (from anywhere):
```
  deactivate
```

