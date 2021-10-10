# Play with vscode for analytics in python

**Objective** :dart:
* A vscode environment for development & analytics with python, all using the [remote-container feature](https://code.visualstudio.com/docs/remote/containers)
    * Run a development workflow (build, edit, run, debug)
    * Run an analytics workflow
        * Run a jupyter notebook inside the devcontainer
        * Run a python interactive window
        * Run a jupyter notebook connected to a remote jupyter server

**How-to** :book:

_All steps below are inside the devcontainer._

* :hammer: **Build** the remote container
    * Clone and open this repository with vscode
    * Press `F1` and select **Remote-Containers: Open Folder in Container...**
    * Select the root directory of this repo, wait for the container to start, and try things out!

* :scroll: **Show logs**
    * Press `F1` → select `view logs`

* :pencil2: **Edit** code
    * Open `main.py`
    * Try adding some code and check out the language features.
    * Try auto-complete: hit `cmd+space`

* :runner: **Run** a file
    * Press ctrl+shift+` to open a terminal pane
    * Type `python -m play.main` in the terminal pane
    * Check the output in the terminal pane

* :bug: **Debug**
    * Open `main.py`
    * Add a breakpoint on a line
    * Press `F5` to launch the app in the container (select run the current file in debug mode)
    * Once the breakpoint is hit, try hovering over variables, examining locals, etc.

* :notebook: Run a **jupyter notebook inside the devcontainer**
    * Make sure that `"jupyter.jupyterServerType": "local"` is set in in `.vscode/settings.json`
    * `F1` -> select `Remote-Container : Reopen in Container`
    * Open the `sample.ipynb` file
    * If you see the `No Python interpreter is selected...` popup → select the one that says `usr/local/bin/python` python 3.9.7
    * Select a cell and run it with `ctrl+enter` (same as in usual jupyter notebook webui)

* :repeat: Run a **python interactive window**
    * go to `main.py`
    * `F1` -> run in interactive window
    * in the interractive window, select interpreter `usr/local/bin/python` `(python 3.9.7)` (it's the one provided by the devcontainer)
    * type `# %%` to split cells
    * type `shift + enter` to run a cell and go to next cell
    * type `ctrl + enter` to run cell (and stay in the same cell)
    * type `help(somefunc)` and execute it to show full docstring

* :notebook: + :ringed_planet: Run a **jupyter notebook in a remote jupyter server**
    * start your jupyter server locally (for instance) by typing `jupyter notebook .`
    * copy the uri and the token generated in the terminal
    * create a new notebook in vscode
    * `F1` -> ` jupyter: specify local or remote server`
    * paste the jupyter server uri with the token in the box
    * click on popup to reload workspace
    * try to run a cell in the notebook
    * on the popup, select the python kernel you want to use
    * you can run the notebook!

    **Warning!** There are several potential issues with using a remote jupyter server: it does not behave as you would expect.
    * You cannot connect to an existing kernel.
    * The lifecycle if bound to your vscode session:
        * When you close your editor, ther kernel will be killed.
        * You cannot execute jobs in the remote jupyter kernel overnight because of this! For such use cases, it is recommended to simply use the standard jupyter notebook/lab interface.
    * See this [github issue](https://github.com/microsoft/vscode-jupyter/issues/1378) for more details and how it should be resolved.

* :hammer::hammer: **Rebuild** a container in vscode devcontainer

    This is needed when you change a dependency, the `Dockerfile` or some setting, etc.
    * `F1` -> select `remote-container: rebuild container`


# Misc
* Add this to the top of a notebook to enable autoreload of python source files
```
%load_ext autoreload"
%autoreload 2
```
* Keep the extensions light in the shared settings to avoid making the environment too heavy
* Do not hardcode the remote jupyter uri in `settings.json`! Not supported anymore for security reasons...

# References
* [vscode-devcontainer-python-cookiecutter](https://github.com/ilyasotkov/vscode-devcontainer-python-cookiecutter)

* [vscode-remote-try-go](https://github.com/microsoft/vscode-remote-try-go)

* [vscode-devcontainer-python-cookiecutter](https://github.com/ilyasotkov/vscode-devcontainer-python-cookiecutter)

* [jupyter-notebooks#_connect-to-a-remote-jupyter-server](https://code.visualstudio.com/docs/datascience/jupyter-notebooks#_connect-to-a-remote-jupyter-server)

* [vscode-jupyter/issues/1378](https://github.com/microsoft/vscode-jupyter/issues/1378)

* [vscode-jupyter/issues/1444](https://github.com/microsoft/vscode-jupyter/issues/1444)

* [remote-python-development-in-visual-studio-code/](https://devblogs.microsoft.com/python/remote-python-development-in-visual-studio-code/)

* [vscode-jupyter/issues/1378](https://github.com/microsoft/vscode-jupyter/issues/1378)

* [docs/datascience/jupyter-notebooks](https://code.visualstudio.com/docs/datascience/jupyter-notebooks)



**Next**
* extend it to allow for a workflow purely from the command line (outside of vscode), so this will be a hybrid template
