# Flutter Version Management

## Deleting the global Flutter SDK

To delete a globally installed Flutter SDK, follow the [Uninstall Flutter](https://docs.flutter.dev/install/uninstall) page.
Below are a few useful commands for determining the install location of Flutter across different terminals.

### Command Prompt

```cmd
where flutter
```

### PowerShell

```powershell
Get-Command flutter
```

### Bash

```bash
which flutter
```

Or

```bash
sudo find / -name flutter
```

## Setting up Flutter using Flutter Version Manager (FVM)

### Checking FVM installation

To set up FVM for this project, you first need to have FVM installed.
To check if you have installed FVM, run the following command in your terminal of choice:

```bash
fvm --version
```

This command should return a version number like shown below.
If this is not the case, you will need to install FVM.

### Installing FVM

To install FVM, follow the instructions on the [FVM Installation Guide](https://fvm.app/documentation/getting-started/installation).

### Installing Flutter

To install the correct Flutter version for this project, run the command below and wait for FVM to install the Flutter SDK.

```bash
fvm install
```

This will install the Flutter SDK and Dart within the project. The Flutter and Dart CLI can then be used using their FVM proxies:

```bash
fvm flutter
fvm dart
```

## Switching Flutter versions using Flutter Version Manager (FVM)

To switch between different Flutter versions using FVM, you can use the following command:

```bash
fvm use <version> --force
```

Other users can then install the new flutter version. See [Installing Flutter](#installing-flutter) for more information.