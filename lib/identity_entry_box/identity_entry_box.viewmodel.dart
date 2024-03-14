import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/key_dto.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:shared/component_base_model.dart';

class IdentityEntryBoxViewModel extends ComponentBaseModel {
  late IIdentityManager _identityManager;
  late IlocalStorage _storage;

  final KeyDto keyData;
  late String _name;
  bool _isSaving = false;

  IdentityEntryBoxViewModel(super.context, this.keyData) {
    _identityManager = getIt.get<IIdentityManager>();
    _storage = getIt.get<IlocalStorage>();
  }

  onNameChanged(String name) {
    _name = name;
  }

  Future onSave() async {
    if (_isSaving) return;

    _isSaving = true;

    var id = await _storage.generateId();
    var result = await _identityManager.setSecret(
      StoredIdentity(
        id,
        _name,
        keyData.publicKey,
        keyData.privateKey,
      ),
    );

    if (!result) {
      throw BaseException(
        // ignore: use_build_context_synchronously
        context: pageContext,
        message: "Failed to create identity",
      );
    }

    //Notify observers
    observer.getObserver("on_sync_event", null);
    observer.getObserver(
      "reload_passwords",
      null,
    );
  }
}
