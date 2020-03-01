import 'src/with_provider/main.dart' as var1;
import 'src/bloc/main.dart' as bloc;
void main() {
  final flavor = Architecture.bloc;
  print('\n\n======== Running: $flavor ========\n\n');

  switch (flavor) {
    case Architecture.provider:
      var1.main();
      break;
    case Architecture.bloc:
      bloc.main();
      break;
  }
}

enum Architecture {
  provider,
  bloc,
}