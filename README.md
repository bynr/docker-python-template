# How to develop

## With the command line :keyboard:

* `make build`: build docker container
* `make run HOST_JUPYTER_PORT=8888`: run a jupyterlab server locally and expose it to the port 8888
* `make rm`: remove the notebook container
* `make unittest`: run unittests
* `make unittest TEST_OPTS="-k test_run"`: run only the tests matching the pattern
* `make logs`: show logs
* `make bash`: enter a shell session in the container
* `make lint`: check lint (requires to run `make install-linters`)
* `make fix-lint`: fixes lint errors (requires to run `make install-linters`)
* `make clean`: removes all temporary files (may require sudo)

## With vscode :computer_mouse:

**Pre-requisites**
* Install vscode
* Recent docker version (>17)
* Install vscode remote-containers extension with `code --install-extension ms-vscode-remote.vscode-remote-extensionpack`


**How-to** :book:

* :hammer: **Build** the remote container
  * Clone and open this repository with vscode
  * Open the Command Palette and select **Remote-Containers: Rebuild and Reopen in Container...**
  * Select the root directory of this repo, wait for the container to start, and try things out!

* :scroll: **Show logs**
  * Open the Command Palette → select `Output: Focus on Output View`

* :keyboard: **Open a terminal**
  * Open the Command Palette → select `Terminal: Create New Terminal`

* :pencil2: **Edit** code
  * Open `main.py`
  * Try adding some code and check out the language features.
  * Try auto-complete: hit `cmd+space`

* :runner: **Run** a file
  * Go to `src/play/main.py`
  * Open the Command Palette -> `Python: Run python file in terminal`

* :bug: **Debug**
  * Open `main.py`
  * Add a breakpoint on any line (at the left of a pan, before the line number)
  * Press `F5` to launch the debugger -> select `run the current file in debug mode`
  * Once the breakpoint is hit, try hovering over variables, examining locals, etc.
  * Go to the debug console (in the same pane as the terminal) to directly interract with the variables!

* :heavy_check_mark: **Run** test
  * Go to `tests/test_main.py`
  * Open the Command Palette -> `Test: Run Test at Cursor` to select a single test function
  * To debug a test:
    * set breakpoints
    * Open the Command Palette -> `Test: Debug Test at Cursor`

* :notebook: Run a **jupyter notebook inside the devcontainer**
  * Make sure that `"jupyter.jupyterServerType": "local"` is set in in `.vscode/settings.json`
  * Make sure that your vscode is running in the devcontainer
  * Open the `sample.ipynb` file
  * If requested, select the python interpreter installed in your docker image
  * Select a cell and run it with `ctrl+enter` (same as in usual jupyter notebook webui)

* :repeat: Run a **python interactive window**
  * Go to `main.py`
  * Open the Command Palette -> `Jupyter: Run current file in interactive window`
  * If requested, select the python interpreter installed in your docker image
  * Type `# %%` to split cells in the `main.py`
  * Type `shift + enter` to run a cell and go to next cell
  * Type `ctrl + enter` to run cell (and stay in the same cell)
  * Type `help(somefunc)` and execute it to show full docstring

* :notebook: + :ringed_planet: Run a **jupyter notebook in a remote jupyter server**
  * Make sure that your vscode is **not** running in your decontainer!
  * Start manually your jupyter server locally (for instance) by typing `jupyter notebook .`
  * Copy the uri and the token generated in the terminal
  * Go to `notebooks/sample.ipynb`
  * Open the Command Palette -> `jupyter: specify local or remote server`
  * Paste the jupyter server uri with the token in the box
  * Click on popup to reload workspace
  * Try to run a cell in the notebook
  * On the popup, select the python kernel you want to use
  * You can run the notebook!

  **Warning!** There are several potential issues with using a remote jupyter server: it does not behave as you would expect.
  * You cannot connect to an existing kernel.
  * The lifecycle if bound to your vscode session:
    * When you close your editor, ther kernel will be killed.
    * You cannot execute jobs in the remote jupyter kernel overnight because of this! For such use cases, it is recommended to simply use the standard jupyter notebook/lab interface.
  * See this [github issue](https://github.com/microsoft/vscode-jupyter/issues/1378) for more details and how it should be resolved.

* :hammer::hammer: **Rebuild** a container in vscode devcontainer

    This is needed when you change a dependency, the `Dockerfile`, extensions or some other setting, etc.
  * Open the Command Palette -> select `Remote-Containers: Rebuild Container`
  * Open the Command Palette -> select `Remote-Containers: Rebuild Container without cache`
  * Note that your extensions are also cached in a docker volume by default. To force rebuilding it, delete first the volume with `docker volume rm play-vscode-analytics-extensions-cache-volume` (the volume is declared in `settings.json`). [Doc](https://code.visualstudio.com/remote/advancedcontainers/avoid-extension-reinstalls).


# Tips
* Auto-generate docstring for functions by typing `"""` and then `Enter`.
* Add this to the top of a notebook to enable autoreload of python source files
```
%load_ext autoreload
%autoreload 2
```
* If a file is slow to save, try disabling the actions on save such as formatting, linting, etc. in the `settings.json`
* To improve build time, you may enable `DOCKER_BUILDKIT=1` in your environment or in the Docker Desktop app
* Type `F8` to cycle through errors

# References

* Boostrapped thanks to this [vscode-devcontainer-python-cookiecutter](https://github.com/ilyasotkov/vscode-devcontainer-python-cookiecutter)
* Vscode documentation:
  * [remote-container](https://code.visualstudio.com/docs/remote/containers)
  * [remote-python-development](https://devblogs.microsoft.com/python/remote-python-development-in-visual-studio-code/)
  * [vscode-jupyter-notebooks](https://code.visualstudio.com/docs/datascience/jupyter-notebooks)
  * [how-to-connect-to-a-remote-jupyter-server](https://code.visualstudio.com/docs/datascience/jupyter-notebooks#_connect-to-a-remote-jupyter-server)
  * [python-testing](https://code.visualstudio.com/docs/python/testing)
