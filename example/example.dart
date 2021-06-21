import 'dart:io';

import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:dart_minecraft/src/mojang_api.dart';

Future<int> main() async {
  /// In this example we'll read content from a NBT File
  /// which in its root compound has a single NbtString that
  /// contains a UUID of a player we'll try and get the skin texture from.
  final nbtFile = NbtFile.fromPath('./example/data.nbt');
  try {
    await nbtFile.readFile();
  } on FileSystemException catch (e) {
    print(e);
    return -1;
  } on NbtFileReadException {
    print('Failed to read data.nbt');
  }

  /// If the file doesn't exist we'll instead use some example data.
  /// This shows how one would create nbt data using this package.
  nbtFile.root ??= NbtCompound(
    name: '',
    children: [
      NbtString(
        name: 'uuid',
        value: '069a79f444e94726a5befca90e38aaf5', // This is Notch's UUID.
      ),
    ],
  );

  final nbtString = nbtFile.root!.first as NbtString?;

  /// Now with our UUID, we can get the profile of given UUID.
  /// This will allow us to get their profile, which contains the
  /// textures.
  if (nbtString == null) return -1;
  final profile = await getProfile(nbtString.value);
  final skinUrl = profile.textures.getSkinUrl();
  print("Notch's Skin URL: $skinUrl"); // URL to Notch's skin texture.

  /// As we've now got the URL for the texture, we'll write the link to
  /// it to our previously read nbt file and re-write it to the file.
  nbtFile.root!.removeWhere((tag) => tag.name == 'skinUrl');
  nbtFile.root!.add(NbtString(name: 'skinUrl', value: skinUrl));
  await nbtFile.writeFile();
  return 0;
}
