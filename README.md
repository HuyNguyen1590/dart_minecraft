dart_minecraft
==============

[![Pub Package](https://img.shields.io/pub/v/dart_minecraft.svg?style=for-the-badge&logo=Dart)](https://pub.dev/packages/dart_minecraft)
[![GitHub Issues](https://img.shields.io/github/issues/spnda/dart_minecraft.svg?style=for-the-badge&logo=GitHub)](https://github.com/spnda/dart_minecraft/issues)
[![GitHub Stars](https://img.shields.io/github/stars/spnda/dart_minecraft.svg?style=for-the-badge&logo=GitHub)](https://github.com/spnda/dart_minecraft/stargazers)
[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge&logo=GitHub)](https://raw.githubusercontent.com/spnda/dart_minecraft/main/LICENSE)

A simple Dart library for interfacing with the Mojang and Minecraft APIs.

Examples
--------

### Skin/Cape of a player

```dart
void main() async {
    Pair player = await Mojang.getUuid('<your username>');
    Profile profile = await Mojang.getProfile(player.getSecond);
    String url = profile.textures.getSkinUrl();
}
```

### Name history of a player

```dart
void main() async {
    Pair uuid = await Mojang.getUuid('<your username>');
    List<Name> history = await Mojang.getNameHistory(uuid.getSecond);
    history.forEach((name) => print(name.name));
}
```

### Reading NBT data

```dart
void main() async {
    // You can create a NbtFile object from a File object or
    // from a String path.
    final nbtFile = NbtFile.fromFile(File('yourfile.nbt'));
    await nbtFile.readFile();
    NbtCompound rootNode = nbtFile.root;
    // You can now read information from your [rootNode].
    // for example, rootNode[0] will return the first child,
    // if present.
}
```

### Pinging a server

```dart
void main() async {
	/// Pinging a server and getting its basic information is 
	/// as easy as that.
	final server = await ping('mc.hypixel.net');
	if (server == null || server.response == null) return;
	print('Latency: ${server.ping}');
	final players = ping.response!.players;
	print('${players.online} / ${players.max}'); // e.g. 5 / 20
}
```

Planned
--------

- [x] Support for all the Minecraft and Minecraft Launcher APIs.
- [x] Support for reading and writing NBT files.
- [x] Support for seeing Minecraft Servers.

License
--------

The MIT License, see [LICENSE](https://github.com/spnda/dart_minecraft/raw/main/LICENSE).
