<h1>Vortex Scaffold</h1>

A self contained environment for Vortex programs. It includes everything you will need to write and run Vortex programs in one simple environment:

- The Vortex interpreter
- Vortex standard library modules
- Vortex config file
- Basic source directory scaffold
- A run script to launch your application

If you wish to make changes to the scaffolded directory, make sure to update the config file to point to the correct entry point.

To run the program, simply call `./run` in the root directory. This will launch the intepreter with the provided entry point.

<b><i>Note on compatibility: This repository only contains a Mac scaffold. A Windows scaffold will be added in the near future.</i></b>

Simply run the below command in a new directory to scaffold a Vortex environment:

```
curl https://raw.githubusercontent.com/dibsonthis/vortex-dist/main/mac/scaffold | bash
```

Or if you've cloned a scaffolded Vortex repo that does not include the necessary binaries, you can run:

```
curl https://raw.githubusercontent.com/dibsonthis/vortex-dist/main/mac/get_modules | bash
```

To view and compile Vortex source code, including the source code for the provided modules, [visit the official repository](https://github.com/dibsonthis/vortex).