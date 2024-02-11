import 'dart:convert';

import 'package:domain/converters/binary_converter.dart';
import 'package:domain/models/http_request.dart';
import 'package:domain/models/signature_event.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:infrastructure/interfaces/isignature_store.dart';
import 'package:cryptography/src/cryptography/signature.dart';
import 'package:shared/component_base_model.dart';

class ManualSignBoxViewModel extends ComponentBaseModel {
  late ISignatureService _signatureService;
  late IHttpProviderService _providerService;
  late ISignatureStore _store;
  late ISecretManager _secretManager;
  Function onSaveCallback;
  StoredIdentity identity;
  String _message = "";
  String get message => _message;

  late String _data;

  Signature? _signature = null;
  Signature? get signature => _signature;

  String _url = "";
  String _bearer = "";
  late SignatureEvent _event;
  ManualSignBoxViewModel(super.context, this.identity, this.onSaveCallback) {
    _signatureService = getIt.get<ISignatureService>();
    _store = getIt.get<ISignatureStore>();
    _secretManager = getIt.get<ISecretManager>();
  }

  bool _advanced = false;
  get advanced => _advanced;

  onMessageChanged(String message) {
    _message = message;
  }

  onDataChanged(String data) {
    _data = data;
  }

  void onSave() async {
    var getKeyData = await _signatureService.importKeyPair(
      identity.publicKey,
      identity.privateKey,
    );

    _signature = await _signatureService.signMessage(getKeyData, _message);

    _event = SignatureEvent(
      identity.publicKey,
      BianaryConverter.toHex(_signature!.bytes),
      _message,
      _data,
      "",
    );
    notifyListeners();
  }

  onAdvancedPressed() {
    _advanced = true;
    notifyListeners();
  }

  onCopySignature() {
    var data = BianaryConverter.toHex(_signature!.bytes);
    _secretManager.copySensitiveData(data);
  }

  onCopyPublic() {
    _secretManager.copySensitiveData(identity.publicKey);
  }

  onUrlChanged(String url) {
    _url = url;
  }

  onBearerChanged(String bearer) {
    _bearer = bearer;
  }

  onClose() {
    _event.url = "Manual Signature";
    _store.add(_event);

    onSaveCallback.call();
  }

  onSend() async {
    _event.url = _url;
    var result = await _providerService.postRequest(
      HttpRequest(
        _url,
        _advanced ? {"Authorized": "Bearer ${_bearer}"} : {},
        jsonEncode({
          "signature": BianaryConverter.toHex(_signature!.bytes),
          "data": _data,
        }),
      ),
    );
    if (result == null || result.statusCode == 200) {
      //TODO log errors
    }
    _store.add(_event);
    onSaveCallback.call();
  }
}
